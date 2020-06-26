import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'dart:io';

class VolunteerProfilePage extends StatefulWidget {
  @override
  _VolunteerProfilePageState createState() => _VolunteerProfilePageState();
}

class _VolunteerProfilePageState extends State<VolunteerProfilePage> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  StorageReference firebaseStorageRef = FirebaseStorage.instance.ref();
  String fileName;
  final DatabaseReference _updateVolunteers =
      FirebaseDatabase.instance.reference().child('Volunteers');
  String _image;

  var data;
  String name;
  String occ;
  String bio;
  var events = List();
  String impact;
  bool showSpinner = false;

  String _getTime() {
    int time = data['total_career_time'];
    int hours = time ~/ 24;
    int mins = time % 24;
    return '$hours hours, $mins minutes';
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    try {
      setState(() {
        showSpinner = true;
      });
      await _auth.currentUser().then((value) {
        loggedInUser = value;
        _updateVolunteers.child(loggedInUser.uid).once().then((value) {
          data = value.value;
          name = data['name'];
          occ = data['occupation'];
          bio = data['bio'];
          events = data['lifelong_events_attended'];
        }).then((value) {
          setState(() {
            showSpinner = false;
          });
        });
        firebaseStorageRef
            .child(loggedInUser.uid)
            .child('profilepic')
            .getDownloadURL()
            .then((value) {
          setState(() {
            _image = value.toString();
          });
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    getImage() async {
      await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 100.0,
        maxHeight: 100.0,
      ).then((value) {
        var image = value;
        setState(() {
          File uploadimage = File(image.path);
          firebaseStorageRef
              .child(loggedInUser.uid)
              .child('profilepic')
              .putFile(uploadimage);
        });
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ktextColorD,
        automaticallyImplyLeading: false,
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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Builder(
          builder: (context) => Container(
            padding: EdgeInsets.all(15.0),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: ClipOval(
                        child: SizedBox(
                          width: 100.0,
                          height: 100.0,
                          child: (_image != null)
                              ? Image.network(
                                  _image,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  "https://www.themississaugafoodbank.org/wp-content/uploads/2020/02/user-icon-image-placeholder-300-grey.jpg",
                                  fit: BoxFit.fill,
                                ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 80.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.add_a_photo,
                          size: 20.0,
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          (name != null) ? name : '  ',
                          style: kTitleTextStyle.copyWith(
                            color: ktextColorD,
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          (occ != null) ? occ : '  ',
                          style: kTitleTextStyle.copyWith(
                            color: ktextColorD,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  (bio != null) ? bio : '  ',
                  style: kTitleTextStyle.copyWith(
                    color: ktextColorD,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Center(
                  child: GestureDetector(
                    child: Row(
                      children: [
                        Icon(
                          Icons.edit,
                          size: 14,
                          color: ktextColorA,
                        ),
                        Text(
                          'Edit Profile',
                          style: kTitleTextStyle.copyWith(
                            color: ktextColorD,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, 'edit_profile');
                    },
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Your Total Volunteer Time Is: ',
                  style: kTitleTextStyle.copyWith(
                    color: ktextColorD,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  (data != null) ? _getTime() : '  ',
                  style: kTitleTextStyle.copyWith(
                    color: ktextColorA,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Impacts: ',
                  style: kTitleTextStyle.copyWith(
                    color: ktextColorD,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  (events != null) ? events.length.toString() : '0',
                  style: kTitleTextStyle.copyWith(
                    color: ktextColorA,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
