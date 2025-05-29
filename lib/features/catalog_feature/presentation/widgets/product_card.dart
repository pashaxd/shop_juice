import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_juice/features/catalog_feature/data/models/product_model.dart';
import 'package:shop_juice/features/catalog_feature/presentation/screens/product_detail_sccreen.dart';
import 'package:shop_juice/features/shopping_cart/presenation/bloc/bloc/shopping_cart_bloc.dart';
import 'package:shop_juice/utils/config/palette.dart';
import 'package:shop_juice/utils/config/text_styles.dart';
import 'package:shop_juice/utils/constants/constants.dart';
import 'package:shop_juice/utils/snackbar.dart';

//Карточка продукта в каталоге

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)));
      },
      child: Container(
        height: Constants.phoneHeight * 0.4,
        width: Constants.phoneWidth * 0.4,
        decoration: BoxDecoration(
          color: Palette.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                product.thumbnail,
                height: Constants.phoneHeight * 0.2,
                width: Constants.phoneWidth * 0.4,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  print('Error loading image: $error');
                  return Container(
                    height: Constants.phoneHeight * 0.2,
                    width: Constants.phoneWidth * 0.4,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image_not_supported, size: 40),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product.title,
                style: TextStyles.smallTitle,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ShoppingCartBloc>().add(ShoppingCartAddItemEvent(product: product));
                Snackbar().showSnackBar(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Add to Cart', style: TextStyles.button),
            ),
          ],
        ),
      ),
    );
  }
}