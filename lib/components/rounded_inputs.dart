import 'package:flutter/material.dart';

import 'constants.dart';

class RoundedInput extends StatelessWidget {
  final Size size;
  final String? hintText;
  final IconData? textIcon;
  final bool obscureText;
  final TextInputType inputType;
  final int maxLine;
  final TextEditingController? controller;
  final bool enabled;
  final Color? hintColor;
  final String? defauldText;

  const RoundedInput(
      {Key? key,
      required this.size,
      this.hintText,
      this.textIcon,
      this.obscureText = false,
      this.inputType = TextInputType.text,
      this.maxLine = 1,
      this.controller,
      this.enabled = true,
      this.hintColor,
      this.defauldText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kPrimaryColor.withAlpha(50),
      ),
      child: TextFormField(
        initialValue: defauldText,
        cursorColor: kPrimaryColor,
        keyboardType: inputType,
        obscureText: obscureText,
        maxLines: maxLine,
        textCapitalization: TextCapitalization.words,
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          icon: Icon(
            textIcon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
