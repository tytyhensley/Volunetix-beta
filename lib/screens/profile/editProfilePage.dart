import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/components/eventbox.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  DatabaseReference _updateProfile = FirebaseDatabase.instance.reference();

  final name = TextEditingController();
  final occ = TextEditingController();
  final bio = TextEditingController();

  checkTextFieldEmptyOrNot() {
    String text1, text2, text3;

    text1 = name.text;
    text2 = occ.text;
    text3 = bio.text;

    if (text1 == '' || text2 == '' || text3 == ' ') {
      return false;
    } else {
      return true;
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    try {
      await _auth.currentUser().then((value) {
        loggedInUser = value;
        if (loggedInUser.displayName == 'Volunteer') {
          _updateProfile =
              FirebaseDatabase.instance.reference().child('Volunteers');
        } else {
          _updateProfile =
              FirebaseDatabase.instance.reference().child('Charities');
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ktextColorD,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/volunetixLogoSmall.png',
              color: Colors.white,
              fit: BoxFit.contain,
              height: 32,
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Edit Your Profile',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              Text(
                'Make sure to click submit to save changes',
                textAlign: TextAlign.center,
                style: kAppTextStyle.copyWith(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name:',
                    textAlign: TextAlign.center,
                    style: kAppTextStyle.copyWith(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: EventBox(
                      keybrd: TextInputType.text,
                      lines: 1,
                      myController: name,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Occupation:',
                    textAlign: TextAlign.center,
                    style: kAppTextStyle.copyWith(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: EventBox(
                      keybrd: TextInputType.text,
                      lines: 1,
                      myController: occ,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Bio: ',
                    textAlign: TextAlign.center,
                    style: kAppTextStyle.copyWith(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                    child: EventBox(
                      keybrd: TextInputType.text,
                      lines: 5,
                      myController: bio,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60.0,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (checkTextFieldEmptyOrNot() == true) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            title: Text(
                              "Ready to Submit Changes",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              "These changes will be saved",
                              textAlign: TextAlign.center,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text(
                                  "Sumbit",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  _updateProfile
                                      .child(loggedInUser.uid)
                                      .update({
                                    'name': name.text,
                                    'bio': bio.text,
                                    'occupation': occ.text
                                  }).then((value) {
                                    Navigator.of(context).pop();
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            title: Text(
                              "Uh-Oh",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              "Please fill in all text fields",
                              textAlign: TextAlign.center,
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Image.asset(
                    'assets/images/submit.png',
                    scale: 2.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
