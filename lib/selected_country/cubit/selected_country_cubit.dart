import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:world_time/selected_country/cubit/single_country_repo.dart';
import 'package:world_time/selected_country/selected_country_data.dart';

part 'selected_country_state.dart';

class SelectedCountryCubit extends Cubit<SelectedCountryState> {
  final String _selectedCountry;

  final SelectedCountryData _countryData;

  SelectedCountryCubit(this._selectedCountry, this._countryData) : super(SelectedCountryInitial()) {
    getCountyNames();
  }

  Future<void> getCountyNames() async {
    try {
      emit(SelectedCountryLoading());
      final countrys = await _countryData.getSingleCountries(_selectedCountry);
      emit(SelectedCountryCompleted(countrys));
    } catch (e) {
      emit(SelectedCountryError(e.toString() + "HATA MESAJI"));
    }
  }
}
