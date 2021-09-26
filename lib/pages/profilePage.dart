import 'package:flutter/material.dart';
import 'package:notes_app/core/Notifiers/profilePageNotifier.dart';
import 'package:notes_app/themeData/theme_data.dart';
import 'package:notes_app/widgets/customFAB.dart';
import 'package:notes_app/widgets/profilePageWidgets.dart';
import 'package:notes_app/widgets/progressIndicator.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage(this.state);
  ProfilePageNotifier state;

  Widget _appbar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        (MediaQuery.of(context).size.width < 600)
            ? IconButton(
                alignment: Alignment.centerRight,
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                })
            : Container(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 25, top: 10),
            child: Text(
              "Profile",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Progress(
          busy: state.busy,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              children: [
                _appbar(context),
                UpdateImage(
                  radius: 75,
                  url: state.user.imageURL,
                  notifier: state.imageNotifier,
                ),
                UpdateField(
                  label: "Name",
                  field: "name",
                  notifier: state.nameFieldNotifier,
                  initialText: state.user.name,
                  prefixIcon: Icon(Icons.person),
                  readOnly: false,
                ),
                UpdateField(
                  label: "Email",
                  field: "email",
                  notifier: state.emailFieldNotifier,
                  initialText: state.user.email,
                  prefixIcon: Icon(Icons.email),
                  readOnly: false,
                ),
                UpdateField(
                  label: "Phone",
                  field: "phoneNo",
                  notifier: state.phoneFieldNotifier,
                  initialText: state.user.phoneNo,
                  prefixIcon: Icon(Icons.phone_android),
                  readOnly: true,
                ),
                switchTheme()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: CustomFAB(
          onPressed: () {
            state.logout();
            if (MediaQuery.of(context).size.width < 600)
              Navigator.of(context).pop();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.logout),
              Text("LogOut"),
            ],
          )),
    );
  }
}
