import 'package:ta_caro/modules/feed/repositories/feed_repository.dart';
import 'package:ta_caro/shared/models/order_model.dart';
import 'package:ta_caro/shared/services/app_database.dart';

class FeedRepositoryImpl implements FeedRepository {
  final AppDatabase database;

  FeedRepositoryImpl({
    required this.database,
  });

  @override
  Future<List<OrderModel>> getAll() async {
    final response = await database.getAll("orders");
    return response.map((e) => OrderModel.fromMap(e)).toList();
  }
}
