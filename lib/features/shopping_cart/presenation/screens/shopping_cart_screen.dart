import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_juice/core/di/di.dart';
import 'package:shop_juice/features/shopping_cart/presenation/bloc/bloc/shopping_cart_bloc.dart';
import 'package:shop_juice/features/shopping_cart/presenation/widgets/shopping_cart_card.dart';
import 'package:shop_juice/utils/config/palette.dart';
import 'package:shop_juice/utils/config/text_styles.dart';

//Экран корзины

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShoppingCartBloc>()..add(ShoppingCartLoadEvent()),
      child: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: const Text('Shopping Cart', style: TextStyles.title),
              backgroundColor: Palette.lightGrey,
            ),
            backgroundColor: Palette.lightGrey,
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ShoppingCartState state) {
    if (state is ShoppingCartLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ShoppingCartError) {
      return Center(
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
                context.read<ShoppingCartBloc>().add(ShoppingCartLoadEvent());
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    if (state is ShoppingCartLoaded) {
      if (state.items.isEmpty) {
        return const Center(
          child: Text(
            'Your cart is empty',
            style: TextStyles.title,
          ),
        );
      }

      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: state.items.length,
        itemBuilder: (context, index) {
          return ShoppingCartCard(item: state.items[index]);
        },
      );
    }

    return const Center(child: Text('Unknown state'));
  }
}