import 'package:flutter/material.dart';
import 'package:notes_app/core/Notifiers/detailsPageNotifier.dart';
import 'package:notes_app/themeData/theme_data.dart';
import 'package:notes_app/widgets/detailPageWidgets.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage(this.status);
  DetailsPageNotifier status;

  Widget _bottomNagivgationBar() {
    return Container(
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(100), topRight: Radius.circular(21)),
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
                  onPressed: () {
                    status.addTextField();
                  }),
              IconButton(
                  icon: Icon(
                    Icons.photo_outlined,
                    color: color_data['reminderColor'],
                    size: 24,
                  ),
                  onPressed: () {
                    status.addImage();
                  }),
              IconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: color_data['buttonColor'],
                    size: 24,
                  ),
                  onPressed: () {
                    status.addReminder();
                  }),
              IconButton(
                  icon: Icon(
                    Icons.check_circle_outline,
                    color: color_data['checklistColor'],
                    size: 24,
                  ),
                  onPressed: () {
                    status.addTodo();
                  }),
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
                          onPressed: () {
                            status.display();
                          }),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: TitleField(
                        text: status.note.title,
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: TimeField(
                        time: status.note.timeLastEdit,
                      )),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        Map<String, dynamic> m = status.note.noteWidgets[index];
                        switch (m['type']) {
                          case 'reminder':
                            // print(m['data']);
                            return NoteReminder(time: DateTime.now());
                          case 'textfield':
                            return NoteText(text: m['data']);
                          case 'imageURL':
                            print("++++++++++++++++++++++" + m['data']);
                            return NoteImage(path: m['data'], title: "Image");
                          case 'todo':
                            return NoteTodo(
                                todoList: m['data']['unchecked'],
                                todoDone: m['data']['checked']);
                        }
                      },
                      itemCount: status.note.noteWidgets.length,
                    ),
                  )
                ],
              ))),
    );
  }
}
