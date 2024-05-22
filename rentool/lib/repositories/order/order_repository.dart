import 'dart:developer';

import 'package:realm/realm.dart';
import 'package:rentool/repositories/repositories.dart';

class OrderRepository implements OrderRepositoryInterface {
  OrderRepository({
    required this.realm,
  });

  final Realm realm;

  @override
  Order getOrder() {
    Order? oreders = realm.all<Order>().firstOrNull;
    if (oreders == null) {
      realm.write(() => realm.add(Order('0')));
    }
    return realm.all<Order>().first;
  }

  @override
  Future<void> addToOrder(ToolOrder tool) async {
    try {
      ToolOrder? toolExisting =
          realm.all<ToolOrder>().where((e) => e.id == tool.id).firstOrNull;

      toolExisting != null
          ? realm.write(() {
              realm.delete<ToolOrder>(toolExisting);
              final order = getOrder();
              order.tools.add(tool);
            })
          : realm.write(() {
              final order = getOrder();
              order.tools.add(tool);
            });
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> clearOrder() async {
    try {
      realm.write(() => realm.deleteAll<ToolOrder>());
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> removeFromOrder(ToolOrder tool) async {
    try {
      ToolOrder? toolExisting =
          realm.all<ToolOrder>().where((e) => e.id == tool.id).firstOrNull;
      if (toolExisting != null) {
        realm.write(() {
          final order = getOrder();
          order.tools.add(tool);
          realm.delete<ToolOrder>(toolExisting);
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
