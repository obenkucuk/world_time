import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

class ClockCountryData {
  Future<List> getCountries() async {
    final baseUrl = Uri(
      scheme: 'https',
      host: 'worldtimeapi.org',
      path: '/api/timezone/',
    );
    final response = await retry(
      // Make a GET request
      () => http.get(baseUrl).timeout(const Duration(seconds: 5)),
      // Retry on SocketException or TimeoutException
      retryIf: (e) => e is SocketException || e is TimeoutException || e is HandshakeException,
    );

    switch (response.statusCode) {
      case HttpStatus.ok:
        List<dynamic> countriesData = jsonDecode(response.body);

        return countriesData;

      default:
        return [];
    }
  }
}
