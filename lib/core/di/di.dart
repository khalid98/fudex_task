import 'package:fudex_task/core/local_storage/models/product_model.dart';
import 'package:fudex_task/core/local_storage/service/product_service.dart';
import 'package:fudex_task/feature/add_products/presentation/cubit/add_products_cubit.dart';
import 'package:fudex_task/feature/products_history/presentation/cubit/product_history_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final GetIt sl = GetIt.instance;

Future<void> setup() async {
  Hive.registerAdapter(ProductModelAdapter());
  sl.registerFactory<ProductHistoryCubit>(() => ProductHistoryCubit());
  sl.registerFactory<AddProductsCubit>(() => AddProductsCubit());
  final productBox = await Hive.openBox<ProductModel>('products');
  sl.registerSingleton<Box<ProductModel>>(productBox);

  sl.registerLazySingleton(() => ProductService());
}
