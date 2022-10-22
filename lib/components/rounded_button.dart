import 'package:flutter/material.dart';

import 'constants.dart';

class RoundedButton extends StatelessWidget {
  final String buttonName;
  final Function function;

  const RoundedButton({
    Key? key,
    required this.size,
    required this.buttonName,
    required this.function,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        function();
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kPrimaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.center,
        child: Text(
          buttonName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
