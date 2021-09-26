class NotesModel {
  String title;
  DateTime timeLastEdit;
  List<dynamic> keywords;
  String docId;
  List<dynamic> noteWidgets;

  NotesModel({this.keywords, this.noteWidgets, this.timeLastEdit, this.title});

  NotesModel.fromMap(Map<String, dynamic> map, String id) {
    title = map['title'];
    timeLastEdit = DateTime.parse(map['timeLastEdit']);
    keywords = map["keywords"];
    noteWidgets = map['noteWidgets'];
    docId = id;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'timeLastEdit': timeLastEdit.toString(),
      'keywords': keywords,
      'noteWidgets': noteWidgets,
    };
  }
}

class NoteReminderModel {
  DateTime time;
  NoteReminderModel({this.time});

  Map<String, dynamic> toMap() {
    return {"type": "reminder", "data": time.toString()};
  }

  NoteReminderModel.fromMap(Map<String, dynamic> map) {
    time = DateTime.parse(map['data']);
  }

  String toString() {
    return time.toString();
  }
}
