part of 'parent_categories_cubit.dart';

@immutable
abstract class ParentCategoriesState {}

class ParentCategoriesInitial extends ParentCategoriesState {}
class ParentCategoriesLoading extends ParentCategoriesState {}
class ParentCategoriesLoaded extends ParentCategoriesState {}
class ParentCategoriesError extends ParentCategoriesState {}
