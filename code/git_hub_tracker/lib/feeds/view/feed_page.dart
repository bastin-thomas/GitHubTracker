import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/view/partials/avatar.dart';
import 'package:git_hub_tracker/core/view/partials/avatar_websource.dart';
import 'package:git_hub_tracker/core/view/partials/content_default_text.dart';
import 'package:git_hub_tracker/feeds/view/partials/feed_card.dart';

import 'partials/drawer/logout_button.dart';
import 'partials/drawer/resync_button.dart';
import 'partials/drawer/tracked_repository.dart';
import 'partials/drawer/tracked_users.dart';


class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);


  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  Future<void> _refresh() async {
    //ToDO
  }

  String getAvatar() {
    return "user.avatarUrl";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Feed"),
        leading: const Avatar(imagePath: "assets/images/title.png"),
        actions: <Widget>[
          IconButton(
            icon: AvatarWebSource(imagePath: getAvatar()),
            tooltip: 'UserList',
            onPressed: _openEndDrawer,
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: ListView(
        children: [
          FeedCard(
            publishDate: DateTime.now(),
            image: getAvatar(),
            userName: "todo",
            contentCard: const ContentDefaultTEXT(),
          ),
          FeedCard(
            publishDate: DateTime.now(),
            image: "https://avatars.githubusercontent.com/u/98758556?v=4",
            userName: "Bidule",
            contentCard: const ContentDefaultTEXT(),
          ),
          FeedCard(
            publishDate: DateTime.now(),
            image: "https://avatars.githubusercontent.com/u/98758556?v=4",
            userName: "Pitite",
            contentCard: const ContentDefaultTEXT(),
          ),
          FeedCard(
            publishDate: DateTime.now(),
            image: "https://avatars.githubusercontent.com/u/98758556?v=4",
            userName: "Oui-Oui",
            contentCard: const ContentDefaultTEXT(),
          ),
          FeedCard(
            publishDate: DateTime.now(),
            image: "https://avatars.githubusercontent.com/u/98758556?v=4",
            userName: "Non-Non",
            contentCard: const ContentDefaultTEXT(),
          ),
        ],
      ),
      ),
      endDrawer: Drawer(
        child: Container(
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const <Widget>[
              ReSyncButton(),
              TrackedRepository(),
              TrackedUser(),
              LogoutButton(),
            ],
          ),
        ),
      ),
    );
  }
}
