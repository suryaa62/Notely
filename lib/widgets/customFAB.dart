import 'package:flutter/material.dart';
import 'package:notes_app/themeData/theme_data.dart';

class CustomFAB extends StatelessWidget {
  CustomFAB(
      {@required this.onPressed,
      @required this.child,
      this.height = 52,
      this.width = 163});
  Widget child;
  void Function() onPressed;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, right: 12),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
            elevation: MaterialStateProperty.all(21),
            backgroundColor:
                MaterialStateProperty.all(color_data['buttonColor']),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100)))),
        child: Container(width: width, height: height, child: child),
      ),
    );
  }
}
