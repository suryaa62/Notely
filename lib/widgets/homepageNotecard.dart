import 'package:flutter/material.dart';
import 'package:notes_app/core/models/notesModel.dart';
import 'package:notes_app/themeData/theme_data.dart';

class NoteCard extends StatelessWidget {
  NoteCard({@required this.note, @required this.searchText});

  NotesModel note;
  String searchText;

  @override
  Widget build(BuildContext context) {
    CircleAvatar leading;

    if (note.keywords.contains("Reminder")) {
      leading = CircleAvatar(
          backgroundColor: color_data['reminderColor'],
          child: Icon(
            Icons.notifications,
            color: Colors.white,
          ));
    } else if (note.keywords.contains("Image")) {
      leading = CircleAvatar(
          backgroundColor: color_data['audioColor'],
          child: Icon(
            Icons.photo_outlined,
            color: Colors.white,
          ));
    } else if (note.keywords.contains("Todo")) {
      leading = CircleAvatar(
          backgroundColor: color_data['checklistColor'],
          child: Icon(
            Icons.check_circle_outline,
            color: Colors.white,
          ));
    } else {
      leading = CircleAvatar(
          backgroundColor: color_data['buttonColor'],
          child: Icon(
            Icons.note_outlined,
            color: Colors.white,
          ));
    }

    String text = "";
    for (var widgets in note.noteWidgets) {
      if (widgets['type'] != 'textfield') continue;
      text += widgets['data'];
    }

    if (searchText != "") {
      if (!text.toLowerCase().contains(searchText) &&
          !note.title.toLowerCase().contains(searchText)) return Container();
    }

    String imagePath = "";
    for (var widgets in note.noteWidgets) {
      if (widgets['type'] != 'imageURL') continue;
      imagePath = widgets['data'];
      break;
    }

    return Card(
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: leading,
              title: Text(note.title),
              subtitle: Text(
                formateDate(note.timeLastEdit),
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            Divider(),
            (text == "")
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      text,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(height: 1.5, fontSize: 13),
                      maxLines: 5,
                    ),
                  ),
            (imagePath == "")
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.network(
                      imagePath,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
