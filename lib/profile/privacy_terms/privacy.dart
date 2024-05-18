import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Privacy Policy',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            '''
Privacy Policy

Your privacy is important to us. It is [Your Company]'s policy to respect your privacy regarding any information we may collect from you through our app, [App Name].

Information We Collect
We only collect information about you if we have a reason to do so. For example, to provide our services, to communicate with you, or to make our services better.

Log Data
When you use our app, we may collect data and information (through third-party products) on your phone called Log Data. This Log Data may include information such as your device Internet Protocol (“IP”) address, device name, operating system version, the configuration of the app when utilizing our service, the time and date of your use of the service, and other statistics.

Personal Information
We may ask for personal information, such as your:
- Name
- Email
- Phone/mobile number
- Address

Use of Information
We may use the information we collect in various ways, including to:
- Provide, operate, and maintain our app
- Improve, personalize, and expand our app
- Understand and analyze how you use our app
- Develop new products, services, features, and functionality
- Communicate with you, either directly or through one of our partners, including for customer service, to provide you with updates and other information relating to the app, and for marketing and promotional purposes

Security
The security of your personal information is important to us, but remember that no method of transmission over the Internet, or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your personal information, we cannot guarantee its absolute security.

Changes to This Privacy Policy
We may update our Privacy Policy from time to time. Thus, you are advised to review this page periodically for any changes. We will notify you of any changes by posting the new Privacy Policy on this page.

Contact Us
If you have any questions or suggestions about our Privacy Policy, do not hesitate to contact us at [Your Contact Information].
            ''',
            style: GoogleFonts.poppins(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
