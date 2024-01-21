import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/const.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_default_text.dart';
import 'package:git_hub_tracker/feeds/view/partials/feed_card.dart';

class EndFeedCard extends FeedCard {
  const EndFeedCard({super.key, required super.publishDate,
    required super.image,
    required super.title,
    required super.uri,
    required super.contentCard,
    required super.subtitle});

  factory EndFeedCard.Default() => EndFeedCard(
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
        Divider(height: 50, color: Colors.transparent,),
        Text(
          'No More Data to Show',
          style: TextStyle(color: Colors.black),
        ),
        Divider(height: 50, color: Colors.transparent,),
      ],),
    );
  }
}
