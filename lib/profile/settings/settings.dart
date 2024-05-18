import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_1/profile/privacy_terms/privacy.dart';
import 'package:pfe_1/profile/privacy_terms/terms.dart';
import 'package:pfe_1/theme/themeNotifier.dart';

class Settingss extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settingss> {
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    // Accédez à ThemeNotifier dans la méthode build
    final themeNotifier = ThemeNotifier.of(context);
    if (themeNotifier == null) {
      // Gérez le cas où ThemeNotifier n'est pas trouvé
      return Scaffold(
        body: Center(
          child: Text("ThemeNotifier not found!"),
        ),
      );
    }

    // Récupérez la valeur actuelle de ThemeMode
    _isDarkMode = themeNotifier.themeModeNotifier.value == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        leading: IconButton(
          icon: Image.asset(
            "assets/Back_Button.png",
            height: 30.0,
            width: 30.0,
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
                // color: Color.fromARGB(255, 0, 0, 0),
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
                border: Border.all(color: Colors.grey),
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
                          "First Language",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.asset(
                        "assets/CaretRight.png",
                        height: 24,
                        width: 24,
                      ),
                    )
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
                  border: Border.all(color: Colors.grey),
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
                                // Mettez à jour le ThemeMode via ThemeNotifier
                                themeNotifier.themeModeNotifier.value =
                                    value ? ThemeMode.dark : ThemeMode.light;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TermsAndConditionsPage()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Terms and Conditions",
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
                    ),
                    Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyPolicyPage()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Privacy Policy",
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
                    ),
                    Divider(color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyPolicyPage()),
                          );
                        },
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
}
