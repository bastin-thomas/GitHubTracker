import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:git_hub_tracker/Core/View/partials/avatar_websource.dart';
import 'package:git_hub_tracker/core/constants/const.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/github_event.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload_issuecomment.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload_watch.dart';
import 'package:git_hub_tracker/core/view/partials/small_avatar_websource.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentCardWatch extends ContentCard {
  final GitHubEventPayloadWatch payload;
  final GitHubEvent event;
  const ContentCardWatch({Key? key, required this.payload, required this.event,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool singleTap = true;

    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          const Divider(height: 4, color: Colors.transparent),
          Container(
            width: double.infinity,
            decoration: kBoxDecorationInner,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            child: Row(
              children: [
                Text(
                  EmojiParser().emojify('have been starred by '),
                  style: const TextStyle(
                      color: kPayloadTextColor,
                      fontWeight: FontWeight.normal,
                      fontSize: 14),
                  overflow: TextOverflow.visible,
                  softWrap: true,
                ),
                GestureDetector(
                onTap: () async {
                  if (singleTap) {
                    await launchUrl( Uri.parse('https://github.com/${event.actor.login}'));
                    singleTap = false;
                  }

                  //reset after some times
                  Future.delayed(const Duration(milliseconds: 250)).then((value) {
                    singleTap = true;
                  });
                },
                child: Row(
                  children: [
                    Text(
                      EmojiParser().emojify(event.actor.display_login),
                      style: const TextStyle(
                          color: kPayloadTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      overflow: TextOverflow.visible,
                      softWrap: true,
                    ),
                    const VerticalDivider(width: 5, color: Colors.transparent),
                    AvatarWebSource(imagePath: event.actor.avatar_url),
                  ],
                ),
                ),
              ],
            ),
          ),
          const Divider(height: 4, color: Colors.transparent),
        ],
      ),
    );
  }
}
