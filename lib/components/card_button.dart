import 'package:flutter/material.dart';

import 'constants.dart';

class CardButton extends StatelessWidget {
  final IconData buttonIcon;
  final String buttonText;
  final Color iconColor;
  final Function? onTapCardButton;

  const CardButton({
    Key? key,
    required this.buttonIcon,
    required this.buttonText,
    this.iconColor = Colors.black,
    this.onTapCardButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kPrimaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 2, bottom: 2, left: 8, right: 4),
        child: InkWell(
          //splashColor: iconColor,
          onTap: () {
            onTapCardButton!();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(buttonText),
              const SizedBox(width: 5),
              Icon(
                buttonIcon,
                color: iconColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
