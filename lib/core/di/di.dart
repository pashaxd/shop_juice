import 'package:get_it/get_it.dart';
import 'package:shop_juice/features/catalog_feature/presentation/bloc/bloc/catalog_bloc.dart';
import 'package:shop_juice/features/shopping_cart/data/service.dart';
import 'package:shop_juice/features/shopping_cart/presenation/bloc/bloc/shopping_cart_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shop_juice/utils/constants/constants.dart';
import 'package:shop_juice/features/catalog_feature/data/service/catalog_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Внедрение зависимостей 


final getIt = GetIt.instance;

//Функция для внедрения зависимостей вызывается в main
Future<void> setupDependencies() async {
  // Database
  final database = await openDatabase(
    join(await getDatabasesPath(), 'products.db'),
    version: 4,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE products(
          title TEXT,
          description TEXT,
          images TEXT,
          price REAL,
          thumbnail TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE cart(
          title TEXT,
          description TEXT,
          images TEXT,
          price REAL,
          thumbnail TEXT,
          quantity INTEGER DEFAULT 1
        )
      ''');
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      if (oldVersion < 3) {
        await db.execute('ALTER TABLE cart ADD COLUMN quantity INTEGER DEFAULT 1');
      }
      if (oldVersion < 4) {
        // Drop and recreate tables to ensure proper image URL storage
        await db.execute('DROP TABLE IF EXISTS products');
        await db.execute('DROP TABLE IF EXISTS cart');
        await db.execute('''
          CREATE TABLE products(
            title TEXT,
            description TEXT,
            images TEXT,
            price REAL,
            thumbnail TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE cart(
            title TEXT,
            description TEXT,
            images TEXT,
            price REAL,
            thumbnail TEXT,
            quantity INTEGER DEFAULT 1
          )
        ''');
      }
    },
  );
  getIt.registerSingleton<Database>(database);

  // Dio client
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(BaseOptions(
      baseUrl: Constants.apiLink,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));
    return dio;
  });

  // Services
  getIt.registerLazySingleton<CatalogService>(
    () => CatalogService(getIt<Dio>(), getIt<Database>()),
  );
  getIt.registerLazySingleton<ShoppingCartService>(
    () => ShoppingCartService(getIt<Database>()),
  );

  // Blocs
  getIt.registerFactory<CatalogBloc>(
    () => CatalogBloc(getIt<CatalogService>()),
  );
  
  getIt.registerFactory<ShoppingCartBloc>(
    () => ShoppingCartBloc(getIt<ShoppingCartService>()),
  );
}
