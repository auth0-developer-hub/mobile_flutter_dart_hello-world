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
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular((25))),
                child: Image.network(
                  'https://cdn.auth0.com/blog/hello-auth0/auth0-user.png',
                  fit: BoxFit.fill,
                  height: 50,
                  width: 50,
                ),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('One Customer',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  Text('customer@example.com',
                      style: TextStyle(fontSize: 14, color: Colors.white))
                ],
              )
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
              child: Text(
                const JsonEncoder.withIndent('  ').convert({
                  "nickname": "Customer",
                  "name": "One Customer",
                  "picture":
                      "https://cdn.auth0.com/blog/hello-auth/auth0-user.png",
                  "updated_at": "2021-05-04T21:33:09.415Z",
                  "email": "customer@example.com",
                  "email_verified": false,
                  "sub": "auth0|12345678901234567890"
                }),
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'RobotoMono'),
              ))
        ]),
      ),
    );
  }
}
