import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_juice/features/catalog_feature/data/service/catalog_service.dart';
import 'package:shop_juice/features/catalog_feature/data/models/product_model.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

//Блок для работы с каталогом

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final CatalogService _catalogService;

  CatalogBloc(this._catalogService) : super(CatalogInitial()) {
    on<CatalogFetchEvent>((event, emit) async {
      emit(CatalogLoading());
      try {
        final products = await _catalogService.getProducts();
        if (products.isEmpty) {
          emit(CatalogNoData());
        } else {
          emit(CatalogLoaded(products: products));
        }
      } catch (e) {
        if (e.toString().contains('No internet connection available')) {
          emit(CatalogNoInternet());
        } else {
          emit(CatalogError(message: e.toString()));
        }
      }
    });
  }
}
