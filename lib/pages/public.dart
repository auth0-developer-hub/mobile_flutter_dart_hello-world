import 'package:helloworld/pages/home.dart';
import 'package:helloworld/helpers/constants.dart';
import 'package:helloworld/widgets/app_drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PublicData {
  final String text;

  const PublicData({
    required this.text,
  });

  factory PublicData.fromJson(Map<String, dynamic> json) {
    return PublicData(
      text: json['text'],
    );
  }
}

Future<PublicData> fetchPublicData() async {
  final response = await http.get(Uri.parse('$serverUrl/api/messages/public'));

  if (response.statusCode == 200) {
    return PublicData.fromJson(jsonDecode(response.body));
  } else {
    throw response.body;
  }
}

class PublicPage extends StatefulWidget {
  const PublicPage({super.key});

  @override
  State<PublicPage> createState() => _PublicPageState();
}

class _PublicPageState extends State<PublicPage> {
  late Future<PublicData> publicData;
  @override
  void initState() {
    super.initState();
    publicData = fetchPublicData();
  }

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
      endDrawer: const AppDrawer('public'),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          const Text(
            'Public Page',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text(
            'This page retrieves a public message.',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text('Any visitor can access this page.',
              style: TextStyle(fontSize: 16, color: Colors.white)),
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
              'Public Message',
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
              child: FutureBuilder<PublicData>(
                  future: publicData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                      String message =
                          encoder.convert({'text': snapshot.data?.text});
                      return Text(
                        message,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'RobotoMono'),
                      );
                    } else {
                      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
                      String message = encoder.convert({
                        "message":
                            "Http failure response for http://localhost:6060/api/messages/public: 0 Unknown Error"
                      });
                      if (snapshot.hasError) {
                        message = snapshot.error.toString();
                      }
                      return Text(
                        message,
                        style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'RobotoMono'),
                      );
                    }
                  }))
        ]),
      ),
    );
  }
}
