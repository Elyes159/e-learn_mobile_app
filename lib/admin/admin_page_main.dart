import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_1/admin/add_questionsMain.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_1/admin/users.dart';
import 'package:pfe_1/starting/signin.dart';

class Admin_main extends StatefulWidget {
  @override
  _Admin_mainState createState() => _Admin_mainState();
}

class _Admin_mainState extends State<Admin_main> {
  Future<void> sendNotificationIfInactive() async {
    QuerySnapshot usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    DateTime twoDaysAgo = DateTime.now().subtract(Duration(seconds: 2));

    for (var userDoc in usersSnapshot.docs) {
      var userData = userDoc.data() as Map<String, dynamic>?;

      if (userData != null && userData.containsKey('time_spent')) {
        int lastTimeSpentMillis = userData['time_spent'];
        DateTime lastActive =
            DateTime.fromMillisecondsSinceEpoch(lastTimeSpentMillis);

        if (lastActive.isBefore(twoDaysAgo)) {
          await sendNotification(userData['fcmToken'], userData['username']);
        }
      }
    }
  }

  Future<void> sendNotification(String? token, String? username) async {
    if (token == null) {
      print("FCM token is null");
      return;
    }

    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAkrZ33uU:APA91bFmD8g0KJw7pwsSCXxq5tbLnh8WCYqsR4-LvwooC1ASL5hSLUkYtGSCJ2U4-IWHNl1YinHkOhZK991jHwQG9JV1VbNAII2LOX-TWa7t2fHA0TpCTnxHaEEHS5rd52ia5GFj8uuL',
    };

    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var body = {
      "to": token,
      "notification": {
        "title": "Hi $username",
        "body": "Restart your language journey!\nYou know what to do!",
        "mutable_content": true,
        "sound": "Tri-tone"
      }
    };

    var req = http.Request('POST', url);
    req.headers.addAll(headersList);
    req.body = json.encode(body);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(resBody);
      print(res.statusCode);
      print("mriiiiiiiiiiiiiiiiiiiiiigl");
    } else {
      print(res.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 200.0,
              color: Color(0xFF3DB2FF),
              child: Center(
                child: Text('Admin Page',
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 24)),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3DB2FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      textStyle: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    },
                    child: Text("  Ajouter des questions  ",
                        style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3DB2FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserListPage()),
                      );
                    },
                    child: Text("   Gérer les utilisateurs   ",
                        style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3DB2FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed("AddLeconFromAdmin");
                    },
                    child: Text("     Ajouter des leçons     ",
                        style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3DB2FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed("AddCourseAdmin");
                    },
                    child: Text("      Ajouter des cours      ",
                        style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3DB2FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    onPressed: sendNotificationIfInactive,
                    child: Text("Envoyer une notification",
                        style: GoogleFonts.poppins(color: Colors.white)),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Center(
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                            Text(
                              "Logout",
                              style: GoogleFonts.poppins(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
