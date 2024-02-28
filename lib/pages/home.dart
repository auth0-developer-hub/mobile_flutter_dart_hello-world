import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helloworld/widgets/app_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map> auth0Features = [
    {
      'icon':
          'https://cdn.auth0.com/blog/hello-auth0/identity-providers-logo.svg',
      'title': 'Identity Provider',
      'description':
          'Auth0 supports social providers such as Google, Facebook, and Twitter, along with Enterprise providers such as Microsoft Office 365, Google Apps, and Azure. You can also use any OAuth 2.0 Authorization Server.',
      'url': 'https://auth0.com/docs/connections'
    },
    {
      'icon': 'https://cdn.auth0.com/blog/hello-auth0/mfa-logo.svg',
      'title': 'Multi-Factor Authentication',
      "description":
          "Auth0 can detect attacks and stop malicious attempts to access your application such as blocking traffic from certain IPs and displaying CAPTCHA. Auth0 supports the principle of layered protection in security that uses a variety of signals to detect and mitigate attacks.",
      'url': 'https://auth0.com/docs/multifactor-authentication'
    },
    {
      'icon':
          'https://cdn.auth0.com/blog/hello-auth0/advanced-protection-logo.svg',
      'title': 'Attack Protection',
      "description":
          "Auth0 can detect attacks and stop malicious attempts to access your application such as blocking traffic from certain IPs and displaying CAPTCHA. Auth0 supports the principle of layered protection in security that uses a variety of signals to detect and mitigate attacks.",
      "url": "https://auth0.com/docs/attack-protection"
    },
    {
      'icon': 'https://cdn.auth0.com/blog/hello-auth0/private-cloud-logo.svg',
      'title': 'Serverless Extensibility',
      'description':
          'Actions are functions that allow you to customize the behavior of Auth0. Each action is bound to a specific triggering event on the Auth0 platform. Auth0 invokes the custom code of these Actions when the corresponding triggering event is produced at runtime.',
      "url": "https://auth0.com/docs/actions"
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  openUrl(urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
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
          shape:
              const Border(bottom: BorderSide(color: Colors.white, width: 1)),
        ),
        endDrawer: const AppDrawer('home'),
        body: Container(
          color: Colors.black,
          child: ListView(
            children: [
              Container(
                  padding: const EdgeInsets.all(25),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      // Where the linear gradient begins and ends
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      // Add one stop for each color. Stops should increase from 0 to 1
                      stops: [0.1, 0.5],
                      colors: [
                        // Colors are easy thanks to Flutter's Colors class.
                        Color.fromRGBO(62, 198, 235, 1),
                        Color.fromRGBO(27, 201, 159, 1),
                      ],
                    ),
                  ),
                  child: Column(children: [
                    Container(
                      height: 60,
                      width: 60,
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: SvgPicture.network(
                        'https://cdn.auth0.com/website/blog/developer-hub/flutter-logo.svg',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                    const Text(
                      'Hello, Flutter World!',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Colors.black),
                    ),
                    const Text(
                      'This is a sample application that demonstrates the authentication flow for Flutter apps using Auth0.',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        final Uri url = Uri.parse(
                            'https://developer.auth0.com/resources/code-samples/mobile/flutter/basic-authentication');
                        launchUrl(url);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // <-- Radius
                        ),
                      ),
                      child: const Text('Check out the Flutter code sample',
                          style: TextStyle(color: Colors.black)),
                    )
                  ])),
              const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'Explore Auth0 Features',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        color: Colors.white),
                  )),
              Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Column(
                      children: List.generate(auth0Features.length, (index) {
                    return GestureDetector(
                        onTap: () => {openUrl(auth0Features[index]['url'])},
                        child: Container(
                          padding: const EdgeInsets.all(25),
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                SvgPicture.network(
                                    auth0Features[index]['icon']),
                                Flexible(
                                    child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    auth0Features[index]['title'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25,
                                    ),
                                  ),
                                ))
                              ]),
                              Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child:
                                      Text(auth0Features[index]['description']))
                            ],
                          ),
                        ));
                  })))
            ],
          ),
        ));
  }
}
