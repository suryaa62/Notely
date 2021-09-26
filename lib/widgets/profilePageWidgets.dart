import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:notes_app/core/Notifiers/widgets/profilePageWidgetsNotifiers.dart';
import 'package:notes_app/locator.dart';
import 'package:notes_app/themeData/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart' as imagePicker;
import 'dart:io';

class UpdateField extends StatefulWidget {
  UpdateField(
      {this.notifier,
      this.initialText,
      this.field,
      this.label,
      this.readOnly,
      this.prefixIcon});
  UpdateFieldNotifier notifier;
  String initialText;
  String field;
  String label;
  bool readOnly;
  Icon prefixIcon;
  @override
  _UpdateFieldState createState() => _UpdateFieldState();
}

class _UpdateFieldState extends State<UpdateField> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("yeah------------------------------");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: widget.notifier,
      builder: (context, value) {
        _controller.text = widget.initialText;

        return Consumer<UpdateFieldNotifier>(
          builder: (context, value, child) => Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.prefixIcon,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          widget.label,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      TextField(
                        controller: _controller,
                        readOnly: widget.readOnly,
                        onEditingComplete: () {
                          value.onChanged({widget.field: _controller.text});
                        },
                        onSubmitted: (s) {
                          value.onChanged({widget.field: _controller.text});
                        },
                        onChanged: (s) {
                          value.isChanged = true;
                        },
                      ),
                      // Divider(
                      //   height: 20,
                      //   thickness: 2,
                      // )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: (value.busy)
                    ? Container(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              color_data["buttonColor"]),
                        ),
                      )
                    : (widget.readOnly)
                        ? Icon(Icons.edit_off)
                        : Icon(Icons.edit_outlined),
              ),
            ],
          ),
        );
      },
    );
  }
}

class UpdateImage extends StatelessWidget {
  UpdateImage({
    this.radius = 50,
    this.url,
    this.notifier,
  });
  double radius;
  String url;
  AssetImage defaultImage = AssetImage('lib/assets/images/profile.jpeg');
  XFile file;
  final ImagePicker _picker = ImagePicker();
  UpdateImageNotifier notifier;
  ImagePickerWeb _webPicker = ImagePickerWeb();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: notifier,
      builder: (context, value) {
        return Consumer<UpdateImageNotifier>(
          builder: (context, value, child) {
            print("====== \n ======\n =====\n " + url);
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: 2 * radius,
                height: 2 * radius,
                child: Stack(
                  children: [
                    (value.busy)
                        ? Align(
                            alignment: Alignment.center,
                            child: Container(
                              child: CircularProgressIndicator(
                                strokeWidth: 10,
                              ),
                              width: 2 * radius,
                              height: 2 * radius,
                            ),
                          )
                        : Container(),
                    Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        // foregroundImage: NetworkImage(url),
                        backgroundImage:
                            (url == " ") ? defaultImage : NetworkImage(url),
                        radius: radius,
                        backgroundColor: color_data['greyColor'],
                        // onForegroundImageError: (exception, stackTrace) {
                        //   print(exception);
                        // },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        mini: (radius < 100) ? true : false,
                        onPressed: () async {
                          if (!kIsWeb) {
                            file = await _picker.pickImage(
                                source: ImageSource.gallery);
                            print("+++++++++++++++++++++++++++++++++++++++" +
                                file.name);
                            url = await notifier.uploadImage(file.path);
                          } else {
                            XFile fimg = await _picker.pickImage(
                                source: ImageSource.gallery);

                            url = await notifier.uploadImageWeb(fimg);
                          }
                        },
                        elevation: 0,
                        child: Icon(Icons.camera_alt),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class switchTheme extends StatefulWidget {
  @override
  _switchThemeState createState() => _switchThemeState();
}

class _switchThemeState extends State<switchTheme> {
  ThemeNotifier status = locator.get<ThemeNotifier>();
  bool value;

  @override
  void initState() {
    value = status.currentTheme.brightness == Brightness.dark;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: Text("Dark Theme "),
        value: value,
        onChanged: (val) {
          setState(() {
            value = val;
            if (val) {
              status.giveTheme('dark');
            } else {
              status.giveTheme('light');
            }
          });
        });
  }
}
