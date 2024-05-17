import 'models/models.dart';

abstract interface class OrderRepositoryInterface {
  Order getOrder();
  Future<void> addToOrder(ToolOrder tool);
  Future<void> removeFromOrder(ToolOrder tool);
  Future<void> clearOrder();
}
