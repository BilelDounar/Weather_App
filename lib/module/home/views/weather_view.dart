import 'package:flutter/material.dart';
import 'package:weather/module/home/controller/weather_controller.dart';
import 'package:weather/module/home/data/weather_model.dart';
import 'package:weather/module/home/services/weather_services.dart';
import 'package:weather/module/home/widgets/weather_data.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  final WeatherServices _weatherServices = WeatherServices();
  final WeatherController weatherController = WeatherController();

  WeatherModel? weatherModel;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final WeatherData = await _weatherServices.getWeatherData();
      setState(() {
        weatherModel = WeatherData;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
        _isLoading = false;
      });
    }
  }

  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isPressed ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.location_on,
            color: isPressed ? Colors.white : Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                isPressed = !isPressed;
              });
            },
            icon: Icon(isPressed ? Icons.sunny : Icons.nightlight_sharp),
            color: isPressed ? Colors.white : Colors.black,
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        child: Center(
          child:
              _isLoading
                  ? CircularProgressIndicator()
                  : _errorMessage.isNotEmpty
                  ? Text(_errorMessage)
                  : weatherModel != null
                  ? WeatherData(
                    location: weatherModel!.cityName,
                    tempature: weatherModel!.temperature.toInt(),
                    image: weatherController.getWeatherLottie(
                      weatherModel!.weatherCode,
                    ),
                    color: isPressed ? Colors.white : Colors.black,
                  )
                  : const Text('no data'),
        ),
      ),
    );
  }
}
