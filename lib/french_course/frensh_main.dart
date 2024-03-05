import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FrenchCourse extends StatefulWidget {
  @override
  _FrenchCourseState createState() => _FrenchCourseState();
}

class _FrenchCourseState extends State<FrenchCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
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
          iconSize: 100.0,
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset(
              "assets/les_francais.png",
              width: 240,
              height: 240,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "Learn Frensh",
              style:
                  GoogleFonts.poppins(fontSize: 25, color: Color(0xFF43463F)),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 310,
                  height: 77,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 56,
                          width: 50.13,
                          decoration: BoxDecoration(
                            color: Color(0xFF8BC34A),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Image.asset("assets/Handshake.png"),
                              Text(
                                "LEVEL 1",
                                style: GoogleFonts.robotoMono(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 15.0, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Introduction",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100)),
                                width: 200,
                                child: LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xFF8BC34A),
                                  backgroundColor: Color(0xFFE5E5E5),
                                  value: 0.5,
                                  minHeight: 8,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 310,
                  height: 77,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 56,
                          width: 50.13,
                          decoration: BoxDecoration(
                            color: Color(0xFFFBB237),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Image.asset("assets/BookBookmark.png"),
                              Text(
                                "LEVEL 2",
                                style: GoogleFonts.robotoMono(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 15.0, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Grammar",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100)),
                                width: 200,
                                child: LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xFFFFA000),
                                  backgroundColor: Color(0xFFE5E5E5),
                                  value: 0.5,
                                  minHeight: 8,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 310,
                  height: 77,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          height: 56,
                          width: 50.13,
                          decoration: BoxDecoration(
                            color: Color(0xFFFF4B4C),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Image.asset("assets/Fire.png"),
                              Text(
                                "LEVEL 1",
                                style: GoogleFonts.robotoMono(
                                  fontSize: 10,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 15.0, top: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Introduction",
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100)),
                                width: 200,
                                child: LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(100),
                                  color: Color(0xFFD72714),
                                  backgroundColor: Color(0xFFE5E5E5),
                                  value: 0.5,
                                  minHeight: 8,
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
            ],
          ),
        ],
      ),
    );
  }
}
