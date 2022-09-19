import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.labelName,
      required this.hintTextName,
      this.onChangedFunction,
      required this.textInputType,
      this.onPressed,
      this.validateFunction,
      this.initialValue,
      this.maxLines,
      this.icon,
      required this.controller,
      this.obscureTextTy = false})
      : super(key: key);

  final String labelName;
  final String hintTextName;
  final TextInputType textInputType;
  final FormFieldValidator<String>? validateFunction;
  final ValueChanged? onChangedFunction;
  final int? maxLines;
 final TextEditingController controller;

  final Function()? onPressed;
  final IconData? icon;
  final bool obscureTextTy;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelName,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        TextFormField(
          keyboardType: textInputType,
          // autofocus: true,
          controller: controller,
          initialValue: initialValue,
          enabled: true,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
            hintText: hintTextName,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            suffixIcon: IconButton(
              icon: Icon(icon),
              onPressed: onPressed,
            ),
          ),
          onChanged: onChangedFunction,
          obscureText: obscureTextTy,
          validator: validateFunction,
          // maxLines: maxLines!,
        ),
      ],
    );
  }
}
