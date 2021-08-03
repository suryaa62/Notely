import 'package:flutter/material.dart';
import 'package:notes_app/themeData/theme_data.dart';
import 'package:notes_app/widgets/detailPageWidgets.dart';

class DetailsPage extends StatelessWidget {
  Widget _bottomNagivgationBar() {
    return Container(
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(21), topRight: Radius.circular(21)),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  icon: Icon(
                    Icons.music_note,
                    color: Colors.red,
                    size: 24,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    Icons.photo_outlined,
                    color: color_data['reminderColor'],
                    size: 24,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: color_data['buttonColor'],
                    size: 24,
                  ),
                  onPressed: () {}),
              IconButton(
                  icon: Icon(
                    Icons.check_circle_outline,
                    color: color_data['checklistColor'],
                    size: 24,
                  ),
                  onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNagivgationBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 40,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  IconButton(
                      icon: Icon(
                        Icons.done,
                        color: color_data['buttonColor'],
                        size: 40,
                      ),
                      onPressed: () {}),
                ],
              ),
              Expanded(child: MainBody())
            ],
          ),
        ),
      ),
    );
  }
}

class MainBody extends StatefulWidget {
  @override
  _MainBodyState createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: EditableText(
            controller: TextEditingController()..text = "New Note",
            focusNode: FocusNode(),
            style: Theme.of(context).textTheme.subtitle1.copyWith(fontSize: 23),
            cursorColor: color_data["buttonColor"],
            backgroundCursorColor: Colors.amber,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Text(
              "${now.day} ${now.month} ${now.year}, ${now.hour}: ${now.minute} ",
              style:
                  Theme.of(context).textTheme.subtitle2.copyWith(fontSize: 13),
            )),
        Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: NoteReminder(
              time: now,
            )),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 10),
          child: EditableText(
            controller: TextEditingController()
              ..text =
                  "In quo pertineant non quo aut voluptates repudiandae sint et impetus quo ignorare. Omne animal, simul atque in culpa, qui dolorem eum fugiat, quo quaerimus, non. Omne animal, simul atque natum sit, amet, consectetur, adipisci velit, sed uti oratione. In oculis quidem se ipsam voluptatem, quia voluptas expetenda, fugiendus dolor sit, amet. Torquatos nostros? quos dolores suscipiantur maiorum dolorum fuga et expedita distinctio nam libero. Tum dicere exorsus est primum igitur, inquit, modo ista sis aequitate, quam nihil.",
            focusNode: FocusNode(),
            style: Theme.of(context).textTheme.bodyText1.copyWith(height: 1.5),
            cursorColor: color_data["buttonColor"],
            backgroundCursorColor: Colors.amber,
            maxLines: null,
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: NoteImage(
              path: "lib/assets/images/profile.jpeg",
              title: "Image",
            )),
        Padding(
            padding: const EdgeInsets.only(top: 20, left: 10),
            child: NoteTodo(
              todoList: ["todo1", "todo2 "],
              todoDone: ["todo3"],
            )),
      ],
    );
  }
}
