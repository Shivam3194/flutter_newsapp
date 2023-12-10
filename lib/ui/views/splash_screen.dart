import 'dart:async';

import 'package:flutter_newsapp/ui/views/home/home_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../custom_files/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    //To get the height and width of device screen so that code automatically adjust according to screens

    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;

    // MediaQuery is a class and from MediaQuery.of(context) provide us the mediaqueryData which gives the height and width and other specification of current screen
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/splash_pic.jpg',
              fit: BoxFit
                  .cover, //Entire box is covered by image included the aspect ratio
              height: height * .5,
            ),
            SizedBox(height: height * 0.04),
            Text(
              'TOP HEADLINES',
              style: GoogleFonts.anton(
                letterSpacing: .6,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: height * 0.04),
            const SpinKitChasingDots(
              color: AppColors.blue,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
