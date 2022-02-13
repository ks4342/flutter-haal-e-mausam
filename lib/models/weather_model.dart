import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String weatherStateName;

  final String weatherStateAbbr;
  final String created;
  final double maxTemp;
  final double theTemp;
  final double minTemp;
  final String title;
  final int woeid;
  final DateTime lastUpdated;

  const Weather(
      {required this.weatherStateName,
      required this.weatherStateAbbr,
      required this.created,
      required this.maxTemp,
      required this.minTemp,
      required this.title,
      required this.woeid,
      required this.lastUpdated,
      required this.theTemp});
  factory Weather.fromJson(Map<String, dynamic> json) {
    final consolidatedWeather = json['consolidated_weather'][0];
    return Weather(
        weatherStateName: consolidatedWeather['weather_state_name'],
        weatherStateAbbr: consolidatedWeather['weather_state_abbr'],
        created: consolidatedWeather['created'],
        maxTemp: consolidatedWeather['max_temp'],
        minTemp: consolidatedWeather['min_temp'],
        title: json['title'],
        woeid: json['woeid'],
        lastUpdated: DateTime.now(),
        theTemp: consolidatedWeather['the_temp']);
  }
  factory Weather.initial() => Weather(
      weatherStateName: '',
      weatherStateAbbr: '',
      created: '',
      maxTemp: 100,
      minTemp: 100,
      title: '',
      woeid: -1,
      lastUpdated: DateTime(1970),
      theTemp: 100);
  @override
  List<Object> get props {
    return [
      weatherStateName,
      weatherStateAbbr,
      created,
      minTemp,
      maxTemp,
      theTemp,
      title,
      woeid,
      lastUpdated
    ];
  }
}
