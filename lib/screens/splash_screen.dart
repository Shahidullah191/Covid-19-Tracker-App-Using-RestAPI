import 'dart:async';

import 'package:covid_19_tracker/screens/world_states.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _animationController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(Duration(seconds: 5),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>WorldStatesScreen())));
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedBuilder(
                  animation: _animationController,
                  child: Container(
                    height: 200.h,
                    width: 200.w,
                    child: Center(
                      child: Image(image: AssetImage("images/virus.png")),
                    ),
                  ),
                  builder: (BuildContext context, Widget? child){
                    return Transform.rotate(
                        angle: _animationController.value * 2.0 * pi,
                      child: child,
                    );
                  }),
              SizedBox(height: 80.h,),

              Text("Covid-19\nTracker App", textAlign: TextAlign.center ,style: TextStyle(
                  fontSize: 30.sp, fontWeight: FontWeight.bold,
                ),),

            ],
          ),
        ),
      ),
    );
  }
}
