import 'dart:convert';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:weather/module/home/data/weather_model.dart';

class WeatherServices {
  static const String _weatherUrl = 'https://api.open-meteo.com/v1/forecast';
  static const String _geocodingUrl =
      'https://nominatim.openstreetmap.org/reverse?format=json';

  Future<WeatherModel> getWeatherData() async {
    // Position
    // Position position = await _determinePosition();
    Location location = new Location();
    LocationData _locationdata;
    _locationdata = await location.getLocation();

    //Recup la ville

    String cityName = await _getCityName(_locationdata.latitude ?? 0.0, _locationdata.longitude ?? 0.0);

    return _getWeatherData(_locationdata.latitude ?? 0.0, _locationdata.longitude ?? 0.0, 'Rouen');
  }

  // // Position GPS
  // Future<Position> _determinePosition() async {
  //   if (!await Geolocator.isLocationServiceEnabled()) {
  //     throw Exception('Localisation disabled');
  //   }

  //   // Verifier les autorisations
  //   LocationPermission permission = await Geolocator.checkPermission();

  //   //Si les permissions pas accordées
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();

  //     if (permission == LocationPermission.denied) {
  //       throw Exception(('Localisation denied'));
  //     }

  //     if (permission == LocationPermission.deniedForever) {
  //       throw Exception(('Location are perma disabled'));
  //     }
  //   }
  //   return await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );
  // }

  Future<String> _getCityName(double lat, double long) async {
    final response = await http.get(
      Uri.parse('$_geocodingUrl&lat=$lat&lon=$long'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data.containsKey('adress')) {
        return data['adress']['city'] ??
            data['adress']['village'] ??
            data['adress']['village'] ??
            data['adress']['county'] ??
            'Unknow';
      }
    }
    throw Exception('Failed to get city name');
  }

  Future<WeatherModel> _getWeatherData(
    double lat,
    double long,
    String cityName,
  ) async {
    final url =
        '$_weatherUrl?latitude=$lat&longitude=$long&current=weather_code&hourly=temperature_2m,weather_code&timezone=auto';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return WeatherModel(
        cityName: cityName,
        temperature: _getCurrentHourlyTemperature(data),
        weatherCode: _getCurrentHourlyWeatherCode(data),
      );
    } else {
      throw Exception('Failed load data');
    }
  }

  double _getCurrentHourlyTemperature(Map<String, dynamic> data) {
    final times = data['hourly']['time'];
    final temperature = data['hourly']['temperature_2m'];
    final currentTime = _getCurrentUtcTime();

    final index = times.indexOf(currentTime);
    return index != -1 ? temperature[index] : temperature.last;
  }

  int _getCurrentHourlyWeatherCode(Map<String, dynamic> data) {
    final times = data['hourly']['time'];
    final weatherCodes = data['hourly']['weather_code'];
    final currentTime = _getCurrentUtcTime();

    final index = times.indexOf(currentTime);
    return index != -1 ? weatherCodes[index] : weatherCodes.last;
  }

  //heure actuelle
  String _getCurrentUtcTime() {
    return DateFormat("yyyy-MM-ddTHH:00").format(DateTime.now().toUtc());
  }
}
