import 'dart:async';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:bloc/bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'yandex_metrics_event.dart';
part 'yandex_metrics_state.dart';

class YandexMetricsBloc extends Bloc<YandexMetricsEvent, YandexMetricsState> {
  YandexMetricsBloc({required Map<String, String> payload})
      : _payload = payload,
        super(YandexMetricsInitialState()) {
    on<YandexMetricsOpenScreenEvent>(_openScreen);
    on<YandexMetricsViewProductScreenEvent>(_viewProductScreen);
    on<YandexMetricsAddProductToOrderEvent>(_addProductToOrder);
    on<YandexMetricsRemoveProductFromOrderEvent>(_removeProductFromOrder);
  }

  final Map<String, String> _payload;

  FutureOr<void> _openScreen(
    YandexMetricsOpenScreenEvent event,
    Emitter<YandexMetricsState> emit,
  ) async {
    try {
      emit(YandexMetricsSendingState());

      ECommerceScreen screen = ECommerceScreen(
        name: event.screenName,
        payload: _payload,
      );

      ECommerceEvent showScreenEvent = ECommerce.showScreenEvent(screen);
      AppMetrica.reportECommerce(showScreenEvent);

      emit(YandexMetricsSendedState());
    } catch (error) {
      emit(YandexMetricsFailureState(error: error));
    }
  }

  FutureOr<void> _viewProductScreen(
    YandexMetricsViewProductScreenEvent event,
    Emitter<YandexMetricsState> emit,
  ) async {
    try {
      emit(YandexMetricsSendingState());

      ECommerceScreen screen = ECommerceScreen(
        name: event.screenName,
        payload: _payload,
      );

      ECommerceAmount amount = ECommerceAmount(
          amount: Decimal.parse(event.priceDay.toString()), currency: "RUB");

      ECommercePrice actualPrice = ECommercePrice(fiat: amount);

      ECommerceProduct product = ECommerceProduct(
        sku: event.id,
        name: event.model,
        actualPrice: actualPrice,
        payload: _payload,
        categoriesPath: [event.category],
      );

      ECommerceEvent showProductDetailsEvent =
          ECommerce.showProductDetailsEvent(
              product, screen as ECommerceReferrer?);

      AppMetrica.reportECommerce(showProductDetailsEvent);

      emit(YandexMetricsSendedState());
    } catch (error) {
      emit(YandexMetricsFailureState(error: error));
    }
  }

  FutureOr<void> _addProductToOrder(
    YandexMetricsAddProductToOrderEvent event,
    Emitter<YandexMetricsState> emit,
  ) async {
    try {
      emit(YandexMetricsSendingState());

      ECommerceScreen screen = ECommerceScreen(
        name: event.screenName,
        payload: _payload,
      );

      ECommerceAmount amount = ECommerceAmount(
          amount: Decimal.parse("${event.priceDay}"), currency: "RUB");

      ECommercePrice actualPrice = ECommercePrice(fiat: amount);

      ECommerceProduct product = ECommerceProduct(
        sku: event.id,
        name: event.model,
        actualPrice: actualPrice,
        payload: _payload,
        categoriesPath: [event.category],
      );

      ECommerceCartItem addedItems = ECommerceCartItem(
        product: product,
        revenue: actualPrice,
        quantity: Decimal.parse("${event.quantity}"),
      );

      ECommerceEvent addCartItemEvent = ECommerce.addCartItemEvent(addedItems);
      AppMetrica.reportECommerce(addCartItemEvent);

      emit(YandexMetricsSendedState());
    } catch (error) {
      emit(YandexMetricsFailureState(error: error));
    }
  }

  FutureOr<void> _removeProductFromOrder(
    YandexMetricsRemoveProductFromOrderEvent event,
    Emitter<YandexMetricsState> emit,
  ) async {
    try {
      emit(YandexMetricsSendingState());

      ECommerceScreen screen = ECommerceScreen(
        name: event.screenName,
        payload: _payload,
      );

      ECommerceAmount amount = ECommerceAmount(
          amount: Decimal.parse("${event.priceDay}"), currency: "RUB");

      ECommercePrice actualPrice = ECommercePrice(fiat: amount);

      ECommerceProduct product = ECommerceProduct(
        sku: event.id,
        name: event.model,
        actualPrice: actualPrice,
        payload: _payload,
        categoriesPath: [event.category],
      );

      ECommerceCartItem addedItems = ECommerceCartItem(
        product: product,
        revenue: actualPrice,
        quantity: Decimal.parse("${event.quantity}"),
      );

      ECommerceEvent removeCartItemEvent =
          ECommerce.removeCartItemEvent(addedItems);
      AppMetrica.reportECommerce(removeCartItemEvent);

      emit(YandexMetricsSendedState());
    } catch (error) {
      emit(YandexMetricsFailureState(error: error));
    }
  }
}
