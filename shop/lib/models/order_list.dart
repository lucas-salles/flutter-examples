import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/models/cart.dart';
import 'package:shop/models/cart_item.dart';
import 'package:shop/models/order.dart';
import 'package:shop/utils/constants.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get items => [..._items];

  int get itemsCount => _items.length;

  Future<void> loadOrders() async {
    _items.clear();

    final response = await http.get(
      Uri.parse("${Constants.ORDER_BASE_URL}.json"),
    );
    Map<String, dynamic>? data = jsonDecode(response.body);
    if (data == null) return;
    data.forEach((orderId, orderData) {
      _items.add(
        Order(
          id: orderId,
          total: orderData["total"],
          date: DateTime.parse(orderData["date"]),
          products: (orderData["products"] as List<dynamic>).map((item) {
            return CartItem(
              id: item["id"],
              productId: item["productId"],
              name: item["name"],
              quantity: item["quantity"],
              price: item["price"],
            );
          }).toList(),
        ),
      );
    });
    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    final response = await http.post(
      Uri.parse("${Constants.ORDER_BASE_URL}.json"),
      body: jsonEncode({
        "total": cart.totalAmount,
        "date": date.toIso8601String(),
        "products": cart.items.values
            .map((cartItem) => {
                  "id": cartItem.id,
                  "productId": cartItem.productId,
                  "name": cartItem.name,
                  "quantity": cartItem.quantity,
                  "price": cartItem.price,
                })
            .toList(),
      }),
    );

    final id = jsonDecode(response.body)["name"];
    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        date: date,
        products: cart.items.values.toList(),
      ),
    );
    notifyListeners();
  }
}
