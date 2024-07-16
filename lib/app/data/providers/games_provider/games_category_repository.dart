
import '../../models/ResponseModel.dart';
import 'games_category_api_provider.dart';

class GamesCategoryRepository {
  Future<ResponseModel> getGamesCategory() async {
    final response = await GamesCategoryAPIProvider().getGamesCategory();
    return ResponseModel.fromResponse(response, 'results');
  }
}
