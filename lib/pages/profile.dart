import 'dart:convert';

import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:helloworld/pages/home.dart';
import 'package:helloworld/widgets/app_drawer.dart';
import 'dart:convert';

class ProfileData {
  final String text;

  const ProfileData({
    required this.text,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      text: json['text'],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  final UserProfile user;

  @override
  Widget build(BuildContext context) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');

    String prettyprint = encoder.convert({
      "address": user.address,
      "birthdate": user.birthdate,
      "email": user.email,
      "name": user.name,
      "givenName": user.givenName,
      "middleName": user.middleName,
      "familyName": user.familyName,
      "profileUrl": user.profileUrl.toString(),
      "customClaims": user.customClaims,
      "gender": user.gender,
      "isEmailVerified": user.isEmailVerified,
      "isPhoneNumberVerified": user.isPhoneNumberVerified,
      "pictureUrl": user.pictureUrl.toString(),
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        foregroundColor: Colors.white,
        title: GestureDetector(
            child: SvgPicture.network(
                'https://cdn.auth0.com/blog/hub/code-samples/hello-world/auth0-logo.svg',
                fit: BoxFit.fitHeight,
                height: 24),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomePage()));
            }),
        backgroundColor: Colors.black,
        shape: const Border(bottom: BorderSide(color: Colors.white, width: 1)),
      ),
      endDrawer: const AppDrawer('profile'),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          const Text(
            'Profile Page',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text('Only authenticated users can access this page.',
              style: TextStyle(fontSize: 16, color: Colors.white)),
          const SizedBox(height: 20),

          // user information
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular((25))),
                child: Image.network(
                  user.pictureUrl.toString(),
                  fit: BoxFit.fill,
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name != null ? user.name! : '',
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Text(user.email != null ? user.email! : '',
                      style: const TextStyle(fontSize: 14, color: Colors.white))
                ],
              ))
            ],
          ),
          const SizedBox(height: 20),
          // code snippet container
          Container(
            padding:
                const EdgeInsets.only(top: 10, right: 20, bottom: 10, left: 20),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(189, 196, 207, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            child: const Text(
              'User Profile Object',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Color.fromRGBO(42, 46, 53, 1),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  prettyprint,
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: 'RobotoMono'),
                ),
              ))
        ]),
      ),
    );
  }
}
