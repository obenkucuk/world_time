part of 'selected_country_cubit.dart';

abstract class SelectedCountryState {}

class SelectedCountryInitial extends SelectedCountryState {}

class SelectedCountryLoading extends SelectedCountryState {}

class SelectedCountryCompleted extends SelectedCountryState {
  final SingleCountryRepo? response;

  SelectedCountryCompleted(this.response);
}

class SelectedCountryError extends SelectedCountryState {
  final String message;

  SelectedCountryError(this.message);
}
