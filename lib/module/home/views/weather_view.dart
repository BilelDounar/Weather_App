import 'package:flutter/material.dart';
import 'package:weather/module/home/widgets/weather_data.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  bool isPressed = false; // Déclaré ici pour conserver l'état

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isPressed ? Colors.black : Colors.white,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.location_on,
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
            icon: const Icon(Icons.nightlight_sharp, color: Colors.black),
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        color: isPressed ? Colors.black : Colors.white, // Changement de couleur
        child: Center(
          child: WeatherData(
            location: 'Rouen',
            tempature: 8,
            image: 'assets/json/sun.json',
            color: isPressed ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
