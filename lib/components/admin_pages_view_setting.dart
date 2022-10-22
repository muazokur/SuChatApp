import 'package:flutter/cupertino.dart';

import 'constants.dart';

class AdminPageViewSetting extends StatelessWidget {
  final Widget child;

  const AdminPageViewSetting({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kBackGroundColor,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: child,
        ),
      ),
    );
  }
}
