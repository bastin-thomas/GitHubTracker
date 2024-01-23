
// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:git_hub_tracker/core/logic/github_api/github_api.dart';
import 'package:git_hub_tracker/core/model/fire_store_dto_library/store_user.dart';

Future<Stream<DocumentSnapshot<StoreUser>>?> initUserStore() async {
 String userName = await GitHubApiSingleTon.api.getCurrentUserName();


 //Check if user is init:
 var collection = FirebaseFirestore.instance.collection('users');
 if(collection.doc(userName).get() == null){
   await resetCollectionUserData(collection, userName);
 }


 //Init Stream
 late final Stream<DocumentSnapshot<StoreUser>>? userStoreStream;
 userStoreStream = collection
      .doc(userName)
      .withConverter<StoreUser>(
      fromFirestore: (snapshot, _) => StoreUser.fromJson(snapshot.data()!),
      toFirestore:   (user, _) => user.toJson(),
 ).snapshots();

 return userStoreStream;
}

Future<StoreUser> getStoreUser() async {
  StoreUser userData = const StoreUser(followed_users: [], followed_repository: [], filter_state: []);
  String userName = await GitHubApiSingleTon.api.getCurrentUserName();

  var collection = FirebaseFirestore.instance.collection('users');
  if(collection.doc(userName).get() == null){
    await resetCollectionUserData(collection, userName);
  }

  DocumentSnapshot<Map<String, dynamic>> snapshot = await collection.doc(userName).get();
  userData = StoreUser.fromJson(snapshot.data()!);

  return userData;
}




updateUserStore(StoreUser user) async {
  String userName = await GitHubApiSingleTon.api.getCurrentUserName();

  var collection = FirebaseFirestore.instance.collection('users');
  if(collection.doc(userName).get() != null){
    await collection.doc(userName).set(user.toJson())
        .onError((error, stackTrace){print('ERROR: $stackTrace');});
  }
}



Future<void> resetCollectionUserData(CollectionReference<Map<String, dynamic>> collection, String userName) async {
  List<String> repo = await GitHubApiSingleTon.api.getFollowedRepository();
  List<String> user = await GitHubApiSingleTon.api.getFollowedUser();

  collection.doc(userName).set(StoreUser(followed_users: user, followed_repository: repo, filter_state: []).toJson(), SetOptions(merge: true));
}


Future<void> resyncTracker() async {
  var collection = FirebaseFirestore.instance.collection('users');
  String userName = await GitHubApiSingleTon.api.getCurrentUserName();
  await resetCollectionUserData(collection, userName);
  return Future.delayed(const Duration(milliseconds: 0));
}