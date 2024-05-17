import 'models/models.dart';

abstract interface class FavoriteRepositoryInterface {
  Favorites getFavorites();
  Future<void> createOrDeleteTool(ToolFavorite tool);
  Future<void> clearFavorites();
}
