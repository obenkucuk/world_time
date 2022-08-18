import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:world_time/selected_country/cubit/selected_country_repo.dart';
import 'package:world_time/selected_country/selected_country_data.dart';

part 'selected_country_state.dart';

class SelectedCountryCubit extends Cubit<SelectedCountryState> {
  final String _selectedCountry;

  final SelectedCountryData _countryData;

  SelectedCountryCubit(this._selectedCountry, this._countryData) : super(SelectedCountryInitial()) {
    getSelectedTimes();
  }
  Timer? timer;
  Future<void> getSelectedTimes() async {
    try {
      emit(SelectedCountryLoading());

      var countries = await _countryData.getSingleCountries(_selectedCountry);

      emit(SelectedCountryCompleted(countries));
      timer = Timer.periodic(Duration(seconds: 20), (timer) async {
        countries = await _countryData.getSingleCountries(_selectedCountry);

        emit(SelectedCountryCompleted(countries));
      });
    } catch (e) {
      emit(SelectedCountryError(e.toString() + "HATA MESAJI"));
    }
  }

  void cancelTimer() {
    if (timer != null) {
      timer!.cancel();
    }
  }
}
