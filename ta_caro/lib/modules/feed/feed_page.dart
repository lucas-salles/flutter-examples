import 'package:flutter/material.dart';
import 'package:ta_caro/modules/feed/feed_controller.dart';
import 'package:ta_caro/modules/feed/repositories/feed_repository_impl.dart';
import 'package:ta_caro/shared/models/order_model.dart';
import 'package:ta_caro/shared/services/app_database.dart';
import 'package:ta_caro/shared/theme/app_theme.dart';
import 'package:ta_caro/shared/widgets/card_chart/card_cart.dart';
import 'package:ta_caro/shared/widgets/card_product.dart/card_product.dart';
import 'package:ta_caro/shared/widgets/list_tile.dart/app_list_tile.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  late final FeedController controller;

  @override
  void initState() {
    super.initState();
    controller = FeedController(
      repository: FeedRepositoryImpl(
        database: AppDatabase.instance,
      ),
    );
    controller.getData();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: controller,
          builder: (_, __) => controller.state.when(
            success: (value) {
              final orders = value as List<OrderModel>;
              final products = controller.products;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardChart(
                          value: controller.sumTotal,
                          percent: controller.calcChart(products),
                        ),
                        const SizedBox(height: 27),
                        const Text("Preço dos produtos").label,
                        const SizedBox(height: 27),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 126,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: products.length,
                      itemBuilder: (context, index) => CardProduct(
                        product: products[index],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 27),
                        const Text("Suas últimas compras").label,
                        const SizedBox(height: 27),
                        for (var order in orders)
                          AppListTile(
                            order: order,
                          ),
                      ],
                    ),
                  ),
                ],
              );
            },
            orElse: () => Container(),
          ),
        ),
      ),
    );
  }
}
