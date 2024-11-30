part of 'login_bloc.dart';

@immutable
sealed class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ButtonLoginEvent extends LoginEvent {}
