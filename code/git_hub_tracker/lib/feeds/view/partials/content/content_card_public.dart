import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:git_hub_tracker/Core/View/partials/avatar_websource.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/model/github_library/event/github_event.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload_public.dart';
import 'package:git_hub_tracker/core/model/github_library/github_repository.dart';
import 'package:git_hub_tracker/core/view/partials/link_launcher.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

//static const BRANCH = 'branch';

class ContentCardPublic extends ContentCard {
  final GitHubEventPayloadPublic payload;
  final GitHubRepository repository;
  final GitHubEvent event;

  const ContentCardPublic({
    super.key,
    required this.payload,
    required this.event,
    required this.repository,
  });

  @override
  String toChips() => 'Public';

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
                          EmojiParser().emojify(' has been put to '),
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
                              .emojify(' Public '),
                          styleSheet: const MarkdownStyle(
                            textStyle: TextStyle(
                              color: Colors.blueAccent,
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
                          EmojiParser().emojify(' by '),
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



                const Divider(
                  height: 15,
                  color: Colors.transparent,
                ),
                Container(
                  width: double.infinity,
                  decoration: kBoxDecorationInner,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Wrap(
                    children: [
                      MarkdownViewer(
                        EmojiParser().emojify('Description: '),
                        styleSheet: const MarkdownStyle(
                            textStyle: kBoldPayloadTextStyle),
                      ),
                      MarkdownViewer(
                        EmojiParser().emojify(repository.description),
                        styleSheet: const MarkdownStyle(
                            textStyle: kDefaultPayloadTextStyle),
                      ),
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