part of 'home_cubit.dart';

abstract class CountriesState {}

class CountriesInitial extends CountriesState {}

class CountriesLoading extends CountriesState {}

class CountriesCompleted extends CountriesState {
  final List response;

  CountriesCompleted(this.response);
}

class CountriesSearched extends CountriesState {}

class CountriesError extends CountriesState {
  final String message;
  CountriesError(this.message);
}
