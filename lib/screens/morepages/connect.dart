import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:stopwatch/components/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ConnectPage extends StatefulWidget {
  @override
  _ConnectPageState createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  String _launchFB = 'https://www.facebook.com/GlimpseGlobal';
  String _launchTW = 'https://twitter.com/GlimpseGlobal';
  String _launchIG = 'https://www.instagram.com/glimpseglobal/';

  Future<void> _launchSocial(String url) async {
    if (await canLaunch(url)) {
      final bool nativeApp = await launch(
        url,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
      if (!nativeApp) {
        await launch(
          url,
          forceSafariVC: true,
        );
      }
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        width: double.infinity,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.close,
                color: ktextColorD,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: IconButton(
                icon: FaIcon(FontAwesomeIcons.facebookF),
                iconSize: 32,
                color: Colors.white,
                onPressed: () {
                  _launchSocial(_launchFB);
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: IconButton(
                icon: FaIcon(FontAwesomeIcons.twitter),
                iconSize: 32,
                color: Colors.white,
                onPressed: () {
                  _launchSocial(_launchTW);
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: IconButton(
                icon: FaIcon(FontAwesomeIcons.instagram),
                iconSize: 32,
                color: Colors.white,
                onPressed: () {
                  _launchSocial(_launchIG);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
