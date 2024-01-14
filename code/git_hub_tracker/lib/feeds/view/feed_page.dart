import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:git_hub_tracker/core/constants/const.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/github_api.dart';
import 'package:git_hub_tracker/core/view/partials/avatar.dart';
import 'package:git_hub_tracker/core/view/partials/avatar_websource.dart';
import 'package:git_hub_tracker/feeds/view/partials/feed_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
    print('TryRefresh');
    setState(() {});
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


  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Feed"),
        leading: const Avatar(imagePath: "assets/images/title.png"),
        actions: <Widget>[
          FutureBuilder<String>(
              future: GitHubApiSingleTon.api.getCurrentUserAvatar(),
              builder: (BuildContext context, AsyncSnapshot<String> future){
                if(future.hasData){
                  return IconButton(
                    icon: AvatarWebSource(imagePath: future.data ?? kErrorAvatarUrl),
                    tooltip: 'UserList',
                    onPressed: _openEndDrawer,
                  );
                }
                else{
                  return IconButton(
                    icon: const AvatarWebSource(imagePath: kErrorAvatarUrl),
                    tooltip: 'UserList',
                    onPressed: _openEndDrawer,
                  );
                }
              }),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: FutureBuilder<List<FeedCard>>(
        future: GitHubApiSingleTon.api.getFeed(kFeedRowNumber),
        builder: (context, future){
          if(!future.hasData){
            return Center(
              child: LoadingAnimationWidget.discreteCircle(color: kDefaultIconDarkColor, size: 200),
            );
          }else{
            List<FeedCard> feed = future.data!;
            return ListView.builder(
                addAutomaticKeepAlives: true,
                itemBuilder: (context, index){
                  return feed[index];
                },
                itemCount: feed.length,
            );
          }
        },
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
    ),
    onWillPop: () async{
        SystemNavigator.pop();
        return false;
      },
    );
  }
}
