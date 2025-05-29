import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_juice/features/catalog_feature/data/models/product_model.dart';
import 'package:shop_juice/features/shopping_cart/data/models/cart_item_model.dart';
import 'package:shop_juice/features/shopping_cart/data/service.dart';

part 'shopping_cart_event.dart';
part 'shopping_cart_state.dart';

//Блок для работы с корзиной
class ShoppingCartBloc extends Bloc<ShoppingCartEvent, ShoppingCartState> {
  final ShoppingCartService _shoppingCartService;
  
  ShoppingCartBloc(this._shoppingCartService) : super(ShoppingCartInitial()) {
    on<ShoppingCartLoadEvent>((event, emit) async {
      emit(ShoppingCartLoading());
      try {
        final items = await _shoppingCartService.getItems();
        emit(ShoppingCartLoaded(items: items));
      } catch (e) {
        emit(ShoppingCartError(message: e.toString()));
      }
    });

    on<ShoppingCartAddItemEvent>((event, emit) async {
      try {
        await _shoppingCartService.addItem(event.product);
        final items = await _shoppingCartService.getItems();
        emit(ShoppingCartLoaded(items: items));
      } catch (e) {
        emit(ShoppingCartError(message: e.toString()));
      }
    });

    on<ShoppingCartRemoveItemEvent>((event, emit) async {
      try {
        await _shoppingCartService.removeItem(event.item);
        final items = await _shoppingCartService.getItems();
        emit(ShoppingCartLoaded(items: items));
      } catch (e) {
        emit(ShoppingCartError(message: e.toString()));
      }
    });
  }
}
