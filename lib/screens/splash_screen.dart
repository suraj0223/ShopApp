import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Shimmer.fromColors(
          baseColor: Colors.lightGreenAccent,
          highlightColor: Colors.orange,
          child: Text('Loading...',style: TextStyle(fontSize: 35)),
        ),
      ),
    );
  }
}
