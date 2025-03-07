import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/utils/basic_utils.dart';
import 'package:weather/utils/widgets/custom_text.dart';

class WeatherData extends StatelessWidget {
  final String location;
  final String image;
  final int tempature;
  final Color color;

  const WeatherData({
    super.key,
    required this.location,
    required this.image,
    required this.tempature,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = BasicUtils.getScreenWidth(context);
    final screenHeight = BasicUtils.getScreenHeight(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText.basic(
          text: location,
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: 32,
        ),
        SizedBox(height: 50),
        Lottie.asset(image),
        SizedBox(height: 50),
        CustomText.basic(
          text: '$tempature°C',
          color: color,
          fontWeight: FontWeight.w800,
          fontSize: 32,
        ),
      ],
    );
  }
}
