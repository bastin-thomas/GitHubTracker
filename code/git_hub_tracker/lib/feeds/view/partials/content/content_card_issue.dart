import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/model/github_library/event/github_event.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload_issue.dart';
import 'package:git_hub_tracker/core/model/github_library/github_issue.dart';
import 'package:git_hub_tracker/core/logic/utils.dart';
import 'package:git_hub_tracker/core/view/partials/link_launcher.dart';
import 'package:git_hub_tracker/core/view/partials/small_avatar_websource.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

class ContentCardIssue extends ContentCard {
  final GitHubEventPayloadIssue payload;
  final GitHubEvent event;
  final GitHubIssue issue;

  const ContentCardIssue({super.key, required this.payload, required this.event, required this.issue,});

  @override
  String toChips() => 'Issue';

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          const Divider(height: 4, color: Colors.transparent),
          LinkLauncher(
            url: payload.issue.html_url,
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

                  MarkdownViewer(
                    EmojiParser().emojify(issue.body),
                    styleSheet: const MarkdownStyle(
                      textStyle: TextStyle(
                          color: kPayloadTextColor,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                  ),
                  const Divider(height: 3, color: Colors.transparent,),
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
                              '${issue.reactions['+1']}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  color: Colors.white38,
                                  fontSize: 12),
                            ),
                            Text(
                              EmojiParser().emojify(' :+1:'),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 12),
                            ),
                            const Text(
                              ' | ',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: Colors.white38, fontSize: 12),
                            ),
                            Text(
                              '   ${issue.reactions['-1']}',
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  color: Colors.white38, fontSize: 12),
                            ),
                            Text(
                              EmojiParser().emojify(' :-1:'),
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 12),
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
