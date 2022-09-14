import 'package:flutter/material.dart';



class CustomSellerBuyer extends StatelessWidget {

  const CustomSellerBuyer({required this.containerWidth,required this.borderColor,required this.containerHeight,
    required this.textColor ,
    required this.textName,
    this.backgroundColor= Colors.white,
    required this.icon});
  final double containerWidth;
  final double containerHeight;
  final Color borderColor;
  final IconData icon;
  final Color textColor;
  final String textName;
  final Color backgroundColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: containerWidth,
      height: containerHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor, width: 1),
        borderRadius: BorderRadius.circular(13),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
          ),
          const SizedBox(height: 40,),
          Text(
            textName,
            style: TextStyle(
                color: textColor,
                fontSize: 17,
                fontFamily: 'Poppins'),
          ),
        ],
      ),
    );
  }
}