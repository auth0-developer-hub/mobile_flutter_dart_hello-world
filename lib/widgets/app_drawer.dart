import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:helloworld/pages/admin.dart';
import 'package:helloworld/pages/home.dart';
import 'package:helloworld/pages/profile.dart';
import 'package:helloworld/pages/protected.dart';
import 'package:helloworld/pages/public.dart';

class AppDrawer extends StatefulWidget {
  final String activePage;
  const AppDrawer(this.activePage, {super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfilePage()));
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
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const AdminPage()));
              },
            ),
          ]).toList(),
        ));
  }
}
