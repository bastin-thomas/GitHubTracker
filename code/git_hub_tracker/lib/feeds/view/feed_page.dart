import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/const.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/github_api.dart';
import 'package:git_hub_tracker/core/view/partials/avatar.dart';
import 'package:git_hub_tracker/core/view/partials/avatar_websource.dart';
import 'package:git_hub_tracker/feeds/view/feed_end_drawer.dart';
import 'package:git_hub_tracker/feeds/view/partials/feed_card.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();


  final List<FeedCard> _feedCards = [];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text("Feed"),
        leading: const Avatar(imagePath: "assets/images/title.png"),
        actions: <Widget>[
          FutureBuilder<String>(
              future: GitHubApiSingleTon.api.getCurrentUserAvatar(),
              builder: (BuildContext context, AsyncSnapshot<String> future) {
                if (future.hasData) {
                  return IconButton(
                    icon: AvatarWebSource(
                        imagePath: future.data ?? kErrorAvatarUrl),
                    tooltip: 'UserList',
                    onPressed: _openEndDrawer,
                  );
                } else {
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
        onRefresh: _onRefresh,
        child: FutureBuilder<List<FeedCard>>(
          future: GitHubApiSingleTon.api.getFeed(kFirstFeedRowNumber),
          builder: _onInitialFetch,
        ),
      ),
      endDrawer: const FeedPageEndDrawer(),
    );
  }

  Future<void> _onRefresh() async {
    var list = await GitHubApiSingleTon.api.getFeed(kFeedRowNumber);
    _feedCards.clear();
    _feedCards.addAll(list);

    return Future.delayed(
      const Duration(seconds: 0),
    );
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  Widget _onInitialFetch(BuildContext context, AsyncSnapshot<List<FeedCard>> snapshot) {
    if (snapshot.hasError) {
      return Center(
        child: IntrinsicHeight(
          child: Column(
            children: [
              LoadingAnimationWidget.hexagonDots(
                  color: kDefaultIconDarkColor, size: 150),
              const Divider(
                height: 20,
                color: Colors.transparent,
              ),
              const Text(
                  'Impossible to reach GitHub API...'),
              const Divider(
                height: 60,
                color: Colors.transparent,
              ),
            ],
          ),
        ),
      );
    }

    if (snapshot.hasData) {
      _feedCards.clear();
      _feedCards.addAll(snapshot.data!);
      return ListView(
        cacheExtent: 100.0,
        children: _feedCards,
      );
    } else {
      return Center(
        child: LoadingAnimationWidget.hexagonDots(
            color: kDefaultIconDarkColor, size: 200),
      );
    }
  }
}
