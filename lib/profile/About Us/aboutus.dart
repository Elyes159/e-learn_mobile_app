// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_1/constant/customlogo.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('À propos de nous' , style: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Center(child: Customlogo(),),
              SizedBox(height: 50),
              Text(
                'Notre Projet',
                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400,color: Color(0xFF3DB2FF)),
              ),
              SizedBox(height: 10),
              Text(
                "Une application mobile d’apprentissage linguistique multilingue nommée KifKif, où elle offre une variété de fonctionnalités qui s'adaptent à différents styles d'apprentissage tels que Exercices, Niveaux, Chat Multilingue et Reconnaissance d'Objets.",
                style: GoogleFonts.poppins(fontSize: 16,color:Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                'Missions et Valeurs',
                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400,color: Color(0xFF3DB2FF)),
              ),
              SizedBox(height: 10),
              Text(
                'Notre mission est de créer des solutions innovantes et de qualité qui répondent aux besoins de nos clients. Nous valorisons l\'intégrité, l\'innovation et l\'excellence.',
                style: GoogleFonts.poppins(fontSize: 16,color:Colors.black),
              ),
              SizedBox(height: 20),
              Text(
                'Notre équipe',
                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400,color: Color(0xFF3DB2FF)),
              ),
              SizedBox(height: 10),
              CustomListtile(name: "Walid Hssairi", role: "Chef d\'équipe", imagesname: "hssairi.jpg"),
              SizedBox(height: 10),
              CustomListtile(name: "Elyes Mlik",  role: "Développeur", imagesname: "elyes.jpg"),
              SizedBox(height: 10),
              CustomListtile(name: "Yousra Guirat", role: "Développeur", imagesname: "yosra.jpg"),
              SizedBox(height: 20),
              Text(
                'Contactez-nous',
                style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400,color: Color(0xFF3DB2FF)),
              ),
              SizedBox(height: 10),
              Custom(email: "walid.hassairi53@gmail.com", phoneNumber: "73 683 100", imageName: "hssairi.jpg",facebookUrl:"https://www.facebook.com/walid.hassairi"),
              SizedBox(height: 10),
              Custom(email: "elyesmlik307@gmail.com", phoneNumber: "58118637", imageName: "elyes.jpg",facebookUrl:"https://www.facebook.com/erret3y"),
              SizedBox(height: 10),
              Custom(email: "yousraguirat124@gmail.com", phoneNumber: "54620408", imageName: "hssairi.jpg",facebookUrl:"https://www.facebook.com/profile.php?id=100009427353577"),
            ],
          ),
        ),
      ),
    );
  }
}
class CustomListtile extends StatelessWidget{
  final String name;
  final String role;
  final String imagesname;
  const CustomListtile (
    {super.key, required this.name,required this.role,required this.imagesname});
    
      @override
      Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:MainAxisAlignment.start,
      children: [
        Container(
          height: 70,
          width: 70,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.asset("assets/$imagesname",fit: BoxFit.cover,)),
        ), 
        Expanded(
          child: Center(
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text("$name",style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold,),textAlign: TextAlign.right,),
              Text("$role",style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey[600]),textAlign: TextAlign.right),
              ],
            ),
          ),
        )
      ],
    );
      }
    }
class Contact extends StatelessWidget {
  final String Email;
  final String Phone_number;
  final String imagePath;

  Contact({required this.Email, required this.Phone_number, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
          Container(
            height: 65,
            width: 65,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset("assets/$imagePath",fit: BoxFit.cover,)),
          ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Email,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),
                ),
                Text(
                  Phone_number,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



class Custom extends StatelessWidget {
  final String email;
  final String phoneNumber;
  final String imageName;
  final String facebookUrl;

  const Custom({
    Key? key,
    required this.email,
    required this.phoneNumber,
    required this.imageName,
    required this.facebookUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 65,
          width: 65,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.asset(
              "assets/$imageName",
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: ListTile(
              tileColor :Colors.white,
              title: Text(
                email,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
              subtitle: Text(
                phoneNumber,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                ),
              ),
              trailing: GestureDetector(
                onTap: () => _launchURL(facebookUrl),
                child: Icon(
                  Icons.facebook_rounded,
                  size: 30,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future <void> _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}




