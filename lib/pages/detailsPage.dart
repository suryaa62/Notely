import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes_app/core/Notifiers/detailsPageNotifier.dart';
import 'package:notes_app/core/models/notesModel.dart';
import 'package:notes_app/themeData/theme_data.dart';
import 'package:notes_app/widgets/detailPageWidgets.dart';

class DetailsPage extends StatelessWidget {
  DetailsPage(this.status, this.webFunc);
  void Function(NotesModel) webFunc;
  DetailsPageNotifier status;
  final ImagePicker _picker = ImagePicker();
  XFile file;

  Widget _bottomNagivgationBar(BuildContext context) {
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
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("This feature is yet not developed")));
                  }),
              IconButton(
                  icon: Icon(
                    Icons.photo_outlined,
                    color: color_data['reminderColor'],
                    size: 24,
                  ),
                  onPressed: () async {
                    file = await _picker.pickImage(source: ImageSource.gallery);
                    if (!kIsWeb)
                      status.addImage(file.path);
                    else
                      status.addImageWeb(file);
                  }),
              IconButton(
                  icon: Icon(
                    Icons.notifications_outlined,
                    color: color_data['buttonColor'],
                    size: 24,
                  ),
                  onPressed: () {
                    status.addReminder(DateTime.now());
                    NoteReminder(
                      updateFunc: status.updateReminder,
                    ).BottomeSheet(context);
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
      bottomNavigationBar: _bottomNagivgationBar(context),
      body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            if (MediaQuery.of(context).size.width < 600)
                              Navigator.of(context).pop();
                            else
                              webFunc(null);
                          }),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                                onPressed: () {
                                  status.delete();
                                  if (MediaQuery.of(context).size.width < 600)
                                    Navigator.of(context).pop();
                                  else
                                    webFunc(null);
                                }),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.done,
                                color: color_data['buttonColor'],
                                size: 40,
                              ),
                              onPressed: () {
                                status.display();
                                if (MediaQuery.of(context).size.width < 600)
                                  Navigator.of(context).pop();
                                else
                                  webFunc(null);
                              }),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: TitleField(
                        text: status.note.title,
                        updateFunc: status.updateTitle,
                      )),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10),
                      child: TimeField(
                        time: status.note.timeLastEdit,
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          if (index == status.note.noteWidgets.length)
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: NoteText(
                                text: "",
                                index: index,
                                checktextField: status.checkTextField,
                                deleteCallback: status.removeWidget,
                                updateFunc: status.updateTextFieldData,
                                addTextfield: status.addTextField,
                              ),
                            );
                          Map<String, dynamic> m =
                              status.note.noteWidgets[index];
                          switch (m['type']) {
                            case 'reminder':
                              // print(m['data']);
                              return Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: NoteReminder(
                                  time: formateDate(
                                      NoteReminderModel.fromMap(m).time),
                                  updateFunc: status.updateReminder,
                                  deleteFunc: status.removeWidget,
                                  index: index,
                                ),
                              );
                            case 'textfield':
                              return Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: NoteText(
                                  text: m['data'],
                                  index: index,
                                  checktextField: status.checkTextField,
                                  deleteCallback: status.removeWidget,
                                  updateFunc: status.updateTextFieldData,
                                  addTextfield: status.addTextField,
                                ),
                              );
                            case 'imageURL':
                              // print("++++++++++++++++++++++" + m['data']);
                              return Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: NoteImage(
                                  path: m['data'],
                                  title: "Image",
                                  deleteFunc: status.removeWidget,
                                  index: index,
                                ),
                              );
                            case 'todo':
                              return Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: NoteTodo(
                                    index: index,
                                    deleteFunc: status.removeWidget,
                                    addTodo: status.addnewTodo,
                                    checkTodo: status.checkedTodo,
                                    uncheckTodo: status.unCheckedTodo,
                                    deleteTodo: status.deleteTodo,
                                    todoList: m['data']['unchecked'],
                                    todoDone: m['data']['checked']),
                              );
                          }
                          return Container();
                        },
                        itemCount: status.note.noteWidgets.length + 1,
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
