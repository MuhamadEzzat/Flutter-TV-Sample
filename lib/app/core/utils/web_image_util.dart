import 'dart:async';
import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;

Future<html.File?> pickWebFile() async {
  final completer = Completer<List<html.File>?>();
  final input = html.FileUploadInputElement() as html.InputElement;
  input.accept = 'image/*';

  var changeEventTriggered = false;
  void changeEventListener(html.Event e) {
    if (changeEventTriggered) return;
    changeEventTriggered = true;

    final files = input.files!;
    final resultFuture = files.map<Future<html.File>>((file) async {
      final reader = html.FileReader();
      reader.readAsDataUrl(file);
      reader.onError.listen(completer.completeError);
      return file;
    });
    Future.wait(resultFuture).then((results) => completer.complete(results));
  }

  // Cancel event management inspired by:
  // https://github.com/miguelpruivo/flutter_file_picker/blob/master/lib/src/file_picker_web.dart
  void cancelledEventListener(html.Event e) {
    html.window.removeEventListener('focus', cancelledEventListener);

    // This listener is called before the input changed event,
    // and the `uploadInput.files` value is still null
    // Wait for results from js to dart
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      if (!changeEventTriggered) {
        changeEventTriggered = true;
        completer.complete(null);
      }
    });
  }

  input.onChange.listen(changeEventListener);
  input.addEventListener('change', changeEventListener);

  // Listen focus event for cancelled
  html.window.addEventListener('focus', cancelledEventListener);

  input.click();

  // Need to append on mobile Safari.
  html.document.body!.append(input);

  final results = await completer.future;
  if (results == null || results.isEmpty) return null;
  return results.first;
}

Future<Uint8List> asBytes(html.File file) async {
  final bytesFile = Completer<List<int>>();
  final reader = html.FileReader();
  reader.onLoad.listen(
      (event) => bytesFile.complete(reader.result as FutureOr<List<int>>?));
  reader.readAsArrayBuffer(file);
  return Uint8List.fromList(await bytesFile.future);
}
