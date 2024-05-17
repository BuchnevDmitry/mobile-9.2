// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_tools.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class BrandOrder extends _BrandOrder
    with RealmEntity, RealmObjectBase, RealmObject {
  BrandOrder(
    int id,
    String name,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  BrandOrder._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<BrandOrder>> get changes =>
      RealmObjectBase.getChanges<BrandOrder>(this);

  @override
  Stream<RealmObjectChanges<BrandOrder>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<BrandOrder>(this, keyPaths);

  @override
  BrandOrder freeze() => RealmObjectBase.freezeObject<BrandOrder>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
    };
  }

  static EJsonValue _toEJson(BrandOrder value) => value.toEJson();
  static BrandOrder _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
      } =>
        BrandOrder(
          fromEJson(id),
          fromEJson(name),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(BrandOrder._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, BrandOrder, 'BrandOrder', [
      SchemaProperty('id', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class CategoryOrder extends _CategoryOrder
    with RealmEntity, RealmObjectBase, RealmObject {
  CategoryOrder(
    int id,
    String name,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  CategoryOrder._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<CategoryOrder>> get changes =>
      RealmObjectBase.getChanges<CategoryOrder>(this);

  @override
  Stream<RealmObjectChanges<CategoryOrder>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<CategoryOrder>(this, keyPaths);

  @override
  CategoryOrder freeze() => RealmObjectBase.freezeObject<CategoryOrder>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
    };
  }

  static EJsonValue _toEJson(CategoryOrder value) => value.toEJson();
  static CategoryOrder _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
      } =>
        CategoryOrder(
          fromEJson(id),
          fromEJson(name),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CategoryOrder._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, CategoryOrder, 'CategoryOrder', [
      SchemaProperty('id', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class ToolOrder extends _ToolOrder
    with RealmEntity, RealmObjectBase, RealmObject {
  ToolOrder(
    String id,
    String model,
    String description,
    int priceDay,
    int count,
    int userCount,
    String imageUrl, {
    CategoryOrder? category,
    BrandOrder? brand,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'brand', brand);
    RealmObjectBase.set(this, 'model', model);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'priceDay', priceDay);
    RealmObjectBase.set(this, 'count', count);
    RealmObjectBase.set(this, 'userCount', userCount);
    RealmObjectBase.set(this, 'imageUrl', imageUrl);
  }

  ToolOrder._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  CategoryOrder? get category =>
      RealmObjectBase.get<CategoryOrder>(this, 'category') as CategoryOrder?;
  @override
  set category(covariant CategoryOrder? value) =>
      RealmObjectBase.set(this, 'category', value);

  @override
  BrandOrder? get brand =>
      RealmObjectBase.get<BrandOrder>(this, 'brand') as BrandOrder?;
  @override
  set brand(covariant BrandOrder? value) =>
      RealmObjectBase.set(this, 'brand', value);

  @override
  String get model => RealmObjectBase.get<String>(this, 'model') as String;
  @override
  set model(String value) => RealmObjectBase.set(this, 'model', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  int get priceDay => RealmObjectBase.get<int>(this, 'priceDay') as int;
  @override
  set priceDay(int value) => RealmObjectBase.set(this, 'priceDay', value);

  @override
  int get count => RealmObjectBase.get<int>(this, 'count') as int;
  @override
  set count(int value) => RealmObjectBase.set(this, 'count', value);

  @override
  int get userCount => RealmObjectBase.get<int>(this, 'userCount') as int;
  @override
  set userCount(int value) => RealmObjectBase.set(this, 'userCount', value);

  @override
  String get imageUrl =>
      RealmObjectBase.get<String>(this, 'imageUrl') as String;
  @override
  set imageUrl(String value) => RealmObjectBase.set(this, 'imageUrl', value);

  @override
  Stream<RealmObjectChanges<ToolOrder>> get changes =>
      RealmObjectBase.getChanges<ToolOrder>(this);

  @override
  Stream<RealmObjectChanges<ToolOrder>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<ToolOrder>(this, keyPaths);

  @override
  ToolOrder freeze() => RealmObjectBase.freezeObject<ToolOrder>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'category': category.toEJson(),
      'brand': brand.toEJson(),
      'model': model.toEJson(),
      'description': description.toEJson(),
      'priceDay': priceDay.toEJson(),
      'count': count.toEJson(),
      'userCount': userCount.toEJson(),
      'imageUrl': imageUrl.toEJson(),
    };
  }

  static EJsonValue _toEJson(ToolOrder value) => value.toEJson();
  static ToolOrder _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'category': EJsonValue category,
        'brand': EJsonValue brand,
        'model': EJsonValue model,
        'description': EJsonValue description,
        'priceDay': EJsonValue priceDay,
        'count': EJsonValue count,
        'userCount': EJsonValue userCount,
        'imageUrl': EJsonValue imageUrl,
      } =>
        ToolOrder(
          fromEJson(id),
          fromEJson(model),
          fromEJson(description),
          fromEJson(priceDay),
          fromEJson(count),
          fromEJson(userCount),
          fromEJson(imageUrl),
          category: fromEJson(category),
          brand: fromEJson(brand),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ToolOrder._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, ToolOrder, 'ToolOrder', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('category', RealmPropertyType.object,
          optional: true, linkTarget: 'CategoryOrder'),
      SchemaProperty('brand', RealmPropertyType.object,
          optional: true, linkTarget: 'BrandOrder'),
      SchemaProperty('model', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('priceDay', RealmPropertyType.int),
      SchemaProperty('count', RealmPropertyType.int),
      SchemaProperty('userCount', RealmPropertyType.int),
      SchemaProperty('imageUrl', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;

  Tool toTool() => Tool(
        id: id,
        model: model,
        description: description,
        priceDay: priceDay,
        count: count,
        imageUrl: imageUrl,
        category: Category(
          id: category!.id,
          name: category!.name,
        ),
        brand: Brand(
          id: brand!.id,
          name: brand!.name,
        ),
      );
}

class Order extends _Order with RealmEntity, RealmObjectBase, RealmObject {
  Order(
    String id, {
    Iterable<ToolOrder> tools = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set<RealmList<ToolOrder>>(
        this, 'tools', RealmList<ToolOrder>(tools));
  }

  Order._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  RealmList<ToolOrder> get tools =>
      RealmObjectBase.get<ToolOrder>(this, 'tools') as RealmList<ToolOrder>;
  @override
  set tools(covariant RealmList<ToolOrder> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Order>> get changes =>
      RealmObjectBase.getChanges<Order>(this);

  @override
  Stream<RealmObjectChanges<Order>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Order>(this, keyPaths);

  @override
  Order freeze() => RealmObjectBase.freezeObject<Order>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'tools': tools.toEJson(),
    };
  }

  static EJsonValue _toEJson(Order value) => value.toEJson();
  static Order _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'tools': EJsonValue tools,
      } =>
        Order(
          fromEJson(id),
          tools: fromEJson(tools),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Order._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Order, 'Order', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('tools', RealmPropertyType.object,
          linkTarget: 'ToolOrder', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
