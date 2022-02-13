class WeatherException implements Exception {
  String message;
  WeatherException([this.message = 'Something Went Wrong']) {
    message = 'Weather Exeption: $message';
  }
  @override
  String toString() {
    return message;
  }
}
