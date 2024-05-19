import 'package:realm/realm.dart';
import 'package:rentool/api/api.dart';

part 'favorite_tools.realm.dart';

@RealmModel()
class _BrandFavorite {
  late int id;
  late String name;

  @override
  String toString() => 'Brand{id: $id, name: $name}';
}

@RealmModel()
class _CategoryFavorite {
  late int id;
  late String name;

  @override
  String toString() => 'Category{id: $id, name: $name}';
}

@RealmModel()
class _ToolFavorite {
  @PrimaryKey()
  late String id;

  late _CategoryFavorite? category;
  late _BrandFavorite? brand;
  late String model;
  late String description;
  late int priceDay;
  late int count;
  late String imageUrl;

  @override
  String toString() =>
      'Tool{id: $id, category: $category, brand: $brand, model: $model, description: $description, priceDay: $priceDay, count: $count, imageUrl: $imageUrl,}';
}

@RealmModel()
class _Favorites {
  @PrimaryKey()
  late String id;

  late List<_ToolFavorite> tools;

  @override
  String toString() => 'Orders{id: $id,, tools: $tools}';
}
