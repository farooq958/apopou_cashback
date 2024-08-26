part of 'retailers_search_cubit.dart';

@immutable
abstract class RetailersSearchState {}

class RetailersSearchInitial extends RetailersSearchState {}
class RetailersSearchLoading extends RetailersSearchState {}
class RetailersSearchLoaded extends RetailersSearchState {}
class RetailersSearchError extends RetailersSearchState {}
