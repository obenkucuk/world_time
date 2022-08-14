import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ClockCountryData {
  @override
  Future<List> getCountries() async {
    final baseUrl = Uri(
      scheme: 'https',
      host: 'worldtimeapi.org',
      path: '/api/timezone/',
    );
    final response = await http.get(baseUrl);

    switch (response.statusCode) {
      case HttpStatus.ok:
        List<dynamic> countriesData = jsonDecode(response.body);

        return countriesData;

      default:
        return [];
    }
  }
}
