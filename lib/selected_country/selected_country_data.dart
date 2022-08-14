import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:world_time/selected_country/cubit/single_country_repo.dart';

class SelectedCountryData {
  @override
  Future<SingleCountryRepo?> getSingleCountries(String _country) async {
    final baseUrl = Uri(
      scheme: 'https',
      host: 'worldtimeapi.org',
      path: '/api/timezone/$_country',
    );
    final response = await http.get(baseUrl);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final countriesData = jsonDecode(response.body);

        return SingleCountryRepo.fromJson(countriesData);

      default:
        return null;
    }
  }
}
