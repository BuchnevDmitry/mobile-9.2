import 'package:realm/realm.dart';

part 'order_address.realm.dart';

@RealmModel()
class _OrderAddress {
  @PrimaryKey()
  late String id;

  late int type;

  late String address;

  @override
  String toString() => 'Orders{id: $id, type: $type, address: $address}';
}
