// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_address.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class OrderAddress extends _OrderAddress
    with RealmEntity, RealmObjectBase, RealmObject {
  OrderAddress(
    String id,
    int type,
    String address,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'type', type);
    RealmObjectBase.set(this, 'address', address);
  }

  OrderAddress._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  int get type => RealmObjectBase.get<int>(this, 'type') as int;
  @override
  set type(int value) => RealmObjectBase.set(this, 'type', value);

  @override
  String get address => RealmObjectBase.get<String>(this, 'address') as String;
  @override
  set address(String value) => RealmObjectBase.set(this, 'address', value);

  @override
  Stream<RealmObjectChanges<OrderAddress>> get changes =>
      RealmObjectBase.getChanges<OrderAddress>(this);

  @override
  Stream<RealmObjectChanges<OrderAddress>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<OrderAddress>(this, keyPaths);

  @override
  OrderAddress freeze() => RealmObjectBase.freezeObject<OrderAddress>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'type': type.toEJson(),
      'address': address.toEJson(),
    };
  }

  static EJsonValue _toEJson(OrderAddress value) => value.toEJson();
  static OrderAddress _fromEJson(EJsonValue ejson) {
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'type': EJsonValue type,
        'address': EJsonValue address,
      } =>
        OrderAddress(
          fromEJson(id),
          fromEJson(type),
          fromEJson(address),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(OrderAddress._);
    register(_toEJson, _fromEJson);
    return SchemaObject(ObjectType.realmObject, OrderAddress, 'OrderAddress', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('type', RealmPropertyType.int),
      SchemaProperty('address', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
