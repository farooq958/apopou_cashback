part of 'all_favourite_products_cubit.dart';

@immutable
abstract class AllFavouriteProductsState {}

class AllFavouriteProductsInitial extends AllFavouriteProductsState {}
class AllFavouriteProductsLoading extends AllFavouriteProductsState {}
class AllFavouriteProductsLoaded extends AllFavouriteProductsState {}
class AllFavouriteProductsError extends AllFavouriteProductsState {}
class AllFavouriteProductsRelaod extends AllFavouriteProductsState {}

