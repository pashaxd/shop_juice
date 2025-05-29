import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_juice/features/catalog_feature/data/models/product_model.dart';
import 'package:shop_juice/features/shopping_cart/presenation/bloc/bloc/shopping_cart_bloc.dart';
import 'package:shop_juice/utils/config/palette.dart';
import 'package:shop_juice/utils/config/text_styles.dart';
import 'package:shop_juice/utils/constants/constants.dart';
import 'package:shop_juice/utils/snackbar.dart';

//Экран детального просмотра продукта

class ProductDetailScreen extends StatelessWidget {
  final ProductModel product;
  const ProductDetailScreen({super.key, required this.product});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.lightGrey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: Palette.lightGrey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CarouselSlider(
                items: product.images.map((imageUrl) {
                  return Image.network(
                    imageUrl.toString(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: Constants.phoneWidth * 0.9,
                        color: Palette.lightGrey,
                        child: const Icon(Icons.error),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  viewportFraction: 0.9,
                  height: Constants.phoneHeight * 0.4,
                  enableInfiniteScroll: false,
                ),
              ),
              const SizedBox(height: 16),
              Text(product.title, style: TextStyles.title),
              const SizedBox(height: 8),
              Text(product.description, style: TextStyles.description),
              const SizedBox(height: 8),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: TextStyles.title,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<ShoppingCartBloc>().add(
                    ShoppingCartAddItemEvent(product: product),
                  );
                  Snackbar().showSnackBar(context);
                },
                child: Text('Add to Cart', style: TextStyles.button),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
