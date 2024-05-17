import 'package:realm/realm.dart';
import 'package:rentool/api/api.dart';

part 'order_tools.realm.dart';

@RealmModel()
class _BrandOrder {
  late int id;
  late String name;

  @override
  String toString() => 'Brand{id: $id, name: $name}';
}

@RealmModel()
class _CategoryOrder {
  late int id;
  late String name;

  @override
  String toString() => 'Category{id: $id, name: $name}';
}

@RealmModel()
class _ToolOrder {
  @PrimaryKey()
  late String id;

  late _CategoryOrder? category;
  late _BrandOrder? brand;
  late String model;
  late String description;
  late int priceDay;
  late int count;
  late int userCount;
  late String imageUrl;

  @override
  String toString() =>
      'Tool{id: $id, category: $category, brand: $brand, model: $model, description: $description, priceDay: $priceDay, count: $count, userCount: $userCount, imageUrl: $imageUrl,}';
}

@RealmModel()
class _Order {
  @PrimaryKey()
  late String id;

  late List<_ToolOrder> tools;

  @override
  String toString() => 'Orders{id: $id,, tools: $tools}';
}
