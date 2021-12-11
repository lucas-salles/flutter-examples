import 'package:ta_caro/modules/create/repositories/create_repository.dart';
import 'package:ta_caro/shared/services/app_database.dart';

class CreateRepositoryImpl implements CreateRepository {
  final AppDatabase database;

  CreateRepositoryImpl({
    required this.database,
  });

  @override
  Future<bool> create(
      {required String name,
      required String price,
      required String date}) async {
    final priceSanitize = double.parse(price.replaceAll("R\$", ""));
    final response = await database.create(
      table: "orders",
      data: {
        "name": name,
        "price": priceSanitize,
        "created": date,
      },
    );
    return response;
  }
}
