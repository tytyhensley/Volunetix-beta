import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/components/eventbox.dart';
import 'package:stopwatch/screens/charity/createEvent/createEvent2.dart';

class CreateEvent1 extends StatefulWidget {
  @override
  _CreateEvent1State createState() => _CreateEvent1State();
}

class _CreateEvent1State extends State<CreateEvent1> {
  final textController_1 = TextEditingController();
  final textController_2 = TextEditingController();

  checkTextFieldEmptyOrNot() {
    String text1, text2;

    text1 = textController_1.text;
    text2 = textController_2.text;

    if (text1 == '' || text2 == '') {
      return false;
    } else {
      return true;
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
                'Lets name your event',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              Text(
                'Create a name that your volunteer and attendees can find',
                textAlign: TextAlign.center,
                style: kAppTextStyle.copyWith(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              EventBox(
                keybrd: TextInputType.text,
                lines: 1,
                myController: textController_1,
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Describe your event to the world',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              EventBox(
                keybrd: TextInputType.text,
                lines: 6,
                myController: textController_2,
              ),
              SizedBox(
                height: 40.0,
              ),
              GestureDetector(
                child: Container(
                  color: ktextColorD,
                  width: double.infinity,
                  child: Text(
                    'Next',
                    textAlign: TextAlign.center,
                    style: kAppTextStyle.copyWith(
                      fontSize: 24.0,
                      color: ktextColorA,
                    ),
                  ),
                ),
                onTap: () {
                  if (checkTextFieldEmptyOrNot() == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateEvent2(
                          name: textController_1.text,
                          des: textController_2.text,
                        ),
                      ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
