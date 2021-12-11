import 'package:ta_caro/shared/models/order_model.dart';

abstract class FeedRepository {
  Future<List<OrderModel>> getAll();
}
