import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_1/constant/languages.dart';
import 'package:pfe_1/home/home.dart';
import 'package:pfe_1/main.dart';
import 'package:pfe_1/profile/privacy_terms/privacy.dart';
import 'package:pfe_1/profile/privacy_terms/terms.dart';
import 'package:pfe_1/theme/themeNotifier.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Settingss extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settingss> {
  bool _isDarkMode = false;
  bool _notificationsEnabled = false;
  String? _selectedOption;

  @override
  void initState() {
    super.initState();
    getToken();
    _checkNotificationStatus();
    _getSelectedLanguageFromFirestore();
  }

  Future<void> getToken() async {
    String? myToken = await FirebaseMessaging.instance.getToken();
    print("#####################################");
    print(myToken);
  }

  Future<void> _checkNotificationStatus() async {
    NotificationSettings settings =
        await FirebaseMessaging.instance.getNotificationSettings();
    setState(() {
      _notificationsEnabled =
          settings.authorizationStatus == AuthorizationStatus.authorized;
    });
  }

  Future<void> _toggleNotifications(bool value) async {
    if (value) {
      await FirebaseMessaging.instance.subscribeToTopic('all');
    } else {
      await FirebaseMessaging.instance.unsubscribeFromTopic('all');
    }
    setState(() {
      _notificationsEnabled = value;
    });
  }

  Future<void> _getSelectedLanguageFromFirestore() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user!.uid)
          .get();

      if (userData.exists && userData.data() != null) {
        setState(() {
          _selectedOption = userData.data()!['selectedLanguage'];
        });
      }
    } catch (error) {
      print('Error fetching data from Firestore: $error');
    }
  }

  List<Language> languageList = Language.languageList();
  Language? selectedLanguage;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = ThemeNotifier.of(context);

    if (themeNotifier == null) {
      return Scaffold(
        body: Center(
          child: Text("ThemeNotifier not found!"),
        ),
      );
    }

    _isDarkMode = themeNotifier.themeModeNotifier.value == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Image.asset(
            "assets/Back_Button.png",
            height: 80.0,
            width: 80.0,
            fit: BoxFit.cover,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("home");
          },
          iconSize: 30.0,
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Center(
            child: Text(
              "Settings",
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF3DB2FF)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Language",
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Container(
                        width: 200, // Define a fixed width for the container
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Language>(
                            isExpanded: true,
                            value: selectedLanguage,
                            onChanged: (Language? language) async {
                              final User? user1 =
                                  FirebaseAuth.instance.currentUser;
                              String? _uid = user1!.uid;
                              selectedLanguage = language;
                              await FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(_uid)
                                  .update({
                                'selectedLanguage': language!.languageCode,
                              });

                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()),
                              );

                              print(
                                  'Langue sélectionnée : ${language.languageCode}');
                              if (selectedLanguage?.languageCode == "ar") {
                                MyApp.setLocale(context, const Locale('ar'));
                              } else if (selectedLanguage?.languageCode ==
                                  'fr') {
                                MyApp.setLocale(context, const Locale('fr'));
                              } else if (selectedLanguage?.languageCode ==
                                  'en') {
                                MyApp.setLocale(context, const Locale('en'));
                              }
                            },
                            dropdownColor: Colors.white,
                            icon: Icon(Icons.arrow_drop_down,
                                color: Color(0xFF3DB2FF)),
                            items: languageList.map((Language language) {
                              return DropdownMenuItem<Language>(
                                value: language,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Row(
                                    children: [
                                      Text(language.flag,
                                          style: TextStyle(fontSize: 20)),
                                      SizedBox(width: 8),
                                      Text(language.name,
                                          style: GoogleFonts.poppins()),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xFF3DB2FF)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Dark Mode",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Switch(
                            value: _isDarkMode,
                            onChanged: (bool value) {
                              setState(() {
                                _isDarkMode = value;
                                themeNotifier.themeModeNotifier.value =
                                    value ? ThemeMode.dark : ThemeMode.light;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Color(0xFF3DB2FF)),
                    _buildListTile(
                      title: "Terms and Conditions",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsAndConditionsPage(),
                          ),
                        );
                      },
                    ),
                    Divider(color: Color(0xFF3DB2FF)),
                    _buildListTile(
                      title: "Privacy Policy",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyPolicyPage(),
                          ),
                        );
                      },
                    ),
                    Divider(color: Color(0xFF3DB2FF)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Notification",
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Switch(
                            value: _notificationsEnabled,
                            onChanged: _toggleNotifications,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({required String title, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.asset(
                "assets/CaretRight.png",
                height: 24,
                width: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
