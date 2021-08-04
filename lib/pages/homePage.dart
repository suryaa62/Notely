import 'package:flutter/material.dart';
import 'package:notes_app/core/Notifiers/detailsPageNotifier.dart';
import 'package:notes_app/core/Notifiers/profilePageNotifier.dart';
import 'package:notes_app/pages/detailsPage.dart';
import 'package:notes_app/pages/profilePage.dart';
import 'package:notes_app/themeData/theme_data.dart';
import 'package:notes_app/widgets/customFAB.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage(this.func);
  void Function() func;

  List<String> labels = ['All Notes', 'Reminder', 'Audio', 'Image'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Expanded(
            //     child: Container(
            //   color: Colors.amber,
            // ))
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Notes",
                  style: Theme.of(context).textTheme.headline2,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Consumer<ProfilePageNotifier>(
                            builder: (context, value, child) =>
                                ProfilePage(value))));
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: Image.asset(
                      'lib/assets/images/profile.jpeg',
                      width: 25,
                      height: 25,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: TextField(
                autofocus: false,
              ),
            ),
            Container(
              //color: Colors.amber,
              height: 60,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 25, 8, 0),
                    child: ChoiceChip(
                        backgroundColor: color_data['greyColor'],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        selectedColor: color_data['buttonColor'],
                        label: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              labels[index],
                              style: (index == 0)
                                  ? Theme.of(context).textTheme.button
                                  : Theme.of(context).textTheme.bodyText2,
                            )),
                        padding: EdgeInsets.all(10),
                        selected: index == 0,
                        onSelected: (selected) {}),
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
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        margin: EdgeInsets.all(0),
                        width: double.infinity,
                        child: Card(
                          elevation: 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        color_data['reminderColor'],
                                    child: Icon(
                                      Icons.notifications,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text("Summer Vacation"),
                                  subtitle: Text(
                                    "6 Aug 2020, 07:49 PM",
                                    style:
                                        Theme.of(context).textTheme.subtitle2,
                                  ),
                                ),
                                Divider(),
                                SizedBox(
                                  height: 100,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 6,
                ),
              ),
            ),
          ],
        ),
      )),
      floatingActionButton: CustomFAB(
        width: 100,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Consumer<DetailsPageNotifier>(
                  builder: (context, value, child) => DetailsPage(value))));
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
