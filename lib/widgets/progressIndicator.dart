import 'package:flutter/material.dart';
import 'package:notes_app/themeData/theme_data.dart';

class Progress extends StatelessWidget {
  bool busy;
  Widget child;

  Progress({this.busy, this.child});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: busy,
      child: Stack(
        children: [
          child,
          (busy)
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          color_data["buttonColor"]),
                    ),
                    Expanded(
                        child: Container(
                            width: double.infinity, color: Colors.black38)),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
