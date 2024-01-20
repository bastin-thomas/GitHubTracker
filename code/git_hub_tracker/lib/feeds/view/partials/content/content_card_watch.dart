import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:git_hub_tracker/Core/View/partials/avatar_websource.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/model/github_library/event/github_event.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload_watch.dart';
import 'package:git_hub_tracker/core/view/partials/link_launcher.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

class ContentCardWatch extends ContentCard {
  final GitHubEventPayloadWatch payload;
  final GitHubEvent event;
  const ContentCardWatch({Key? key, required this.payload, required this.event,}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                MarkdownViewer(
                  EmojiParser().emojify('have been starred by '),
                  styleSheet: const MarkdownStyle(
                    textStyle: TextStyle(
                        color: kPayloadTextColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                ),
                const VerticalDivider(width: 3, color: Colors.transparent,),
                LinkLauncher(
                  url: Uri.parse('https://github.com/${event.actor.login}'),
                  child: Row(
                    children: [
                      MarkdownViewer(
                        EmojiParser().emojify(' ${event.actor.display_login}'),
                        styleSheet: const MarkdownStyle(
                          textStyle: TextStyle(
                              color: kPayloadTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                      const VerticalDivider(width: 3, color: Colors.transparent,),
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
