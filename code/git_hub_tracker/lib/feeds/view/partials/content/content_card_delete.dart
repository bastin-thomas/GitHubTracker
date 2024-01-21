import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:git_hub_tracker/Core/View/partials/avatar_websource.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/model/github_library/event/github_event.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload_delete.dart';
import 'package:git_hub_tracker/core/model/github_library/github_repository.dart';
import 'package:git_hub_tracker/core/view/partials/link_launcher.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

class ContentCardDeleteTag extends ContentCard {
  final GitHubEventPayloadDelete payload;
  final GitHubRepository repository;
  final GitHubEvent event;

  const ContentCardDeleteTag({
    super.key,
    required this.payload,
    required this.event,
    required this.repository,
  });

  @override
  String toChips() => 'Delete';

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Divider(height: 4, color: Colors.transparent),
          Container(
            width: double.infinity,
            decoration: kBoxDecorationInner,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            alignment: Alignment.centerLeft,
            child: Wrap(
              children: [
                const VerticalDivider(
                  width: 3,
                  color: Colors.transparent,
                ),

                Container(
                  decoration: kBoxDecorationInner,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  child: IntrinsicWidth(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const VerticalDivider(
                          width: 3,
                          color: Colors.transparent,
                        ),
                        Text(
                          payload.ref,
                          style: kDefaultPayloadTextStyle,
                        ),
                        const VerticalDivider(
                          width: 3,
                          color: Colors.transparent,
                        ),
                        MarkdownViewer(
                          EmojiParser().emojify(':label:'),
                          styleSheet: const MarkdownStyle(
                            textStyle: kDefaultPayloadTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


                IntrinsicWidth(
                  child: LinkLauncher(
                    url: Uri.parse(
                        'https://github.com/${event.actor.login}'),
                    child: Row(
                      children: [
                        const VerticalDivider(
                          width: 3,
                          color: Colors.transparent,
                        ),

                        MarkdownViewer(
                          EmojiParser().emojify(' have been '),
                          styleSheet: const MarkdownStyle(
                            textStyle: kDefaultPayloadTextStyle,
                          ),
                        ),

                        const VerticalDivider(
                          width: 3,
                          color: Colors.transparent,
                        ),

                        MarkdownViewer(
                          EmojiParser()
                              .emojify(' deleted '),
                          styleSheet: const MarkdownStyle(
                            textStyle: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        const VerticalDivider(
                          width: 3,
                          color: Colors.transparent,
                        ),

                        MarkdownViewer(
                          EmojiParser().emojify(' by'),
                          styleSheet: const MarkdownStyle(
                            textStyle: kDefaultPayloadTextStyle,
                          ),
                        ),


                        const VerticalDivider(
                          width: 5,
                          color: Colors.transparent,
                        ),

                        MarkdownViewer(
                          EmojiParser()
                              .emojify(' ${event.actor.display_login}'),
                          styleSheet: const MarkdownStyle(
                            textStyle: kBoldPayloadTextStyle,
                          ),
                        ),
                        const VerticalDivider(
                          width: 3,
                          color: Colors.transparent,
                        ),
                        AvatarWebSource(imagePath: event.actor.avatar_url),
                      ],
                    ),
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
/*
*
*
*
*
*
*
*
*
*
*
* */
class ContentCardDeleteBranch extends ContentCard {
  final GitHubEventPayloadDelete payload;
  final GitHubRepository repository;
  final GitHubEvent event;

  @override
  String toChips() => 'Delete';

  const ContentCardDeleteBranch({
    super.key,
    required this.payload,
    required this.event,
    required this.repository,
  });

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
            child: Wrap(
              children: [
                const VerticalDivider(
                  width: 3,
                  color: Colors.transparent,
                ),
                MarkdownViewer(
                  EmojiParser()
                      .emojify('${payload.ref} branch have been '),
                  styleSheet: const MarkdownStyle(
                    textStyle: kDefaultPayloadTextStyle,
                  ),
                ),

                const VerticalDivider(
                  width: 3,
                  color: Colors.transparent,
                ),

                MarkdownViewer(
                  EmojiParser()
                      .emojify(' deleted '),
                  styleSheet: const MarkdownStyle(
                    textStyle: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),

                const VerticalDivider(
                  width: 3,
                  color: Colors.transparent,
                ),

                MarkdownViewer(
                  EmojiParser()
                      .emojify(' by '),
                  styleSheet: const MarkdownStyle(
                    textStyle: kDefaultPayloadTextStyle,
                  ),
                ),

                const VerticalDivider(
                  width: 3,
                  color: Colors.transparent,
                ),


                Row(
                  children: [
                    const VerticalDivider(
                      width: 3,
                      color: Colors.transparent,
                    ),
                    LinkLauncher(
                      url: Uri.parse('https://github.com/${event.actor.login}'),
                      child: Row(
                        children: [
                          MarkdownViewer(
                            EmojiParser()
                                .emojify(' ${event.actor.display_login}'),
                            styleSheet: const MarkdownStyle(
                              textStyle: kBoldPayloadTextStyle,
                            ),
                          ),
                          const VerticalDivider(
                            width: 3,
                            color: Colors.transparent,
                          ),
                          AvatarWebSource(imagePath: event.actor.avatar_url),
                        ],
                      ),
                    ),
                  ],
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
