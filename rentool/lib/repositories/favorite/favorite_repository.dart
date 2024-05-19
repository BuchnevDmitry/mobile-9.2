import 'dart:developer';

import 'package:realm/realm.dart';
import 'package:rentool/repositories/repositories.dart';

class FavoriteRepository implements FavoriteRepositoryInterface {
  FavoriteRepository({
    required this.realm,
  });

  final Realm realm;

  @override
  Future<void> clearFavorites() async {
    try {
      realm.write(() => realm.deleteAll<ToolFavorite>());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> createOrDeleteTool(ToolFavorite tool) async {
    try {
      ToolFavorite? toolExisting =
          realm.all<ToolFavorite>().where((e) => e.id == tool.id).firstOrNull;

      toolExisting != null
          ? realm.write(() {
              realm.delete<ToolFavorite>(toolExisting);
            })
          : realm.write(() {
              final favorites = getFavorites();
              favorites.tools.add(tool);
            });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Favorites getFavorites() {
    Favorites? favorites = realm.all<Favorites>().firstOrNull;
    if (favorites == null) {
      realm.write(() => realm.add(Favorites('0')));
    }
    return realm.all<Favorites>().first;
  }
}
