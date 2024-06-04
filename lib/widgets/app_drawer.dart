import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helloworld/pages/admin.dart';
import 'package:helloworld/pages/home.dart';
import 'package:helloworld/pages/profile.dart';
import 'package:helloworld/pages/protected.dart';
import 'package:helloworld/pages/public.dart';
import 'package:helloworld/services/auth_service.dart';

class AppDrawer extends StatefulWidget {
  final String activePage;
  const AppDrawer(this.activePage, {super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  UserProfile? profile;

  @override
  void initState() {
    super.initState();
    initAuth();
  }

  void initAuth() async {
    await AuthService.instance.init();
    setState(() => profile = AuthService.instance.profile);
  }

  @override
  Widget build(BuildContext context) {
    void login() async {
      final navigator = Navigator.of(context);
      await AuthService.instance.login();
      navigator.pop();
      navigator.pushReplacement(
          MaterialPageRoute(builder: (context) => ProfilePage(user: profile!)));
    }

    void signup() async {
      final navigator = Navigator.of(context);
      await AuthService.instance.signup();
      navigator.pop();
      navigator.pushReplacement(
          MaterialPageRoute(builder: (context) => ProfilePage(user: profile!)));
    }

    void logout() async {
      final navigator = Navigator.of(context);
      await AuthService.instance.logout();
      navigator.pop();
      navigator.pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    }

    return Drawer(
        backgroundColor: Colors.black,
        width: double.infinity,
        child: ListView(
          padding: EdgeInsets.zero,
          children: ListTile.divideTiles(context: context, tiles: [
            Column(children: [
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          child: SvgPicture.network(
                              'https://cdn.auth0.com/blog/hub/code-samples/hello-world/auth0-logo.svg',
                              fit: BoxFit.fitHeight,
                              height: 24),
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          }),
                      const CloseButton(
                        color: Colors.white,
                      )
                    ]),
              )
            ]),
            ListTile(
              title: Text(
                'Profile',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationThickness: widget.activePage == 'profile' ? 2 : 0,
                    decorationColor: const Color(0xff413DA6)),
              ),
              onTap: () {
                if (profile != null) {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage(user: profile!)));
                } else {
                  login();
                }
              },
            ),
            ListTile(
              title: Text(
                'Public',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                    decorationStyle: TextDecorationStyle.solid,
                    decorationThickness: widget.activePage == 'public' ? 2 : 0,
                    decorationColor: const Color(0xff413DA6)),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PublicPage()));
              },
            ),
            if (profile != null)
              ListTile(
                title: Text(
                  'Protected',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationThickness:
                          widget.activePage == 'protected' ? 2 : 0,
                      decorationColor: const Color(0xff413DA6)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProtectedPage()));
                },
              ),
            if (profile != null)
              ListTile(
                title: Text(
                  'Admin',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                      decorationStyle: TextDecorationStyle.solid,
                      decorationThickness: widget.activePage == 'admin' ? 2 : 0,
                      decorationColor: const Color(0xff413DA6)),
                ),
                shape: const Border(
                    bottom: BorderSide(color: Color(0xffB9B3BD), width: 1)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminPage()));
                },
              ),
            Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: profile == null
                        ? [
                            OutlinedButton(
                              onPressed: () {
                                signup();
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text('Sign Up',
                                  style: TextStyle(color: Colors.white)),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                login();
                              },
                              style: ElevatedButton.styleFrom(
                                // #635DFF
                                backgroundColor: const Color.fromRGBO(
                                    99, 93, 255, 1), // Background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text('Log In',
                                  style: TextStyle(color: Colors.white)),
                            )
                          ]
                        : [
                            ElevatedButton(
                              onPressed: () {
                                logout();
                              },
                              style: ElevatedButton.styleFrom(
                                // #635DFF
                                backgroundColor: const Color.fromRGBO(
                                    99, 93, 255, 1), // Background color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Text('Log Out',
                                  style: TextStyle(color: Colors.white)),
                            )
                          ]))
          ]).toList(),
        ));
  }
}
