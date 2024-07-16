import 'dart:io';

String getMobileImage(File profilePicture) {
  return File(
    profilePicture.path,
  ).toString();
}
