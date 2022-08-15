import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:world_time/home/home_data.dart';

part 'home_state.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final ClockCountryData _clockCountryData;
  late final countries;

  List searchedList = [];

  CountriesCubit(this._clockCountryData) : super(CountriesInitial()) {
    getCountryNames();
  }

  Future<void> getCountryNames() async {
    try {
      emit(CountriesLoading());
      countries = await _clockCountryData.getCountries();
      emit(CountriesCompleted(countries));
    } catch (e) {
      emit(CountriesError(e.toString() + "HATA MESAJI"));
    }
  }

  getSearchedCountryNames(String searchedKey) {
    searchedList.clear();
    for (var element in countries) {
      if (element.toString().toLowerCase().contains(searchedKey.toLowerCase())) {
        searchedList.add(element);
      }
    }
    emit(CountriesCompleted(searchedList));
  }
}
