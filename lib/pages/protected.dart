import 'package:helloworld/pages/home.dart';
import 'package:helloworld/helpers/constants.dart';
import 'package:helloworld/widgets/app_drawer.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:auth0_flutter/auth0_flutter.dart';

class ProtectedData {
  final String text;

  const ProtectedData({
    required this.text,
  });

  factory ProtectedData.fromJson(Map<String, dynamic> json) {
    return ProtectedData(
      text: json['text'],
    );
  }
}

class ProtectedPage extends StatefulWidget {
  const ProtectedPage({super.key});

  @override
  State<ProtectedPage> createState() => _ProtectedPageState();
}

Future<ProtectedData> fetchProtectedData() async {
  Auth0 auth0 = Auth0(auth0Domain, auth0ClientId);

  // setting the audience here doesn't seem to work
  final credentials = await auth0.credentialsManager
      .credentials(parameters: {'audience': auth0Audience});
  final String accessToken = credentials.accessToken;
  final response = await http.get(
    Uri.parse('$serverUrl/api/messages/protected'),
    headers: {'Authorization': 'Bearer $accessToken'},
  );

  if (response.statusCode == 200) {
    return ProtectedData.fromJson(jsonDecode(response.body));
  } else {
    throw response.body;
  }
}

class _ProtectedPageState extends State<ProtectedPage> {
  late Future<ProtectedData> protectedData;
  @override
  void initState() {
    super.initState();
    protectedData = fetchProtectedData();
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
      endDrawer: const AppDrawer('protected'),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          const Text(
            'Protected Page',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text(
            'This page retrieves a protected message.',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text('Only authenticated users should access this page.',
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
              'Protected Message',
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
              child: FutureBuilder<ProtectedData>(
                  future: protectedData,
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
                            "Http failure response for http://localhost:6060/api/messages/protected: 0 Unknown Error"
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
