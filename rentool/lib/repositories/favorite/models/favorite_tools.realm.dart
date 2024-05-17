// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_tools.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class BrandFavorite extends _BrandFavorite
    with RealmEntity, RealmObjectBase, RealmObject {
  BrandFavorite(
    int id,
    String name,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  BrandFavorite._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<BrandFavorite>> get changes =>
      RealmObjectBase.getChanges<BrandFavorite>(this);

  @override
  Stream<RealmObjectChanges<BrandFavorite>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<BrandFavorite>(this, keyPaths);

  @override
  BrandFavorite freeze() => RealmObjectBase.freezeObject<BrandFavorite>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
    };
  }

  static EJsonValue _toEJson(BrandFavorite value) => value.toEJson();
  static BrandFavorite _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
      } =>
        BrandFavorite(
          fromEJson(id),
          fromEJson(name),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(BrandFavorite._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, BrandFavorite, 'BrandFavorite', [
      SchemaProperty('id', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class CategoryFavorite extends _CategoryFavorite
    with RealmEntity, RealmObjectBase, RealmObject {
  CategoryFavorite(
    int id,
    String name,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
  }

  CategoryFavorite._();

  @override
  int get id => RealmObjectBase.get<int>(this, 'id') as int;
  @override
  set id(int value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  Stream<RealmObjectChanges<CategoryFavorite>> get changes =>
      RealmObjectBase.getChanges<CategoryFavorite>(this);

  @override
  Stream<RealmObjectChanges<CategoryFavorite>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<CategoryFavorite>(this, keyPaths);

  @override
  CategoryFavorite freeze() =>
      RealmObjectBase.freezeObject<CategoryFavorite>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
    };
  }

  static EJsonValue _toEJson(CategoryFavorite value) => value.toEJson();
  static CategoryFavorite _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
      } =>
        CategoryFavorite(
          fromEJson(id),
          fromEJson(name),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CategoryFavorite._);
    register(_toEJson, _fromEJson);
    return SchemaObject(
        ObjectType.realmObject, CategoryFavorite, 'CategoryFavorite', [
      SchemaProperty('id', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class ToolFavorite extends _ToolFavorite
    with RealmEntity, RealmObjectBase, RealmObject {
  ToolFavorite(
    String id,
    String model,
    String description,
    int priceDay,
    int count,
    String imageUrl, {
    CategoryFavorite? category,
    BrandFavorite? brand,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'brand', brand);
    RealmObjectBase.set(this, 'model', model);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'priceDay', priceDay);
    RealmObjectBase.set(this, 'count', count);
    RealmObjectBase.set(this, 'imageUrl', imageUrl);
  }

  ToolFavorite._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  CategoryFavorite? get category =>
      RealmObjectBase.get<CategoryFavorite>(this, 'category')
          as CategoryFavorite?;
  @override
  set category(covariant CategoryFavorite? value) =>
      RealmObjectBase.set(this, 'category', value);

  @override
  BrandFavorite? get brand =>
      RealmObjectBase.get<BrandFavorite>(this, 'brand') as BrandFavorite?;
  @override
  set brand(covariant BrandFavorite? value) =>
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
  String get imageUrl =>
      RealmObjectBase.get<String>(this, 'imageUrl') as String;
  @override
  set imageUrl(String value) => RealmObjectBase.set(this, 'imageUrl', value);

  @override
  Stream<RealmObjectChanges<ToolFavorite>> get changes =>
      RealmObjectBase.getChanges<ToolFavorite>(this);

  @override
  Stream<RealmObjectChanges<ToolFavorite>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<ToolFavorite>(this, keyPaths);

  @override
  ToolFavorite freeze() => RealmObjectBase.freezeObject<ToolFavorite>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'category': category.toEJson(),
      'brand': brand.toEJson(),
      'model': model.toEJson(),
      'description': description.toEJson(),
      'priceDay': priceDay.toEJson(),
      'count': count.toEJson(),
      'imageUrl': imageUrl.toEJson(),
    };
  }

  static EJsonValue _toEJson(ToolFavorite value) => value.toEJson();
  static ToolFavorite _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'category': EJsonValue category,
        'brand': EJsonValue brand,
        'model': EJsonValue model,
        'description': EJsonValue description,
        'priceDay': EJsonValue priceDay,
        'count': EJsonValue count,
        'imageUrl': EJsonValue imageUrl,
      } =>
        ToolFavorite(
          fromEJson(id),
          fromEJson(model),
          fromEJson(description),
          fromEJson(priceDay),
          fromEJson(count),
          fromEJson(imageUrl),
          category: fromEJson(category),
          brand: fromEJson(brand),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(ToolFavorite._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, ToolFavorite, 'ToolFavorite', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('category', RealmPropertyType.object,
          optional: true, linkTarget: 'CategoryFavorite'),
      SchemaProperty('brand', RealmPropertyType.object,
          optional: true, linkTarget: 'BrandFavorite'),
      SchemaProperty('model', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('priceDay', RealmPropertyType.int),
      SchemaProperty('count', RealmPropertyType.int),
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

class Favorites extends _Favorites
    with RealmEntity, RealmObjectBase, RealmObject {
  Favorites(
    String id, {
    Iterable<ToolFavorite> tools = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set<RealmList<ToolFavorite>>(
        this, 'tools', RealmList<ToolFavorite>(tools));
  }

  Favorites._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  RealmList<ToolFavorite> get tools =>
      RealmObjectBase.get<ToolFavorite>(this, 'tools')
          as RealmList<ToolFavorite>;
  @override
  set tools(covariant RealmList<ToolFavorite> value) =>
      throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<Favorites>> get changes =>
      RealmObjectBase.getChanges<Favorites>(this);

  @override
  Stream<RealmObjectChanges<Favorites>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<Favorites>(this, keyPaths);

  @override
  Favorites freeze() => RealmObjectBase.freezeObject<Favorites>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'tools': tools.toEJson(),
    };
  }

  static EJsonValue _toEJson(Favorites value) => value.toEJson();
  static Favorites _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'tools': EJsonValue tools,
      } =>
        Favorites(
          fromEJson(id),
          tools: fromEJson(tools),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(Favorites._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, Favorites, 'Favorites', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('tools', RealmPropertyType.object,
          linkTarget: 'ToolFavorite', collectionType: RealmCollectionType.list),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
