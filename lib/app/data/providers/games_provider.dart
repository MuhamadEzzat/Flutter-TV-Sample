import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import '../../core/values/endpoint_constants.dart';
import '../exceptions/network_exception.dart';
import '../models/games_category_model.dart';
import 'app_provider.dart';

class GamesProvider extends AppProvider {
  Future<List<GameCategoryModel>> getGamesCategory() async {
    Response<dynamic> result;

    do {
      result = await handleNetworkError(get(
          EndPoints.GET_ALL_CATEGORIES_OF_GAMES,
          decoder: (json) => GameCategoryModel.fromJson(json)));
    } while (await shouldRetry());
    if (!result.isOk) {
      debugPrint("unhandeled exception: ${result.body.toString()}");
      throw NetworkException(result);
    }

    return result.body;
  }
}
