import 'package:flutter/material.dart';
import 'package:notes_app/core/Notifiers/detailsPageNotifier.dart';
import 'package:notes_app/core/Notifiers/homePageNotifier.dart';
import 'package:notes_app/core/Notifiers/profilePageNotifier.dart';
import 'package:notes_app/core/models/notesModel.dart';
import 'package:notes_app/pages/detailsPage.dart';
import 'package:notes_app/pages/profilePage.dart';
import 'package:notes_app/themeData/theme_data.dart';
import 'package:notes_app/widgets/customFAB.dart';
import 'package:notes_app/widgets/homepageNotecard.dart';
import 'package:notes_app/widgets/progressIndicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage(this.func, this.webFunc);
  void Function() func;
  void Function(NotesModel) webFunc;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> labels = ['All Notes', 'Reminder', 'Todo', 'Image', 'Audio'];

  String selectedLabel = 'All Notes';

  final TextEditingController _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: ChangeNotifierProvider(
              create: (context) => HomePageNotifier(),
              builder: (context, child) => Consumer<HomePageNotifier>(
                  builder: (context, homePageValue, child) => Progress(
                        busy: homePageValue.busy,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              // Expanded(
                              //     child: Container(
                              //   color: Colors.amber,
                              // ))
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "My Notes",
                                    style:
                                        Theme.of(context).textTheme.headline2,
                                  ),
                                  (MediaQuery.of(context).size.width < 600)
                                      ? GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  ChangeNotifierProvider<
                                                          ProfilePageNotifier>(
                                                      create: (context) =>
                                                          ProfilePageNotifier(),
                                                      builder: (context,
                                                              child) =>
                                                          Consumer<
                                                                  ProfilePageNotifier>(
                                                              builder: (context,
                                                                      value,
                                                                      child) =>
                                                                  ProfilePage(
                                                                      value))),
                                            ));
                                          },
                                          child: Container(
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: (homePageValue.imageURL ==
                                                    " ")
                                                ? Image.asset(
                                                    "lib/assets/images/profile.jpeg",
                                                    width: 25,
                                                    height: 25)
                                                : Image.network(
                                                    homePageValue.imageURL,
                                                    width: 25,
                                                    height: 25,
                                                  ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 25),
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.search)),
                                  controller: _search,
                                  autofocus: false,
                                  onChanged: (s) {
                                    setState(() {});
                                  },
                                  onEditingComplete: () {
                                    setState(() {});
                                  },
                                ),
                              ),
                              Container(
                                //color: Colors.amber,
                                height: 60,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 25, 8, 0),
                                      child: ChoiceChip(
                                          backgroundColor:
                                              color_data['greyColor'],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          selectedColor:
                                              color_data['buttonColor'],
                                          label: Align(
                                              alignment: Alignment.topCenter,
                                              child: Text(
                                                labels[index],
                                                style: (labels[index] ==
                                                        selectedLabel)
                                                    ? Theme.of(context)
                                                        .textTheme
                                                        .button
                                                    : Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                              )),
                                          padding: EdgeInsets.all(10),
                                          selected:
                                              labels[index] == selectedLabel,
                                          onSelected: (selected) {
                                            if (selected) {
                                              setState(() {
                                                selectedLabel = labels[index];
                                              });
                                            }
                                          }),
                                    );
                                  },
                                  itemCount: labels.length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: ListView.builder(
                                    itemBuilder: (context, index) {
                                      if (!homePageValue.notes[index].keywords
                                              .contains(selectedLabel) &&
                                          selectedLabel != 'All Notes') {
                                        return Container();
                                      }
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Container(
                                          margin: EdgeInsets.all(0),
                                          width: double.infinity,
                                          child: GestureDetector(
                                              onTap: () {
                                                if (MediaQuery.of(context)
                                                        .size
                                                        .width <
                                                    600)
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                    builder: (context) => ChangeNotifierProvider(
                                                        create: (context) =>
                                                            DetailsPageNotifier.showNote(
                                                                homePageValue.notes[
                                                                    index]),
                                                        builder: (context, child) =>
                                                            Consumer<DetailsPageNotifier>(
                                                                builder: (context,
                                                                        value,
                                                                        child) =>
                                                                    DetailsPage(
                                                                        value,
                                                                        widget.webFunc))),
                                                  ));
                                                else
                                                  widget.webFunc(homePageValue
                                                      .notes[index]);
                                              },
                                              child: NoteCard(
                                                note:
                                                    homePageValue.notes[index],
                                                searchText: _search.text,
                                              )),
                                        ),
                                      );
                                    },
                                    itemCount: homePageValue.notes.length,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )))),
      floatingActionButton: CustomFAB(
        width: 100,
        onPressed: () {
          if (MediaQuery.of(context).size.width < 600)
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                  create: (context) => DetailsPageNotifier.newNote(),
                  builder: (context, child) => Consumer<DetailsPageNotifier>(
                      builder: (context, value, child) =>
                          DetailsPage(value, widget.webFunc))),
            ));
          else
            widget.webFunc(NotesModel(
                title: "New Note",
                timeLastEdit: DateTime.now(),
                keywords: [],
                noteWidgets: []));
          // func();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.add),
            Text(
              "Create",
              style: Theme.of(context).textTheme.button,
            ),
          ],
        ),
      ),
    );
  }
}

class AdaptiveHomePage extends StatefulWidget {
  AdaptiveHomePage({this.func});
  void Function() func;

  @override
  _AdaptiveHomePageState createState() => _AdaptiveHomePageState();
}

class _AdaptiveHomePageState extends State<AdaptiveHomePage> {
  NotesModel currentNote = null;

  void ChangeCurrentNote(NotesModel n) {
    setState(() {
      currentNote = n;
      print(currentNote);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 600)
      return HomePage(widget.func, ChangeCurrentNote);
    else
      return Row(
        children: [
          Expanded(
            child: HomePage(widget.func, ChangeCurrentNote),
            flex: 30,
          ),
          Expanded(
              flex: 40,
              child: (currentNote == null)
                  ? Scaffold(
                      body: Center(
                        child: Text("No Note Selcted!"),
                      ),
                    )
                  : DetailsPage(DetailsPageNotifier.showNote(currentNote),
                      ChangeCurrentNote)),
          Expanded(
            flex: 30,
            child: ChangeNotifierProvider<ProfilePageNotifier>(
                create: (context) => ProfilePageNotifier(),
                builder: (context, child) => Consumer<ProfilePageNotifier>(
                    builder: (context, value, child) => ProfilePage(value))),
          ),
        ],
      );
  }
}
