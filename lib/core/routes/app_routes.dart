import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fudex_task/core/di/di.dart';
import 'package:fudex_task/feature/add_products/presentation/cubit/add_products_cubit.dart';
import 'package:fudex_task/feature/add_products/presentation/screens/add_products_screen.dart';
import 'package:fudex_task/feature/products_history/presentation/screens/products_history_screen.dart';
import 'package:fudex_task/fudex.dart';

class Routes {
  static const String home = '/';
  static const String addProductsScreen = '/addProductsScreen';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(builder: (context) {
          return const ProductsHistoryScreen();
        });
      case Routes.addProductsScreen:
        final args = routeSettings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => sl<AddProductsCubit>(),
            child: AddProductsScreen(
              isAdd: args["isAdd"],
              productModel: args["product"],
              index: args["index"],
            ),
          );
        });
    }
  }
}
