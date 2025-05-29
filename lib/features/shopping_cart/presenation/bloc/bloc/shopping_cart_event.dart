part of 'shopping_cart_bloc.dart';

//События для работы с корзиной
@immutable
abstract class ShoppingCartEvent {}

class ShoppingCartLoadEvent extends ShoppingCartEvent {}

class ShoppingCartAddItemEvent extends ShoppingCartEvent {
  final ProductModel product;

  ShoppingCartAddItemEvent({required this.product});
}

class ShoppingCartRemoveItemEvent extends ShoppingCartEvent {
  final CartItemModel item;

  ShoppingCartRemoveItemEvent({required this.item});
}