import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:git_hub_tracker/core/constants/const.dart';
import 'package:git_hub_tracker/core/logic/fire_store_api/store_library.dart';
import 'package:git_hub_tracker/core/model/fire_store_dto_library/store_user.dart';
import 'package:git_hub_tracker/feeds/view/partials/drawer/logout_button.dart';
import 'package:git_hub_tracker/feeds/view/partials/drawer/resync_button.dart';
import 'package:git_hub_tracker/feeds/view/partials/drawer/tracked_chips.dart';

class FeedPageEndDrawer extends StatefulWidget {
  const FeedPageEndDrawer({super.key, });

  @override
  State<FeedPageEndDrawer> createState() => _FeedPageEndDrawerState();
}

class _FeedPageEndDrawerState extends State<FeedPageEndDrawer> {
  late Stream<DocumentSnapshot<StoreUser>>? _userStream;
  List<String> trackedUser = [];
  List<String> trackedRepositories = [];
  late StoreUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: FutureBuilder<Stream<DocumentSnapshot<StoreUser>>?>(
          future: initUserStore(),
          builder: (context, future) {
            if (!future.hasData || future.hasError) {
              return const WaitingUserData();
            } else {

              _userStream = future.data!;
              print('$_userStream');

              return StreamBuilder<DocumentSnapshot<StoreUser>>(
                  stream: future.data!,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting || snapshot.hasError) {
                      return const WaitingUserData();
                    }
                    currentUser = snapshot.data!.data();
                    return ListView(
                        children: [
                          ReSyncButton(onTap: () async {
                            await resyncTracker();
                            setState(() {});
                          },),
                          TrackChip(
                            trackedList: currentUser.followed_users,
                            chipName: kUserTraquedTitle,
                            onDelete: onDelete,
                            onAdded: onAdded,
                          ),
                          TrackChip(
                            trackedList: currentUser.followed_repository,
                            chipName: kRepositoriesTraquedTitle,
                            onDelete: onDelete,
                            onAdded: onAdded,
                          ),
                          const LogoutButton(),
                        ],
                      );
                  }
              );
            }
          },
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
  }

  ///Redirect Event to On Added
  onDelete(String value, int index) {
    onAdded(value);
  }

  ///Get On Added
  onAdded(String value,) {
    if(currentUser != null){
      print('TEST: ${currentUser.toJson()}');
      updateUserStore(currentUser);
    }
  }
}








class WaitingUserData extends StatelessWidget {
  const WaitingUserData({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ReSyncButton(onTap: (){},),
        const TrackedWaiting(chipName: kUserTraquedTitle,),
        const TrackedWaiting(chipName: kRepositoriesTraquedTitle,),
        const LogoutButton(),
      ],
    );
  }
}

