import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_juice/features/shopping_cart/data/models/cart_item_model.dart';
import 'package:shop_juice/features/shopping_cart/presenation/bloc/bloc/shopping_cart_bloc.dart';
import 'package:shop_juice/utils/config/palette.dart';
import 'package:shop_juice/utils/config/text_styles.dart';

//Карточка продукта в корзине

class ShoppingCartCard extends StatelessWidget {
  final CartItemModel item;

  const ShoppingCartCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              item.product.thumbnail,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                print('Error loading image: $error');
                return Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[300],
                  child: const Icon(Icons.image_not_supported, size: 30),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.title,
                  style: TextStyles.smallTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.product.description,
                  style: TextStyles.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.product.price.toStringAsFixed(2)}',
                      style: TextStyles.title,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<ShoppingCartBloc>().add(
                              ShoppingCartRemoveItemEvent(item: item),
                            );
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                          color: Palette.orange,
                        ),
                        Text(
                          '${item.quantity}',
                          style: TextStyles.title,
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<ShoppingCartBloc>().add(
                              ShoppingCartAddItemEvent(product: item.product),
                            );
                          },
                          icon: const Icon(Icons.add_circle_outline),
                          color: Palette.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}