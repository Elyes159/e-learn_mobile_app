import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:translator/translator.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _messageController = TextEditingController();
  final translator = GoogleTranslator();

  Future<String> translate(
      String sourceText, String fromLanguage, String toLanguage) async {
    var translation = await translator.translate(sourceText,
        from: fromLanguage, to: toLanguage);
    return translation.text;
  }

  Future<String?> correctSpelling(String text) async {
    final String apiUrl =
        'https://languagetool.org/api/v2/check?language=fr&text=$text';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final matches = jsonResponse['matches'];

      String correctedText = text;

      for (var match in matches) {
        final offset = match['offset'];
        final length = match['length'];
        final replacement = match['replacements'][0];

        correctedText = correctedText.replaceRange(
          offset,
          offset + length,
          replacement,
        );
      }

      return correctedText;
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<String?> _getUserSelectedLanguage(String userId) async {
    var userSnapshot = await _firestore.collection('users').doc(userId).get();
    return userSnapshot.data()?['selectedLanguage'];
  }

  Future<String?> _getUserUsername(String userId) async {
    var userSnapshot = await _firestore.collection('users').doc(userId).get();
    return userSnapshot.data()?['username'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Color(0xFF3DB2FF), // Couleur de l'application
        actions: [
          // IconButton(
          //   icon: Icon(Icons.exit_to_app),
          //   // onPressed: () async {
          //   //   await _auth.signOut();
          //   //   Navigator.pop(context);
          //   // },
          // ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                }
                var messages = snapshot.data?.docs.reversed;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages!.length,
                  itemBuilder: (context, index) {
                    final User? user1 = FirebaseAuth.instance.currentUser;
                    var messageText = messages.elementAt(index)['text'];
                    var messageSender = messages.elementAt(index)['sender'];
                    var lansender = messages.elementAt(index)['language'];

                    return FutureBuilder<String?>(
                      future: _getUserSelectedLanguage(user1!.uid),
                      builder: (context, languageSnapshot) {
                        if (!languageSnapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        String? lanDestinaire = languageSnapshot.data;

                        if (lanDestinaire != null) {
                          return FutureBuilder<String>(
                            future: translate(
                                messageText, lansender, lanDestinaire),
                            builder: (context, translationSnapshot) {
                              if (!translationSnapshot.hasData) {
                                return CircularProgressIndicator();
                              }
                              String translatedMessage =
                                  translationSnapshot.data!;

                              return MessageWidget(
                                messageSender ?? "",
                                translatedMessage,
                              );
                            },
                          );
                        } else {
                          return SizedBox(); // Retourne un widget vide si la langue de destination n'est pas disponible.
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
          Container(
            color: Color(0xFF3DB2FF), // Couleur de l'application
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Entrez votre message...',
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      final User? user1 = FirebaseAuth.instance.currentUser;
                      String? username = await _getUserUsername(user1!.uid);
                      // ignore: unnecessary_null_comparison
                      if (user1 != null) {
                        await _firestore.collection('messages').add({
                          'text': _messageController.text,
                          'sender': username,
                          'timestamp': FieldValue.serverTimestamp(),
                          'language': await _getUserSelectedLanguage(user1.uid),
                          'email': user1.email,
                        });
                        _messageController.clear();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String sender;
  final String message;

  MessageWidget(this.sender, this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 4.0),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              message,
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
