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
    QuerySnapshot usersSnapshot =
        await FirebaseFirestore.instance.collection('users').get();

    DateTime twoDaysAgo = DateTime.now().subtract(Duration(days: 2));

    for (var userDoc in usersSnapshot.docs) {
      var userData = userDoc.data() as Map<String, dynamic>?;

      if (userData != null && userData.containsKey('time_spent')) {
        int lastTimeSpentMillis = userData['time_spent'];
        DateTime lastActive =
            DateTime.fromMillisecondsSinceEpoch(lastTimeSpentMillis);

        if (lastActive.isBefore(twoDaysAgo)) {
          await sendNotification(userData['fcmToken']);
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
      'Authorization':
          'key=AAAAkrZ33uU:APA91bFmD8g0KJw7pwsSCXxq5tbLnh8WCYqsR4-LvwooC1ASL5hSLUkYtGSCJ2U4-IWHNl1YinHkOhZK991jHwQG9JV1VbNAII2LOX-TWa7t2fHA0TpCTnxHaEEHS5rd52ia5GFj8uuL',
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
      print("mriiiiiiiiiiiiiiiiiiiiiigl");
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
