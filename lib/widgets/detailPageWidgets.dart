import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes_app/themeData/theme_data.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:notes_app/widgets/profilePageWidgets.dart';

class TitleField extends StatelessWidget {
  TitleField({@required this.text, @required this.updateFunc});

  String text;
  void Function(String) updateFunc;

  @override
  Widget build(BuildContext context) {
    return EditableText(
      controller: TextEditingController()..text = text,
      focusNode: FocusNode(),
      style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 23),
      cursorColor: color_data["buttonColor"],
      backgroundCursorColor: Colors.amber,
      onChanged: (s) {
        updateFunc(s);
      },
      maxLines: 1,
    );
  }
}

class TimeField extends StatelessWidget {
  TimeField({@required this.time});

  DateTime time;

  @override
  Widget build(BuildContext context) {
    return Text(
      formateDate(time),
      style: Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 13),
    );
  }
}

class NoteText extends StatelessWidget {
  NoteText(
      {@required this.text,
      this.index,
      this.deleteCallback,
      this.checktextField,
      this.updateFunc,
      this.addTextfield});

  String text;
  int index;
  void Function(int) deleteCallback;
  bool Function(int) checktextField;
  void Function() addTextfield;
  void Function(String, int) updateFunc;
  @override
  Widget build(BuildContext context) {
    return EditableText(
      autofocus: false,
      controller: TextEditingController()..text = text,
      focusNode: FocusNode(),
      style: Theme.of(context).textTheme.bodyText1.copyWith(height: 1.5),
      cursorColor: color_data["buttonColor"],
      backgroundCursorColor: Colors.amber,
      maxLines: null,
      onChanged: (s) {
        try {
          bool b = checktextField(index);
          print("sssssssssssssssssssssssssssssssss");
        } on RangeError {
          addTextfield();
        }
        if (s == "")
          deleteCallback(index);
        else {
          updateFunc(s, index);
        }
      },
    );
  }
}

class NoteImage extends StatelessWidget {
  NoteImage(
      {@required this.path, @required this.title, this.index, this.deleteFunc});

  String path;
  String title;
  int index;
  void Function(int) deleteFunc;

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
                onPressed: () {
                  deleteFunc(index);
                },
              ),
            ],
          ),
        ),
        Image.network(
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
      {@required this.todoList,
      @required this.todoDone,
      this.title = "#ToDo",
      this.index,
      this.deleteFunc,
      this.addTodo,
      this.checkTodo,
      this.deleteTodo,
      this.uncheckTodo});

  List<dynamic> todoList;
  List<dynamic> todoDone;
  String title;
  int index;
  void Function(int) deleteFunc;
  void Function(int, String) addTodo;
  void Function(int, int) checkTodo;
  void Function(int, int) uncheckTodo;
  void Function(int, int, int) deleteTodo;
  String value = " ";
  TextEditingController _controller = TextEditingController();

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
                      onPressed: () {
                        deleteFunc(index);
                      },
                    ),
                  ],
                ),
              ),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (value != " ") addTodo(index, value);
                    this.value = "";
                    _controller.text = "";
                  },
                )),
                onChanged: (value) {
                  this.value = value;
                },
              ),
            ] +
            List.generate(todoList.length, (itemIndex) {
              return Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.radio_button_off),
                      onPressed: () {
                        checkTodo(index, itemIndex);
                      }),
                  Expanded(child: NoteText(text: todoList[itemIndex])),
                  IconButton(
                      icon: Icon(
                        Icons.cancel_outlined,
                      ),
                      onPressed: () {
                        deleteTodo(index, itemIndex, 1);
                      })
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
            List.generate(todoDone.length, (itemIndex) {
              return Row(
                children: [
                  IconButton(
                      icon: Icon(Icons.check_circle_outline,
                          color: Colors.grey //color_data["checklistColor"],
                          ),
                      onPressed: () {
                        uncheckTodo(index, itemIndex);
                      }),
                  Expanded(
                    child: NoteText(
                      text: todoDone[itemIndex],
                    ),
                  ),
                  IconButton(
                      icon: Icon(
                        Icons.cancel_outlined,
                        color: Colors.grey,
                      ), //color_data["checklistColor"]),
                      onPressed: () {
                        deleteTodo(index, itemIndex, 2);
                      })
                ],
              );
            }));
  }
}

class NoteReminder extends StatelessWidget {
  NoteReminder(
      {@required this.time,
      @required this.updateFunc,
      this.deleteFunc,
      this.index});

  int index;
  String time;
  void Function(DateTime) updateFunc;
  void Function(int) deleteFunc;

  void BottomeSheet(BuildContext context) {
    TextEditingController dateTime = TextEditingController();
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              margin: EdgeInsets.all(20),
              height: 170,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter Date and Time",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: DateTimePicker(
                      controller: dateTime,
                      type: DateTimePickerType.dateTimeSeparate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                      dateLabelText: 'Date',
                      timeLabelText: 'Time',
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        updateFunc(DateTime.parse(dateTime.text));
                        Navigator.pop(context);
                      },
                      child: Text("SAVE"),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              color_data['buttonColor'])),
                    ),
                  )
                ],
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        BottomeSheet(context);
      },
      child: Card(
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
                  time,
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
                onPressed: () {
                  deleteFunc(index);
                },
              ),
            ],
          )),
    );
  }
}
