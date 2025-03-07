class WeatherModel {
  final String cityName;
  final double temperature;
  final int weatherCode;

  WeatherModel({
    required this.cityName,
    required this.temperature,
    required this.weatherCode,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json, String cityName) {
    return WeatherModel(
      cityName: cityName,
      temperature: json['temperature'],
      weatherCode: json['weatherCode'],
    );
  }
}
