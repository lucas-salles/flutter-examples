import 'package:flutter/material.dart';
import 'package:ta_caro/modules/feed/repositories/feed_repository.dart';
import 'package:ta_caro/shared/models/order_model.dart';
import 'package:ta_caro/shared/models/product_model.dart';
import 'package:ta_caro/shared/utils/app_state.dart';

class FeedController extends ChangeNotifier {
  final FeedRepository repository;

  AppState state = AppState.empty();

  FeedController({required this.repository});

  void update(AppState state) {
    this.state = state;
    notifyListeners();
  }

  List<OrderModel> get orders => state.when(
        success: (value) => value,
        orElse: () => [],
      );

  double get sumTotal {
    var sum = 0.0;
    for (var order in orders) {
      sum += order.price;
    }
    return sum;
  }

  List<ProductModel> get products {
    final products = <ProductModel>[];
    for (var order in orders) {
      final product = ProductModel(
        name: order.name,
        lastPrice: 0,
        currentPrice: order.price,
      );
      final index =
          products.indexWhere((element) => element.name == product.name);
      if (index != -1) {
        final currentProduct = products[index];
        products[index] = currentProduct.copyWith(lastPrice: order.price);
      } else {
        products.add(product);
      }
    }
    return products;
  }

  double calcChart(List<ProductModel> products) {
    var up = 0.0;
    var down = 0.0;
    for (var product in products) {
      if (product.currentPrice < product.lastPrice) {
        up += 1;
      } else {
        down += 1;
      }
    }
    final result = down / up;
    if (result > 1) {
      return 1;
    }
    return result;
  }

  Future<void> getData() async {
    try {
      update(AppState.loading());
      final response = await repository.getAll();
      update(AppState.success<List<OrderModel>>(response));
    } catch (e) {
      update(AppState.error(e.toString()));
    }
  }
}
