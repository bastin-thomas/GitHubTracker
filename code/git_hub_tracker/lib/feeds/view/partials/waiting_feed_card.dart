import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/const.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/logic/utils.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_default_text.dart';
import 'package:git_hub_tracker/feeds/view/partials/feed_card.dart';
import 'package:git_hub_tracker/feeds/view/partials/my_user_tag.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';




class WaitingFeedCard extends FeedCard {
  const WaitingFeedCard({super.key, required super.publishDate,
    required super.image, 
    required super.title, 
    required super.uri, 
    required super.contentCard, 
    required super.subtitle});

  factory WaitingFeedCard.Default() => WaitingFeedCard(
    publishDate: DateTime.fromMillisecondsSinceEpoch(0),
    image: kErrorAvatarUrl,
    title: kErrorName,
    uri: Uri.http('127.0.0.1','/'),
    contentCard: const ContentDefaultTEXT(),
    subtitle: '',
  );

  @override
  Widget build(BuildContext context) {
    return const Center(
      child:Column(children: [
        Divider(height: 10, color: Colors.transparent,),
        SizedBox(
          height: 75,
          width: 75,
          child: CircularProgressIndicator(
            color: kDefaultIconDarkColor,
            strokeWidth: 10,
          ),
        ),
        Divider(height: 10, color: Colors.transparent,),
      ],),
    );
  }

  
}
