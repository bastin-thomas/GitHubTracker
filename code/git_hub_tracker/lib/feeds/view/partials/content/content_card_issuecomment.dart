import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload_issuecomment.dart';
import 'package:git_hub_tracker/core/model/github_library/github_issue_comment.dart';
import 'package:git_hub_tracker/core/logic/utils.dart';
import 'package:git_hub_tracker/core/view/partials/link_launcher.dart';
import 'package:git_hub_tracker/core/view/partials/small_avatar_websource.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card.dart';
import 'package:markdown_viewer/markdown_viewer.dart';


class ContentCardIssueComment extends ContentCard {
  final GitHubEventPayloadIssueComment eventIssueComment;
  final GitHubIssueComment issueComment;
  const ContentCardIssueComment(this.issueComment, {Key? key, required this.eventIssueComment}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        children: [
          const Divider(height: 4, color: Colors.transparent),
          LinkLauncher(
            url: Uri.parse(eventIssueComment.comment.html_url),
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
                  MarkdownViewer(
                    EmojiParser().emojify(issueComment.body),
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
                        imagePath: eventIssueComment.comment.user['avatar_url'],
                      ),
                      const VerticalDivider(color: Colors.white),
                      Text(
                          DisplayDate(eventIssueComment.comment.created_at),
                          style: const TextStyle(
                            color: Colors.white38, fontSize: 12),
                      ),
                      const VerticalDivider(color: Colors.white),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: [
                            Text(
                              '${issueComment.reactions['+1']}',
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
                              '   ${issueComment.reactions['-1']}',
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
