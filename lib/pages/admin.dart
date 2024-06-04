import 'package:helloworld/widgets/app_drawer.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AdminData {
  final String text;

  const AdminData({
    required this.text,
  });

  factory AdminData.fromJson(Map<String, dynamic> json) {
    return AdminData(
      text: json['text'],
    );
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late Future<AdminData> adminData;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        foregroundColor: Colors.white,
        title: SvgPicture.network(
            'https://cdn.auth0.com/blog/hub/code-samples/hello-world/auth0-logo.svg',
            fit: BoxFit.fitHeight,
            height: 24),
        backgroundColor: Colors.black,
        shape: const Border(bottom: BorderSide(color: Colors.white, width: 1)),
      ),
      endDrawer: const AppDrawer('admin'),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          const Text(
            'Admin Page',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text(
            'This page retrieves an admin message.',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 10),
          RichText(
              text: const TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  children: <TextSpan>[
                TextSpan(text: 'Only authenticated users with the '),
                TextSpan(
                    text: 'read:admin-messages',
                    style: TextStyle(color: Color(0xff16A380))),
                TextSpan(text: ' permission should access this page.'),
              ])),
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
              'Admin Message',
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
                const JsonEncoder.withIndent('  ')
                    .convert({"message": "This is an admin message"}),
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
