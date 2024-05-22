import 'dart:developer';

import 'package:realm/realm.dart';
import 'package:rentool/repositories/repositories.dart';

class OrderAddressRepository implements OrderAddressRepositoryInterface {
  OrderAddressRepository({
    required this.realm,
  });

  final Realm realm;

  @override
  Future<void> clearOrderAddress() async {
    try {
      realm.write(() => realm.deleteAll<OrderAddress>());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> createOrReplaceOrderAddress(OrderAddress orderAddress) async {
    try {
      OrderAddress? orderExisting = realm
          .all<OrderAddress>()
          .where((e) => e.id == orderAddress.id)
          .firstOrNull;

      orderExisting != null
          ? realm.write(() {
              realm.delete<OrderAddress>(orderExisting);
              realm.add<OrderAddress>(orderAddress);
            })
          : realm.write(() {
              realm.add<OrderAddress>(orderAddress);
            });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  OrderAddress? getOrderAddress() {
    return realm.all<OrderAddress>().firstOrNull;
  }
}
