import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AstronautAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Lottie.network('https://assets5.lottiefiles.com/packages/lf20_Bu8wPm.json');
  }
}
