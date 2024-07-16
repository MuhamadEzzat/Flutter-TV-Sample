import 'package:dio/dio.dart';

import '../../../core/values/endpoint_constants.dart';
import '../../services/dio_client.dart';

class GamesAPIProvider {
  final DioClient _dioClient = DioClient.instance;

  Future<Response?> getGames(int? gameCategoryID) async {
    try {
      Map<String, dynamic> queryParam = {"ID": gameCategoryID.toString()};
      print('id is $gameCategoryID');
      Response response = await _dioClient.get(EndPoints.GET_GAMES_CHILDS,
          queryParameters: queryParam);
      print(response.data);
      return response;
    } catch (error) {
      print("Exception: $error");
      return null;
    }
  }

  Future<Response?> getAllGames() async {
    try {
      Response response = await _dioClient.get(EndPoints.GET_GAMES);
      print(response.data);
      return response;
    } catch (error) {
      print("Exception: $error");
      return null;
    }
  }
}
