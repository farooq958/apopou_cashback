part of 'all_shops_cubit.dart';

@immutable
abstract class AllShopsState {}

class AllShopsInitial extends AllShopsState {}
class AllShopsLoading extends AllShopsState {}
class AllShopsLoaded extends AllShopsState {}
class Reload extends AllShopsState {}
class AllShopsError extends AllShopsState {}
