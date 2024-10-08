import 'package:flutter/material.dart';
import 'package:marvel_lati/helper/const.dart';

class Mainbutton extends StatelessWidget {
  const Mainbutton({super.key, required this.text, required this.onPressed,  });
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      
      style: ElevatedButton.styleFrom(

        padding: const EdgeInsets.symmetric(vertical: 16.0),
        backgroundColor: red, // Green color for the button
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
