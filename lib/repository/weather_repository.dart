import 'package:haal_e_mausam/exceptions/weather_exceptions.dart';
import 'package:haal_e_mausam/models/custom_error.dart';
import 'package:haal_e_mausam/models/weather_model.dart';
import 'package:haal_e_mausam/services/weather_api_service.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;

  WeatherRepository({required this.weatherApiServices});
  Future<Weather> fetchWeather(String city) async {
    try {
      final int woeid = await weatherApiServices.getWoeid(city);

      final Weather weather = await weatherApiServices.getWeather(woeid);

      return weather;
    } on WeatherException catch (e) {
      throw CustomError(errMsg: e.message);
    } catch (e) {
      throw CustomError(errMsg: "$e");
    }
  }
}
