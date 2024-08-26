part of 'all_feature_shops_cubit.dart';

@immutable
abstract class AllFeatureShopsState {}

class AllFeatureShopsInitial extends AllFeatureShopsState {}
class AllFeatureShopsLoading extends AllFeatureShopsState {}
class AllFeatureShopsLoaded extends AllFeatureShopsState {}
class AllFeatureShopsError extends AllFeatureShopsState {}
class AllFeatureShopsReload extends AllFeatureShopsState {}
