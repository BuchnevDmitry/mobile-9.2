import 'models/models.dart';

abstract interface class OrderAddressRepositoryInterface {
  OrderAddress? getOrderAddress();
  Future<void> createOrReplaceOrderAddress(OrderAddress orderAddress);
  Future<void> clearOrderAddress();
}
