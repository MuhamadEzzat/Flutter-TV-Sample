import 'package:dio/dio.dart';

import '../../../core/values/endpoint_constants.dart';
import '../../services/dio_client.dart';

class GamesCategoryAPIProvider {
  final DioClient _dioClient = DioClient.instance;

  Future<Response?> getGamesCategory() async {
    try {
      Response response =
          await _dioClient.get(EndPoints.GET_ALL_CATEGORIES_OF_GAMES);
      print(response.data);
      return response;
    } catch (error) {
      print("Exception: $error");
      return null;
    }
  }
}
