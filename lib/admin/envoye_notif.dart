import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class NotificationButtonPage extends StatefulWidget {
  @override
  _NotificationButtonPageState createState() => _NotificationButtonPageState();
}

class _NotificationButtonPageState extends State<NotificationButtonPage> {
  Future<void> sendNotificationIfInactive() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        Timestamp? lastTimeSpent = userDoc['time_spent'];
        if (lastTimeSpent != null) {
          DateTime lastActive = lastTimeSpent.toDate();
          DateTime twoDaysAgo = DateTime.now().subtract(Duration(seconds: 2));

          if (lastActive.isBefore(twoDaysAgo)) {
            await sendNotification(userDoc['fcmToken']);
          }
        }
      }
    }
  }

  Future<void> sendNotification(String? token) async {
    if (token == null) {
      print("FCM token is null");
      return;
    }

    var headersList = {
      'Accept': '*/*',
      'User-Agent': 'Thunder Client (https://www.thunderclient.com)',
      'Content-Type': 'application/json',
      'Authorization': 'key=YOUR_SERVER_KEY_HERE',
    };

    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');

    var body = {
      "to": token,
      "notification": {
        "title": "Rappel",
        "body": "Tu m'a oublié",
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
    } else {
      print(res.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Button Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: sendNotificationIfInactive,
          child: Text('Send Notification if Inactive'),
        ),
      ),
    );
  }
}
