class WeatherController {
  //State Function

  String getWeatherLottie(int weatherCode) {
    if (weatherCode >= 0 && weatherCode <= 3) {
      return 'assets/json/sun.json';
    } else if (weatherCode >= 45 && weatherCode <= 48) {
      return 'assets/json/halfsun.json';
    } else if (weatherCode >= 51 && weatherCode <= 82) {
      return 'assets/json/cloud.json';
    } else if (weatherCode >= 95 && weatherCode <= 99) {
      return 'assets/json/thunder.json';
    } else {
      return 'assets/json/cloud.json';
    }
  }
}
