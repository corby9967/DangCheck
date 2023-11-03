import 'dart:async';

import 'package:dangcheck/pages/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(
      const Duration(milliseconds: 4500),
      () => Get.to(const AuthPage(), transition: Transition.zoom),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            const Image(image: AssetImage('assets/images/splash.png')),
            Positioned(
                top: 50,
                left: MediaQuery.of(context).size.width / 2 - 30,
                child: const SpinKitThreeInOut(
                  size: 30,
                  color: Colors.white,
                  delay: Duration(milliseconds: 0),
                  duration: Duration(milliseconds: 250),
                )),
          ],
        ),
      ),
    );
  }
}
