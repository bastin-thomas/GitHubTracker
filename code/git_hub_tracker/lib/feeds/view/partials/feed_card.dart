import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/const.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/utils.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_default_text.dart';
import 'package:git_hub_tracker/feeds/view/partials/my_user_tag.dart';

class FeedCardFactory{
  static FeedCard Default(){
    return FeedCard(
      publishDate: DateTime.fromMillisecondsSinceEpoch(0),
      image: kErrorAvatarUrl,
      title: kErrorName,
      uri: Uri.http('127.0.0.1','/'),
      contentCard: const ContentDefaultTEXT(),
      subtitle: '',
    );
  }
}

class FeedCard extends StatelessWidget {
  final DateTime publishDate;
  final String image;
  final String title;
  final Uri uri;
  final ContentCard contentCard;
  final String subtitle;

  const FeedCard(
      {required this.publishDate,
      required this.image,
      required this.title,
      required this.uri,
      required this.contentCard,
      Key? key, required this.subtitle,}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
      margin: const EdgeInsets.fromLTRB(2, 5, 2, 0),
      decoration: BoxDecoration(
        boxShadow: cBoxShadowItem,
        color: kMainBackgroundColor,
        borderRadius: kBorderRadius15,
      ),
      child: Column(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: TitleCard(title: title, titleUrl: uri, image: image, subtitle: subtitle,),
              ),
              const Divider(height: 5, color: kMainBackgroundColor),
            ]
          ),

          Column(
            children:[
              contentCard,
            ],
          ),

          Column(children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Text(DisplayDate(publishDate),
                  textAlign: TextAlign.left,
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
