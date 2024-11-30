import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fudex_task/core/routes/app_routes.dart';
import 'package:fudex_task/core/theme/app_theme.dart';
import 'package:fudex_task/core/utils/app_constants.dart';
import 'package:fudex_task/feature/products_history/presentation/cubit/product_history_cubit.dart';

import 'core/di/di.dart';

class Fudex extends StatelessWidget {
  const Fudex({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<ProductHistoryCubit>(),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            locale: const Locale('ar',"EG"),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
                Locale('ar',"EG"),
            ],
            onGenerateRoute: AppRoutes.onGenerateRoute,
            theme: AppTheme.primaryTheme,
          ),
        ));
  }
}
