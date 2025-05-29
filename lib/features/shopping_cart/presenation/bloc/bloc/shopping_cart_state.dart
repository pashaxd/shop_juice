part of 'shopping_cart_bloc.dart';

//Состояния для работы с корзиной

@immutable
abstract class ShoppingCartState {}

class ShoppingCartInitial extends ShoppingCartState {}

class ShoppingCartLoading extends ShoppingCartState {}

class ShoppingCartLoaded extends ShoppingCartState {
  final List<CartItemModel> items;

  ShoppingCartLoaded({required this.items});
}

class ShoppingCartError extends ShoppingCartState {
  final String message;

  ShoppingCartError({required this.message});
}