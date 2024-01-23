import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/const.dart';
import 'package:git_hub_tracker/core/logic/fire_store_api/store_library.dart';
import 'package:git_hub_tracker/core/logic/github_api/github_api.dart';
import 'package:git_hub_tracker/core/logic/utils.dart';
import 'package:git_hub_tracker/core/model/fire_store_dto_library/store_user.dart';
import 'package:git_hub_tracker/core/view/partials/avatar.dart';
import 'package:git_hub_tracker/core/view/partials/avatar_websource.dart';
import 'package:git_hub_tracker/feeds/view/feed_end_drawer.dart';
import 'package:git_hub_tracker/feeds/view/partials/end_feed_card.dart';
import 'package:git_hub_tracker/feeds/view/partials/feed_card.dart';
import 'package:git_hub_tracker/feeds/view/partials/others/chipset_filter.dart';
import 'package:git_hub_tracker/feeds/view/partials/waiting_feed_card.dart';
import 'package:github/github.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _noMoreDataToFetch = false;
  int _index = 1;
  String _filterString = '';
  List<int> _filterState = [];

  final List<FeedCard> _feedCards = [];
  List<FeedCard> _filteredFeedCards = [];

  late Stream<DocumentSnapshot<StoreUser>>? _userStream;
  StoreUser? _currentUser;


  @override
  void initState() {
    super.initState();
    firstFetch();
  }

  Future<void> firstFetch() async{
      List<FeedCard> newData = await GitHubApiSingleTon.api.getFeed(kFeedRowNumber, _index);

      setState(() {
        _feedCards.addAll(newData);
        sortOnDate(_feedCards);
        updateFilter();
      });
  }

  Future<void> fetch() async{
    _index++;
    List<FeedCard> newData = await GitHubApiSingleTon.api.getFeed(kFeedRowNumber, _index);

    if(newData.isEmpty){
      _noMoreDataToFetch = true;
    }
    else{
      _noMoreDataToFetch = false;
    }

    setState(() {
      _feedCards.addAll(newData);
      sortOnDate(_feedCards);
      updateFilter();
    });
  }


  Future<void> _onRefresh() async {
    _index = 1;
    _feedCards.clear();
    _filteredFeedCards.clear();
    await firstFetch();

    return Future.delayed(
      const Duration(seconds: 0),
    );
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
                    icon: const Avatar(imagePath: "assets/icons/not-found-icon.png"),
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
              displacement: 50,
              child:  NotificationListener<ScrollNotification>(
                onNotification: (notification){
                  if (notification is ScrollEndNotification && notification.metrics.extentAfter == 0) {
                    fetch();
                  }
                  return false;
                },
                child: ListView.builder(
                    itemCount: _filteredFeedCards.length+2,
                    itemBuilder: (BuildContext context, int index){
                      if(index == 0){
                        return filterHandler();
                      }

                      if(index < _filteredFeedCards.length+1){
                        return _filteredFeedCards[index-1];
                      }
                      else{
                        return _noMoreDataToFetch == true ? EndFeedCard.Default(): WaitingFeedCard.Default();
                      }
                    }
                ),
              ),
            ),
      endDrawer: const FeedPageEndDrawer(),
      onEndDrawerChanged: onDrawerDispose,
    );
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }

  onDrawerDispose(bool open) {
    if(!open){
      _onRefresh();
    }
  }

  ///Update Widget State & FireStore State
  updateFilter(){
    if(_currentUser != null){
      updateUserStore(StoreUser(
          followed_users: _currentUser!.followed_users,
          followed_repository: _currentUser!.followed_repository,
          filter_state: _filterState)
      );
    }

    setState(() {
      _filterString;
      _filteredFeedCards = filterFeedCards(_feedCards);
    });
  }

  ///FilterFeedCardRuler
  List<FeedCard> filterFeedCards(List<FeedCard> allItems) {
    List<String> filters = _filterString.split(";");
    filters.removeLast();

    return allItems.where((item) {
      if(_filterString == '') return true;

      for(String filter in filters){
        if(filter == item.contentCard.toChips()){
          return true;
        }
      }
      return false;
    }).toList();
  }


  ///Initialise the FilterHandler & sync with FireStore
  Widget filterHandler() {
    return FutureBuilder<StoreUser>(
        future: getUserStore(),
        builder: (context, future) {
          if (!future.hasData || future.hasError) {
            return waitingFilter();
          } else {
            _currentUser = future.data!;
            _filterState = _currentUser!.filter_state;
            return ChipsetFilter(
              onChipChanged: (String chipsSelected, int Index) {
                _filterString = chipsSelected;
              },

              onTap: () {
                updateFilter();
              },

              Selected: _filterState,
            );
          }
        }
    );
  }

  Widget waitingFilter() {
    return ChipsetFilter(Selected: _filterState,);
  }
}

