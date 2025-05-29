import 'package:flutter/material.dart';
import 'package:shop_juice/features/catalog_feature/presentation/screens/cartalog_screen.dart';
import 'package:shop_juice/features/catalog_feature/presentation/bloc/bloc/catalog_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_juice/core/di/di.dart';
import 'package:shop_juice/features/shopping_cart/presenation/bloc/bloc/shopping_cart_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CatalogBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ShoppingCartBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          snackBarTheme: const SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            contentTextStyle: TextStyle(color: Colors.white),
            backgroundColor: Colors.black87,
          ),
        ),
        home: const CatalogScreen(),
      ),
    );
  }
}

