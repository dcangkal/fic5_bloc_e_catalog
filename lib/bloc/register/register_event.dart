part of 'register_bloc.dart';

sealed class RegisterEvent {}

class DoRegisterEvent extends RegisterEvent {
  final RegisterRequestModel model;

  DoRegisterEvent({required this.model});
}
