
import '../../models/ResponseModel.dart';
import 'games_api_provider.dart';

class GamesRepository {
  GamesAPIProvider gamesAPIProvider = GamesAPIProvider();
  Future<ResponseModel> getGames(int? gameCategoryID) async {
    final response = await gamesAPIProvider.getGames(gameCategoryID);
    return ResponseModel.fromResponse(response, 'games');
  }

  Future<ResponseModel> getAllGames() async {
    final response = await gamesAPIProvider.getAllGames();
    return ResponseModel.fromResponse(response, 'results');
  }
}
