import 'package:flutter/material.dart';
import 'package:notes_app/core/Notifiers/widgets/profilePageWidgetsNotifiers.dart';
import 'package:notes_app/themeData/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

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
                  padding: const EdgeInsets.only(left: 10),
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
                        onSubmitted: (s) {
                          print("-----------------onSubmitted-----------");
                          print(
                              "8888888888888888-------${_controller.text}---------888888888888");
                          value.onChanged({widget.field: _controller.text});
                        },
                        onChanged: (s) {
                          value.isChanged = true;
                        },
                      ),
                      Divider(
                        height: 20,
                        thickness: 2,
                      )
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
  UpdateImage({this.radius = 50, this.url});
  double radius;
  String url;
  AssetImage defaultImage = AssetImage('lib/assets/images/profile.jpeg');
  XFile file;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 2 * radius,
      height: 2 * radius,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              child: CircularProgressIndicator(
                strokeWidth: 10,
              ),
              width: 2 * radius,
              height: 2 * radius,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              // foregroundImage: NetworkImage(url),
              backgroundImage: defaultImage,
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
                file = await _picker.pickImage(source: ImageSource.gallery);
              },
              elevation: 0,
              child: Icon(Icons.camera_alt),
            ),
          )
        ],
      ),
    );
  }
}
