import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_newsapp/custom_files/app_colors.dart';
import 'package:flutter_newsapp/ui/bloc/news_bloc.dart';
import 'package:flutter_newsapp/ui/views/splash_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(create: (BuildContext context) => NewsBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.seedBlue),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}

const spinkit = SpinKitChasingDots(
  color: AppColors.blue,
  size: 40.0,
);
