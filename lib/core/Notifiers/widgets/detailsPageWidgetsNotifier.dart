import 'package:flutter/foundation.dart';
import 'package:notes_app/core/models/notesModel.dart';

class NoteReminderNotifier extends ChangeNotifier {
  NoteReminderNotifier({this.index, this.noteReminderModel});
  int index;
  NoteReminderModel noteReminderModel;
}
