import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkLauncher extends StatelessWidget {
  final Uri url;
  final Widget child;
  const LinkLauncher({super.key, required this.url, required this.child});

  @override
  Widget build(BuildContext context) {
    bool singleTap = true;

    return GestureDetector(
      onTap: () async {
        if (singleTap) {
          singleTap = false;
          if (Uri.http('127.0.0.1', '/').path != url) {
            await launchUrl(url);
          }
        }

        //reset after some times
        Future.delayed(const Duration(milliseconds: 250))
            .then((value) {
          singleTap = true;
        });
      },
      child: child,
    );
  }
}
