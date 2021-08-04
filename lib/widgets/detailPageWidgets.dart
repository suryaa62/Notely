import 'package:flutter/material.dart';
import 'package:notes_app/themeData/theme_data.dart';

class TitleField extends StatelessWidget {
  TitleField({@required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    return EditableText(
      controller: TextEditingController()..text = text,
      focusNode: FocusNode(),
      style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 23),
      cursorColor: color_data["buttonColor"],
      backgroundCursorColor: Colors.amber,
      // maxLines: null,
    );
  }
}

class TimeField extends StatelessWidget {
  TimeField({@required this.time});

  DateTime time;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${time.day} ${time.month} ${time.year}, ${time.hour}: ${time.minute} ",
      style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 13),
    );
  }
}

class NoteText extends StatelessWidget {
  NoteText({@required this.text});

  String text;

  @override
  Widget build(BuildContext context) {
    return EditableText(
      controller: TextEditingController()..text = text,
      focusNode: FocusNode(),
      style: Theme.of(context).textTheme.bodyText1.copyWith(height: 1.5),
      cursorColor: color_data["buttonColor"],
      backgroundCursorColor: Colors.amber,
      maxLines: null,
    );
  }
}

class NoteImage extends StatelessWidget {
  NoteImage({@required this.path, @required this.title});

  String path;
  String title;

  @override
  Widget build(BuildContext context) {
    // return Card(
    //   elevation: 0,
    //   color: Theme.of(context).scaffoldBackgroundColor,
    //   child: Stack(
    //     children: [
    //       Column(
    //         children: [
    //           Padding(
    //               padding: EdgeInsets.only(bottom: 15),
    //               child: TitleField(
    //                 text: title,
    //               )),
    //           Image.asset(
    //             path,
    //             width: double.infinity,
    //             fit: BoxFit.cover,
    //           ),
    //         ],
    //       ),
    //       Align(
    //         alignment: Alignment.topRight,
    //         child: IconButton(
    //           icon: Icon(Icons.cancel),
    //           onPressed: () {},
    //         ),
    //       )
    //     ],
    //   ),
    // );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 200,
                child: TitleField(
                  text: title,
                ),
              ),
              IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Image.asset(
          path,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}

class NoteTodo extends StatelessWidget {
  NoteTodo(
      {@required this.todoList, @required this.todoDone, this.title = "#ToDo"});

  List<dynamic> todoList;
  List<dynamic> todoDone;
  String title;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      child: TitleField(
                        text: title,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                )),
              ),
            ] +
            List.generate(todoList.length, (index) {
              return Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.radio_button_off), onPressed: () {}),
                  Expanded(child: NoteText(text: todoList[index])),
                  IconButton(
                      icon: Icon(
                        Icons.cancel_outlined,
                      ),
                      onPressed: () {})
                ],
              );
            }) +
            [
              Divider(
                color: color_data["buttonColor"],
                height: 3,
                thickness: 1,
              )
            ] +
            List.generate(todoDone.length, (index) {
              return Row(
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.check_circle_outline,
                        color: color_data["checklistColor"],
                      ),
                      onPressed: () {}),
                  Expanded(child: NoteText(text: todoDone[index])),
                  IconButton(
                      icon: Icon(Icons.cancel_outlined,
                          color: color_data["checklistColor"]),
                      onPressed: () {})
                ],
              );
            }));
  }
}

class NoteReminder extends StatelessWidget {
  NoteReminder({@required this.time});

  DateTime time;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: color_data["reminderColor"],
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.notifications_outlined,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: Text(
                "${time.day} ${time.month} ${time.year}, ${time.hour}: ${time.minute} ",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2
                    .copyWith(fontSize: 16, color: Colors.white),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ));
  }
}
