import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:git_hub_tracker/Core/View/partials/avatar_websource.dart';
import 'package:git_hub_tracker/core/constants/styles/main_styles.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/github_event.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload_create.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/others/github_repository.dart';
import 'package:git_hub_tracker/core/view/partials/link_launcher.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card.dart';
import 'package:markdown_viewer/markdown_viewer.dart';

//static const BRANCH = 'branch';

class ContentCardCreate extends ContentCard {
  final GitHubEventPayloadCreate payload;
  final GitHubRepository repository;
  final GitHubEvent event;
  final String message;

  const ContentCardCreate({
    Key? key,
    required this.payload,
    required this.event,
    required this.repository,
    required this.message,
  }) : super(key: key);

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
                Row(
                  children: [
                    const VerticalDivider(
                      width: 10,
                      color: Colors.transparent,
                    ),
                    MarkdownViewer(
                      EmojiParser().emojify(message),
                      styleSheet: const MarkdownStyle(
                        textStyle: kDefaultPayloadTextStyle,
                      ),
                    ),
                    const VerticalDivider(
                      width: 5,
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
                        EmojiParser().emojify(payload.description),
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

class ContentCardCreateTag extends ContentCard {
  final GitHubEventPayloadCreate payload;
  final GitHubRepository repository;
  final GitHubEvent event;

  const ContentCardCreateTag({
    Key? key,
    required this.payload,
    required this.event,
    required this.repository,
  }) : super(key: key);

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

                const VerticalDivider(
                  width: 3,
                  color: Colors.transparent,
                ),

                MarkdownViewer(
                  EmojiParser().emojify(' have been created by'),
                  styleSheet: const MarkdownStyle(
                    textStyle: kDefaultPayloadTextStyle,
                  ),
                ),

                const VerticalDivider(
                  width: 5,
                  color: Colors.transparent,
                ),

                IntrinsicWidth(
                  child: LinkLauncher(
                    url: Uri.parse(
                        'https://github.com/${event.actor.login}'),
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
                        EmojiParser().emojify(payload.description),
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

class ContentCardCreateBranch extends ContentCard {
  final GitHubEventPayloadCreate payload;
  final GitHubRepository repository;
  final GitHubEvent event;

  const ContentCardCreateBranch({
    Key? key,
    required this.payload,
    required this.event,
    required this.repository,
  }) : super(key: key);

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
                      .emojify('${payload.ref} branch have been created by '),
                  styleSheet: const MarkdownStyle(
                    textStyle: kDefaultPayloadTextStyle,
                  ),
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
