import 'package:flutter/material.dart';

import '../constant.dart';



class CustomButton extends StatelessWidget {
  CustomButton({required this.onPressed, required this.buttonName, this.icons});
  final Function() onPressed;
  final String buttonName;
  final IconData? icons;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: buttonStyleContinue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(icons != null)
            Icon(icons, size: 30,),
          if(icons != null)
            SizedBox(width: 6,),
          Text(
            buttonName,
            style: TextStyle(fontSize: 18,),
          ),
        ],
      ),
    );
  }
}