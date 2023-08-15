
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tank_minds/home_page.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds:3));
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context,MaterialPageRoute(builder: (context)=>Home_Screen()));
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Image.asset(
            fit: BoxFit.cover,
            'Assets/Images/splashlogo.png', // Replace with your splash screen background image path
            width: double.infinity,
            height: double.infinity,

          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Adjust the blur intensity as needed
            child: Container(
              color: Colors.black.withOpacity(0.8), // Adjust the opacity and color as needed

            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return ClipOval(
                      clipper: CircleClipper(_animationController.value),
                      child: const CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage('Assets/Images/backg.png'
                        ),

                      ),
                    );
                  },
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    const Text('Welcome to',style: TextStyle(color: Colors.white,fontSize:25,fontWeight: FontWeight.bold),),
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Opacity(
                            opacity: _animationController.value,
                            child: AnimatedTextKit(animatedTexts: [
                              WavyAnimatedText('TANKMINDS',textStyle: const TextStyle(color: Colors.white,fontSize: 30)),
                            ],
                              repeatForever: true,

                            )
                          // child: Text(
                          //   "Welcome to Tech Minds",
                          //   style: TextStyle(
                          //     fontSize: 20.0,
                          //     fontWeight: FontWeight.bold,
                          //   ),
                          // ),
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 130.0),

                const SpinKitWave(
                  color: Colors.white,
                  size: 40,
                  duration: Duration(seconds: 2),
                ),


              ],
            ),
          ),

        ],

      ),
    );
  }
}

class CircleClipper extends CustomClipper<Rect> {
  double progress;

  CircleClipper(this.progress);

  @override
  Rect getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.5 * progress;
    final rect = Rect.fromCircle(center: center, radius: radius);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}