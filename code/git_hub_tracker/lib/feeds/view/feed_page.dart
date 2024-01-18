import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/const.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/github_api.dart';
import 'package:git_hub_tracker/core/view/partials/avatar.dart';
import 'package:git_hub_tracker/core/view/partials/avatar_websource.dart';
import 'package:git_hub_tracker/feeds/view/feed_end_drawer.dart';
import 'package:git_hub_tracker/feeds/view/partials/feed_card.dart';
import 'package:git_hub_tracker/feeds/view/partials/waiting_feed_card.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  int index = 1;
  final List<FeedCard> _feedCards = [];



  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async{
    List<FeedCard> newData = await GitHubApiSingleTon.api.getFeed(kFeedRowNumber, index);
      setState(() {
        index++;
        _feedCards.removeLast();
        _feedCards.addAll(newData);
      });
  }


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
        child:  NotificationListener<ScrollNotification>(
          onNotification: (notification){
            if (notification is ScrollEndNotification && notification.metrics.extentAfter == 0) {
              fetch();
            }
            return false;
          },
          child: ListView.builder(
              itemCount: _feedCards.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if(index < _feedCards.length){
                  return _feedCards[index];
                }
                else{
                  _feedCards.add(WaitingFeedCard.Default());
                }
              }
          ),
        ),

      ),
      endDrawer: const FeedPageEndDrawer(),
    );
  }

  Future<void> _onRefresh() async {
    var list = await GitHubApiSingleTon.api.getFeed(kFeedRowNumber, 1);

    setState(() {
      index = 1;
      _feedCards.clear();
      _feedCards.addAll(list);
    });

    return Future.delayed(
      const Duration(seconds: 0),
    );
  }



  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }
}
