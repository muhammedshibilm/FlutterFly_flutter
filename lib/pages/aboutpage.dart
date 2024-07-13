import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Aboutpage extends StatelessWidget {
  Aboutpage({super.key});

  final _phone = "+919876543210";
  final _url = Uri.parse("https://flutter.dev");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About page",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () async {
                final url = Uri(scheme: "tel", path: _phone);
                if (await canLaunchUrl(url)) {
                  launchUrl(url);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Contact me ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(
                        Icons.phone_forwarded,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                launchUrl(_url, mode: LaunchMode.inAppBrowserView);
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Visite ",
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(
                        Icons.arrow_right_alt_rounded,
                        size: 30,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
