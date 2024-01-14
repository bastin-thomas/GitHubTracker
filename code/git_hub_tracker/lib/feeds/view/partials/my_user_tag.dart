import 'package:axis_layout/axis_layout.dart';
import 'package:flutter/material.dart';
import 'package:git_hub_tracker/Core/View/partials/avatar_websource.dart';
import 'package:url_launcher/url_launcher.dart';

class TitleCard extends StatelessWidget {
  final String image;
  final String title;
  final Uri titleUrl;
  final String subtitle;

  const TitleCard({
    required this.image,
    required this.title,
    required this.titleUrl,
    Key? key,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool singleTap = true;

    return SizedBox(
      width: double.infinity,
      child: AxisLayout(
        axis: Axis.horizontal,
        children: [
          AvatarWebSource(imagePath: image),
          const VerticalDivider(),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              GestureDetector(
                onTap: () async {
                  if (singleTap) {
                    if (titleUrl.path != Uri.http('127.0.0.1', '/').path) {
                      await launchUrl(titleUrl);
                    }

                    singleTap = false;
                  }

                  //reset after some times
                  Future.delayed(const Duration(milliseconds: 100))
                      .then((value) {
                    singleTap = true;
                  });
                },
                  child: SizedBox(
                    width: 300,
                    child:
                    Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.blueAccent),
                      softWrap: false,
                      maxLines: 1,
                      textWidthBasis: TextWidthBasis.parent,
                    ),
                  ),
                ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
