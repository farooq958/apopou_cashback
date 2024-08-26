part of 'hidden_attribute_cubit.dart';

@immutable
abstract class HiddenAttributeState {}

class HiddenAttributeInitial extends HiddenAttributeState {}
class HiddenAttributeLoading extends HiddenAttributeState {}
class HiddenAttributeLoaded extends HiddenAttributeState {

  final HiddenAttrModel data;
  HiddenAttributeLoaded({required this.data});

}
class HiddenAttributeError extends HiddenAttributeState {}
