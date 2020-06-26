import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:stopwatch/components/eventbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:stopwatch/screens/volunteer/addEvent/addEvent4.dart';

class AddEvent3 extends StatefulWidget {
  final String name;
  final List<String> taskslist;

  AddEvent3({this.name, this.taskslist});
  @override
  _AddEvent3State createState() => _AddEvent3State();
}

class _AddEvent3State extends State<AddEvent3> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  final DatabaseReference _updateVolunteer =
      FirebaseDatabase.instance.reference().child('Volunteers');
  final DatabaseReference _updateVolunteer1 =
      FirebaseDatabase.instance.reference().child('Volunteers');
  final DatabaseReference _updateEvent =
      FirebaseDatabase.instance.reference().child('Events');
  final DatabaseReference _updateEvent1 =
      FirebaseDatabase.instance.reference().child('Events');
  final DatabaseReference _updateCharity =
      FirebaseDatabase.instance.reference().child('Charities');
  final DatabaseReference _updateCharity1 =
      FirebaseDatabase.instance.reference().child('Charities');

  final tasks = TextEditingController();
  final whyVol = TextEditingController();
  final occ = TextEditingController();
  double _value = 0;
  String uid;
  String cIn;
  String cOt;
  int volhrs;
  int careerhrs;
  var _currentValue = '--pick answer--';
  var _cValue = '--pick answer--';
  List<String> slider = ['No', 'Somewhat No', 'Neutral', 'Somewhat Yes', 'Yes'];
  List<String> whyvol = [
    '--pick answer--',
    'To Express My Values',
    'To Understand Myself or Others ',
    'To Improve My Career/profession',
    'To Socialize',
    "To Feel Like I'm Making a Change",
    'To Get Away or Get Through Personal Issues',
  ];
  List<String> jobs = [
    '--pick answer--',
    "Accountant",
    "Maid",
    "Butler",
    "Construction Worker",
    "Project Manager",
    "Laborer",
    "Assisstant",
    "Software Developer",
    "Salesman",
    "Fitness Trainer",
    "Designer",
    "Game Designer",
    "iOS Developer",
    "Full Stack Developer",
    "Android Developer",
    "Chief Executive Officer",
    "Regional Manager",
    "Manager",
    "Human Resources",
    "Healthcare",
    "Dental Care",
    "Work Remotely",
    "Customer Service",
    "Receptionist",
    "Telemarketer",
    "Nurse",
    "Nurse Practioner",
    "Doctor",
    "Scrub",
    "Athletic Trainer",
    "Head Coach",
    "Assisstant Coach",
    "Internship",
    "Intern",
    "Leader",
    "Training",
    "Singer",
    "Actor",
    "Music Producer",
    "Songwriter",
    "Audio Engineer",
    "Recruiter",
    "Janitor",
    "Teacher",
    "Substitute Teacher",
    "Principal",
    "Counselor",
    "Boxer",
    "Gym Teacher",
    "History Teacher",
    "Science Teacher",
    "Math Teacher",
    "College Professor",
    "Lunch Lady",
    "Cashier",
    "Bag Boy",
    "Bag Girl",
    "Greeter",
    "Chef",
    "Cook",
    "Bartender",
    "Special Education Teacher",
    "Chief Financial Officer",
    "Advisor",
    "Academix Advisor",
    "Plumber",
    "Electrician",
    "Architect",
    "Mechanical Engineer",
    "Estimator",
    "Basketball Player",
    "Baseball Player",
    "News Anchor",
    "Weatherman",
    "Weatherwoman",
    "Poet",
    "Author",
    "Editor",
    "Boss",
    "Temp",
    "Customer Relations",
    "Warehouse",
    "Consultant",
    "Fortune Teller",
    "Astronaut",
    "Pilot",
    "Ambulance Driver",
    "Animal Trainer",
    "Anthropologist",
    "Appraisers",
    "Real Estate Agent",
    "Lawyer",
    "Therapist",
    "Auditor",
    "Baker",
    "Barber",
    "Baristas",
    "Bench Worker",
    "Bicyle Repairer",
    "Bill Collector",
    "Biochemist",
    "Biologist",
    "Brickmason",
    "Bus Driver",
    "Butchers",
    "Camera Operator",
    "Caption Writers",
    "Carpenter",
    "Carpet Installers",
    "Cartoonist",
    "Chemical Engineer",
    "Chiropractor",
    "Choreographer",
    "Civil Engineers",
    "Clinical Research Coordinator",
    "Coach",
    "Scout",
    "Commerical Pilot",
    "Compliance",
    "Computer Programmer",
    "Conceierge",
    "Building Inspector",
    "Copy Writers",
    "Correctional Officer",
    "Jailer",
    "Rental Clerk",
    "Creative Writer",
    "Credit Analyst",
    "Curator",
    "Tailor",
    "Customer Service",
    "Dancer",
    "Data Entry",
    "Database Administrator",
    "Dental Assistant",
    "Dentist",
    "Dermatologists",
    "Designer",
    "Detective",
    "Dietician",
    "Dishwasher",
    "Dispatcher",
    "Drywall Installer",
    "Economist",
    "Elevator Installer",
    "High School Teacher",
    "Elementary School Teacher",
    "Engraver",
    "Epidemiologists",
    "Etcher",
    "Engraver",
    "Exercise Physiologist",
    "Farmer",
    "Video Editor",
    "Firefighter",
    "Supervisor",
    "Fisherman",
    "Flight Attendant",
    "Floral Designer",
    "Food Scientist",
    "Framer",
    "Geographer",
    "Geologsit",
    "Government Worker",
    "President",
    "Treasurer",
    "Graphic Designer",
    "Hairdresser",
    "Helper",
    "Historian",
    "Home Health Aide",
    "Housekeeping",
    "Hunter",
    "Infantry",
    "Information Technology",
    "Interior Design",
    "Interviewer",
    "Jeweler",
    "Judge",
    "Legislator",
    "Librarian",
    "Mailman",
    "Mailwoman",
    "Manicurist",
    "Makeup Artist",
    "Mathematician",
    "Mental Health Counselor",
    "Meter Reader",
    "Microbiologist",
    "Midwife",
    "Model",
    "Mold Maker",
    "Vehicle Inspector",
    "Animator",
    "Musician",
    "Singer",
    "Nanny",
    "Neurologists",
    "Nuclear Engineer",
    "Occupational Therapist",
    "Office Clerk",
    "Orthodontist",
    "Painter",
    "Illustrator",
    "Parking Lot Attendant",
    "Pathologist",
    "Payroll Clerk",
    "Pediatrician",
    "Pest Control",
    "Pharmacist",
    "Photographer",
    "Physical Therapist",
    "Policeman",
    "Poet",
    "Lyricist",
    "Postmaster",
    "Preschool Teacher",
    "Psychiatrist",
    "Quality Control",
    "Announcer",
    "Radio Announcer",
    "Radiologist",
    "Roofer",
    "Sailor",
    "Sales",
    "Sculptor",
    "Security Guard",
    "Shampooer",
    "Sketch Artist",
    "Sociologist",
    "Spa Manager",
    "Sports Medicine",
    "Statistician",
    "Stripper",
    "Surgeon",
    "Survey Researcher",
    "Surveyor",
    "Tailor",
    "Tax",
    "Tire Builder",
    "Transportation",
    "Travel Agent",
    "Agent",
    "Travel Guide",
    "Truck Driver",
    "Tutor",
    "Umpire",
    "Urologist",
    "Veterinarian",
    "Video Game Designer",
    "Waitress",
    "Waiter",
    "Web Developer",
    "Welder",
    "Zoologist",
    "Job Searching",
    "Unemployed",
    "Employee",
    "Staff"
  ];
  checkTextFieldEmptyOrNot() {
    String text1, text2;

    text1 = whyVol.text;
    text2 = occ.text;

    if (text1 == '' || text2 == '' || widget.taskslist[0] == 'No tasks') {
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
        _updateEvent.child(widget.name).once().then((value) {
          var data = value.value;
          uid = data['host'];
          volhrs = data['total_volunteer_time'];
        });
        _updateVolunteer1.child(loggedInUser.uid).once().then((value) {
          var timedata = value.value;
          careerhrs = timedata['total_career_time'];
        });
        _updateVolunteer
            .child(loggedInUser.uid)
            .child('lifelong_events_attended')
            .child(widget.name)
            .once()
            .then((value) {
          var voldata = value.value;
          cIn = voldata['clock_in'];
          cOt = voldata['clock_out'];
        });
      });
      tasks.text = widget.taskslist.toString();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Select the tasks you completed while volunteering',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEvent4(
                        name: widget.name,
                        taskslist: widget.taskslist,
                      ),
                    ),
                  );
                },
                child: IgnorePointer(
                  child: EventBox(
                    keybrd: TextInputType.text,
                    lines: 1,
                    myController: tasks,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Why did you volunteer today?',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                width: 350.0,
                child: DropdownButton<String>(
                  dropdownColor: ktextColorD,
                  isDense: true,
                  style: TextStyle(
                    color: ktextColorA,
                    fontSize: 14.0,
                  ),
                  items: whyvol.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),
                    );
                  }).toList(),
                  onChanged: (String newValue) {
                    setState(() {
                      this._currentValue = newValue;
                    });
                  },
                  value: _currentValue,
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                'Did you make an impact?',
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'No',
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20,
                    ),
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      inactiveTrackColor: Colors.grey,
                      inactiveTickMarkColor: Colors.grey,
                      activeTickMarkColor: ktextColorD,
                      activeTrackColor: ktextColorD,
                      overlayColor: ktextColorD.withAlpha(32),
                      trackShape: RectangularSliderTrackShape(),
                      trackHeight: 3.0,
                      thumbColor: ktextColorD,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                      valueIndicatorColor: ktextColorD,
                      valueIndicatorTextStyle: TextStyle(
                        color: ktextColorA,
                      ),
                    ),
                    child: Slider(
                      value: _value,
                      min: 0,
                      max: 4,
                      divisions: 4,
                      label: slider[_value.toInt()],
                      onChanged: (value) {
                        setState(
                          () {
                            _value = value;
                          },
                        );
                      },
                    ),
                  ),
                  Text(
                    'Yes',
                    textAlign: TextAlign.center,
                    style: kTitleTextStyle.copyWith(
                      color: ktextColorD,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "What's your occupation?",
                textAlign: TextAlign.center,
                style: kTitleTextStyle.copyWith(
                  color: ktextColorD,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              DropdownButton<String>(
                dropdownColor: ktextColorD,
                style: TextStyle(
                  color: ktextColorA,
                  fontSize: 18.0,
                ),
                items: jobs.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: (String nValue) {
                  setState(() {
                    this._cValue = nValue;
                  });
                },
                value: _cValue,
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    DateTime clockIn = DateTime.parse(cIn);
                    DateTime clockOut = DateTime.parse(cOt);
                    var diff = clockOut.difference(clockIn).inMinutes;
                    volhrs = diff + volhrs;
                    careerhrs = diff + careerhrs;
                    if (checkTextFieldEmptyOrNot() == true) {
                      _updateVolunteer
                          .child(loggedInUser.uid)
                          .child('lifelong_events_attended')
                          .child(widget.name)
                          .update({
                        'total_time': diff.toString(),
                        'didVolunteerMakeAnImpact':
                            slider[_value.toInt()].toString(),
                        'occupation': _cValue,
                        'tasksCompletedArray': widget.taskslist,
                        'impact_score': _value.toString(),
                        'whyDid': _currentValue,
                      });
                      _updateEvent
                          .child(widget.name)
                          .child('volunteers')
                          .child(loggedInUser.uid)
                          .update({
                        'total_time': diff.toString(),
                        'didVolunteerMakeAnImpact':
                            slider[_value.toInt()].toString(),
                        'occupation': _cValue,
                        'tasksCompletedArray': widget.taskslist,
                        'impact_score': _value.toString(),
                        'whyDid': _currentValue,
                      });
                      _updateCharity
                          .child(uid)
                          .child('list_of_events')
                          .child(widget.name)
                          .child('volunteers')
                          .child(loggedInUser.uid)
                          .update({
                        'total_time': diff.toString(),
                        'didVolunteerMakeAnImpact':
                            slider[_value.toInt()].toString(),
                        'occupation': _cValue,
                        'tasksCompletedArray': widget.taskslist,
                        'impact_score': _value.toString(),
                        'whyDid': _currentValue,
                      });
                      _updateEvent1.child(widget.name).update({
                        'total_volunteer_time': volhrs,
                      });
                      _updateCharity1
                          .child(uid)
                          .child('list_of_events')
                          .child(widget.name)
                          .update({
                        'total_volunteer_time': volhrs,
                      });
                      _updateVolunteer1.child(loggedInUser.uid).update({
                        'total_career_time': careerhrs,
                      });
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            title: Text(
                              "Ready to Submit Survey",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                              "This will added to the event, make sure its correct",
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
                                  Navigator.pushNamed(
                                    context,
                                    'nav_screen',
                                  );
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
