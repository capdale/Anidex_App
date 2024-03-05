import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CaptureButton extends StatelessWidget {
  const CaptureButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.scale(
        scale: 6.0,
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          shape: CircleBorder(
            side: BorderSide(color: Colors.deepPurple, width: 2.0),
          ),
          child: Text(
            'CAPTURE',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  offset: Offset(1.0, 1.0),
                  blurRadius: 30.0,
                  color: Color.fromARGB(100, 0, 0, 0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}