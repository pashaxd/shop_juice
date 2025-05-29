import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_juice/features/catalog_feature/presentation/bloc/bloc/catalog_bloc.dart';
import 'package:shop_juice/features/catalog_feature/presentation/widgets/product_card.dart';
import 'package:shop_juice/features/shopping_cart/presenation/screens/shopping_cart_screen.dart';
import 'package:shop_juice/utils/config/palette.dart';
import 'package:shop_juice/utils/config/text_styles.dart';
import 'package:shop_juice/utils/snackbar.dart';

//Экран каталога

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {

        //Обработка начального состояния
        if (state is CatalogInitial) {
          context.read<CatalogBloc>().add(CatalogFetchEvent());
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is CatalogLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        //Обработка ошибок
        if (state is CatalogError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: TextStyles.description,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CatalogBloc>().add(CatalogFetchEvent());
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          );
        }
        //Обработка ошибки отсутствия интернета
        if (state is CatalogNoInternet) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.wifi_off, size: 48),
                  const SizedBox(height: 16),
                  const Text('No internet connection'),
                  const SizedBox(height: 8),
                  const Text('Please check your connection and try again'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CatalogBloc>().add(CatalogFetchEvent());
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          );
        }
        //Обработка ошибки отсутствия данных
        if (state is CatalogNoData) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_bag_outlined, size: 48),
                  const SizedBox(height: 16),
                  const Text('No products available'),
                  const SizedBox(height: 8),
                  const Text('Please try again later'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<CatalogBloc>().add(CatalogFetchEvent());
                    },
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            ),
          );
        }
       
        //Загруженные продукты
        if (state is CatalogLoaded) {
          return Scaffold(
            backgroundColor: Palette.lightGrey,
            appBar: AppBar(
              title: const Text('Catalog', style: TextStyles.title),
              backgroundColor: Palette.lightGrey,
              actions: [
                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  ShoppingCartScreen()));
                }, icon: const Icon(Icons.shopping_cart))
              ],
            ),
            body: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: state.products.length,
              itemBuilder: (context, index) => ProductCard(
                product: state.products[index],
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(child: Text('Unknown state')),
        );
      },
    );
  }
}