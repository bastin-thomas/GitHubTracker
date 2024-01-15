import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/github_event.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload_issue.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/others/github_issue.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/utils.dart';
import 'package:git_hub_tracker/core/view/partials/small_avatar_websource.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card.dart';
import 'package:url_launcher/url_launcher.dart';

class ContentCardIssue extends ContentCard {
  final GitHubEventPayloadIssue payload;
  final GitHubEvent event;
  final GitHubIssue issue;

  const ContentCardIssue({Key? key, required this.payload, required this.event, required this.issue,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool singleTap = true;

    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          const Divider(height: 4, color: Colors.transparent),
          GestureDetector(
            onTap: () async {
              if (singleTap) {
                await launchUrl( Uri.parse(payload.issue.html_url));
                singleTap = false;
              }

              //reset after some times
              Future.delayed(const Duration(milliseconds: 250)).then((value) {
                singleTap = true;
              });
            },
            child: Container(
              width: double.infinity,
              decoration: kBoxDecorationInner,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${issue.title}: ',
                      style: const TextStyle(
                          color: kPayloadTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20
                      ),
                      overflow: TextOverflow.visible,
                      softWrap: true,

                    ),
                  ),

                  Text(
                    EmojiParser().emojify(issue.body),
                    style: const TextStyle(
                        color: kPayloadTextColor,
                        fontWeight: FontWeight.normal,
                        fontSize: 14),
                  ),
                  Row(
                    children: [
                      SmallAvatarWebSource(
                        imagePath: payload.issue.user['avatar_url'],
                      ),
                      const VerticalDivider(color: Colors.white),
                      Text(
                        DisplayDate(payload.issue.created_at),
                        style: const TextStyle(
                            color: Colors.white38, fontSize: 12),
                      ),
                      const VerticalDivider(color: Colors.white),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: [

                            Text(
                              EmojiParser().emojify('${issue.reactions['+1']} :+1:'),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  color: Colors.white30,
                                  fontSize: 12),
                            ),
                            const Text(
                              ' | ',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 12),
                            ),
                            Text(
                              EmojiParser().emojify('   ${issue.reactions['-1']} :-1:'),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  color: Colors.white30, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 4, color: Colors.transparent),
        ],
      ),
    );
  }
}