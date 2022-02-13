import 'dart:convert';

import 'package:haal_e_mausam/data/constants.dart';
import 'package:haal_e_mausam/exceptions/weather_exceptions.dart';
import 'package:haal_e_mausam/models/weather_model.dart';
import 'package:haal_e_mausam/services/http_error_handler.dart';
import 'package:http/http.dart' as http;

class WeatherApiServices {
  final http.Client httpClient;

  WeatherApiServices({required this.httpClient});
  Future<int> getWoeid(String city) async {
    final Uri uri = Uri(
        scheme: 'https',
        host: kHost,
        path: '/api/location/search/',
        queryParameters: {'query': city});
    try {
      final http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }
      final responseBody = jsonDecode(response.body);
      if (responseBody.isEmpty) {
        throw WeatherException('Can not get woeid $city');
      }
      if (responseBody.length > 1) {
        throw WeatherException(
            "There are multiple candidate for the city ,plan specify further");
      }
      return responseBody[0]['woeid'];
    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(int woeid) async {
    final Uri uri =
        Uri(scheme: 'https', host: kHost, path: '/api/location/$woeid');
    try {
      final http.Response response = await http.get(uri);
      if (response.statusCode != 200) {
        throw Exception(httpErrorHandler(response));
      }
      final weatherJson = jsonDecode(response.body);
      final Weather weather = Weather.fromJson(weatherJson);

      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
