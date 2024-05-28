import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
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
        final replacements = match['replacements'];

        if (replacements != null && replacements.isNotEmpty) {
          final replacement = replacements[0]['value'];
          correctedText =
              correctedText.replaceRange(offset, offset + length, replacement);
        }
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40, left: 20, right: 16, bottom: 16),
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.zero,
                  child: Image.asset(
                    'assets/Chat1.png',
                    height: 45,
                    width: 40,
                  ),
                ),
                SizedBox(width: 30),
                Text(
                  "Chat Page",
                  style: GoogleFonts.poppins(fontSize: 24),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _firestore
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var messages = snapshot.data?.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: messages!.length,
                  itemBuilder: (context, index) {
                    final User? user1 = FirebaseAuth.instance.currentUser;
                    var messageText = messages[index]['text'];
                    var messageSender = messages[index]['sender'];
                    var lansender = messages[index]['language'];
                    var emailMsg = messages[index]['email'];

                    return FutureBuilder<String?>(
                      future: _getUserSelectedLanguage(user1!.uid),
                      builder: (context, languageSnapshot) {
                        if (!languageSnapshot.hasData) {
                          return SizedBox();
                        }
                        String? lanDestinaire = languageSnapshot.data;

                        if (lanDestinaire != null) {
                          return FutureBuilder<String>(
                            future: translate(
                                messageText, lansender, lanDestinaire),
                            builder: (context, translationSnapshot) {
                              if (!translationSnapshot.hasData) {
                                return SizedBox();
                              }
                              String translatedMessage =
                                  translationSnapshot.data!;
                              final User? user1 =
                                  FirebaseAuth.instance.currentUser;
                              final email = user1!.email;

                              return MessageWidget(
                                messageSender ?? "",
                                translatedMessage,
                                test: email == emailMsg,
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
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: Colors.blue,
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Entrez votre message...',
                      prefixIcon:
                          Icon(Icons.message_outlined, color: Colors.blue),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Color(0xff3DB2FF),
                    ),
                    onPressed: () async {
                      final User? user1 = FirebaseAuth.instance.currentUser;
                      String? username = await _getUserUsername(user1!.uid);
                      await _firestore.collection('messages').add({
                        'text': _messageController.text,
                        'sender': username,
                        'timestamp': FieldValue.serverTimestamp(),
                        'language': await _getUserSelectedLanguage(user1.uid),
                        'email': user1.email,
                      });
                      _messageController.clear();
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
  final bool test;

  MessageWidget(this.sender, this.message, {super.key, required this.test});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            test ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: test
                  ? const EdgeInsets.only(right: 20.0)
                  : const EdgeInsets.only(left: 20.0),
              child: Text(
                "$sender",
                style: GoogleFonts.poppins(),
              ),
            ),
          ),
          BubbleSpecialThree(
            text: message,
            color: test ? const Color(0xFF3DB2FF) : Color(0xFFE8E8E8),
            tail: true,
            textStyle: GoogleFonts.poppins(
                color: test ? Colors.white : Colors.black, fontSize: 16),
            isSender: test,
          ),
          SizedBox(height: 4.0),
        ],
      ),
    );
  }
}
