import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
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
Terms and Conditions

Welcome to [App Name]!

These terms and conditions outline the rules and regulations for the use of [Company]'s App, located at [App URL].

By accessing this app we assume you accept these terms and conditions. Do not continue to use [App Name] if you do not agree to take all of the terms and conditions stated on this page.

License
Unless otherwise stated, [Company] and/or its licensors own the intellectual property rights for all material on [App Name]. All intellectual property rights are reserved. You may access this from [App Name] for your own personal use subjected to restrictions set in these terms and conditions.

You must not:
- Republish material from [App Name]
- Sell, rent or sub-license material from [App Name]
- Reproduce, duplicate or copy material from [App Name]
- Redistribute content from [App Name]

This Agreement shall begin on the date hereof.

User Comments
Parts of this app offer an opportunity for users to post and exchange opinions and information in certain areas of the website. [Company] does not filter, edit, publish or review Comments prior to their presence on the website. Comments do not reflect the views and opinions of [Company],its agents and/or affiliates. Comments reflect the views and opinions of the person who post their views and opinions. To the extent permitted by applicable laws, [Company] shall not be liable for the Comments or for any liability, damages or expenses caused and/or suffered as a result of any use of and/or posting of and/or appearance of the Comments on this app.

[Company] reserves the right to monitor all Comments and to remove any Comments which can be considered inappropriate, offensive or causes breach of these Terms and Conditions.

Hyperlinking to our Content
The following organizations may link to our App without prior written approval:
- Government agencies;
- Search engines;
- News organizations;
- Online directory distributors may link to our App in the same manner as they hyperlink to the Apps of other listed businesses; and
- System wide Accredited Businesses except soliciting non-profit organizations, charity shopping malls, and charity fundraising groups which may not hyperlink to our Web site.

These organizations may link to our home page, to publications or to other App information so long as the link: (a) is not in any way deceptive; (b) does not falsely imply sponsorship, endorsement or approval of the linking party and its products and/or services; and (c) fits within the context of the linking party's site.

iFrames
Without prior approval and written permission, you may not create frames around our Webpages that alter in any way the visual presentation or appearance of our App.

Content Liability
We shall not be hold responsible for any content that appears on your App. You agree to protect and defend us against all claims that is rising on your App. No link(s) should appear on any App that may be interpreted as libelous, obscene or criminal, or which infringes, otherwise violates, or advocates the infringement or other violation of, any third party rights.

Reservation of Rights
We reserve the right to request that you remove all links or any particular link to our App. You approve to immediately remove all links to our App upon request. We also reserve the right to amen these terms and conditions and it’s linking policy at any time. By continuously linking to our App, you agree to be bound to and follow these linking terms and conditions.

Removal of links from our App
If you find any link on our App that is offensive for any reason, you are free to contact and inform us any moment. We will consider requests to remove links but we are not obligated to or so or to respond to you directly.

We do not ensure that the information on this app is correct, we do not warrant its completeness or accuracy; nor do we promise to ensure that the app remains available or that the material on the app is kept up to date.

Disclaimer
To the maximum extent permitted by applicable law, we exclude all representations, warranties and conditions relating to our app and the use of this app. Nothing in this disclaimer will:
- limit or exclude our or your liability for death or personal injury;
- limit or exclude our or your liability for fraud or fraudulent misrepresentation;
- limit any of our or your liabilities in any way that is not permitted under applicable law; or
- exclude any of our or your liabilities that may not be excluded under applicable law.

The limitations and prohibitions of liability set in this Section and elsewhere in this disclaimer: (a) are subject to the preceding paragraph; and (b) govern all liabilities arising under the disclaimer, including liabilities arising in contract, in tort and for breach of statutory duty.

As long as the app and the information and services on the app are provided free of charge, we will not be liable for any loss or damage of any nature.
            ''',
            style: GoogleFonts.poppins(fontSize: 16),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}
