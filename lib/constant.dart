import 'package:flutter/material.dart';

const labelNameStyle = TextStyle(fontSize: 18, color: Colors.red);

const labelTextStyle = TextStyle(fontSize: 18, color: Colors.green);

const h1TextStyle = TextStyle(
  fontSize: 30,
  color: Colors.black87,
  fontWeight: FontWeight.w500,
);

ButtonStyle buttonStyleContinue = ButtonStyle(
  backgroundColor: MaterialStateProperty.all(Colors.green.shade800),
  // fixedSize: MaterialStateProperty.all(
  //   const Size(
  //     300,
  //     60,
  //   ),
  // ),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: Colors.green))),
);

const emailTextStyle = TextStyle(fontSize: 15);
