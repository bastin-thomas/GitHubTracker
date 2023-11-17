import 'package:flutter/material.dart';
import 'package:git_hub_tracker/Routes/routes.dart';
import 'package:git_hub_tracker/cards/Contents/Content_DefaultTEXT.dart';
import 'package:git_hub_tracker/cards/FeedCard.dart';
import 'package:git_hub_tracker/partials/Avatar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:git_hub_tracker/partials/Avatar_Websource.dart';
import 'package:git_hub_tracker/partials/Drawer/TrackedRepository.dart';
import 'package:git_hub_tracker/styles/constants.dart';
import '../partials/Drawer/LogoutButton.dart';
import '../partials/Drawer/ReSyncButton.dart';
import '../partials/Drawer/TrackedRepository.dart';
import '../partials/Drawer/TrackedUsers.dart';


class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);


  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  //User user = FirebaseAuth.instance.currentUser!;


  Future<void> _refresh() async {
    //ToDO
  }

  String getAvatar() {
    //return user.avatarUrl;
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
            content_card: const Content_DefaultTEXT(),
          ),
          FeedCard(
            publishDate: DateTime.now(),
            image: "https://avatars.githubusercontent.com/u/98758556?v=4",
            userName: "Bidule",
            content_card: const Content_DefaultTEXT(),
          ),
          FeedCard(
            publishDate: DateTime.now(),
            image: "https://avatars.githubusercontent.com/u/98758556?v=4",
            userName: "Pitite",
            content_card: const Content_DefaultTEXT(),
          ),
          FeedCard(
            publishDate: DateTime.now(),
            image: "https://avatars.githubusercontent.com/u/98758556?v=4",
            userName: "Oui-Oui",
            content_card: const Content_DefaultTEXT(),
          ),
          FeedCard(
            publishDate: DateTime.now(),
            image: "https://avatars.githubusercontent.com/u/98758556?v=4",
            userName: "Non-Non",
            content_card: const Content_DefaultTEXT(),
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
