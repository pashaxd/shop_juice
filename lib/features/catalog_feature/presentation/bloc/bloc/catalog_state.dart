part of 'catalog_bloc.dart';

@immutable
sealed class CatalogState {}

final class CatalogInitial extends CatalogState {}

class CatalogLoading extends CatalogState {}

//Состояние загруженных продуктов
class CatalogLoaded extends CatalogState {
  final List<ProductModel> products;

  CatalogLoaded({required this.products});
}

class CatalogError extends CatalogState {
  final String message;

  CatalogError({required this.message});
}

class CatalogNoInternet extends CatalogState {}

class CatalogNoData extends CatalogState {}