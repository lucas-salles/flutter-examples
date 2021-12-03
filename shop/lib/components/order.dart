import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/models/order.dart';

class OrderWidget extends StatelessWidget {
  final Order order;

  const OrderWidget({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Card(
    //   child: ListTile(
    //     title: Text("R\$ ${order.total.toStringAsFixed(2)}"),
    //     subtitle: Text(
    //       DateFormat("dd/MM/yyyy HH:mm").format(order.date),
    //     ),
    //     trailing: IconButton(
    //       onPressed: () {},
    //       icon: const Icon(Icons.expand_more),
    //     ),
    //   ),
    // );
    return Card(
      child: ExpansionTile(
        title: Text("R\$ ${order.total.toStringAsFixed(2)}"),
        subtitle: Text(
          DateFormat("dd/MM/yyyy HH:mm").format(order.date),
          style: const TextStyle(color: Colors.grey),
        ),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            height: (order.products.length * 25) + 10,
            child: ListView(
              children: order.products.map((product) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${product.quantity}x R\$ ${product.price}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
