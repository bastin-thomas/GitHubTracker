
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:git_hub_tracker/core/logic/github_api/github_api.dart';
import 'package:git_hub_tracker/core/model/fire_store_dto_library/store_user.dart';

Future<Stream<DocumentSnapshot<StoreUser>>?> initUserStore() async {
 String userName = await GitHubApiSingleTon.api.getCurrentUserName();


 //Check if user is init:
 var collection = FirebaseFirestore.instance.collection('users');
 if(collection.doc(userName).get() == null){
   collection.doc(userName).set(const StoreUser(followed_users: [], followed_repository: []).toJson(), SetOptions(merge: true));
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

Future<StoreUser> getUserStore() async {
  StoreUser userData = const StoreUser(followed_users: [], followed_repository: []);
  String userName = await GitHubApiSingleTon.api.getCurrentUserName();

  var collection = FirebaseFirestore.instance.collection('users');
  if(collection.doc(userName).get() != null){
    DocumentSnapshot<Map<String, dynamic>> snapshot = await collection.doc(userName).get();
    userData = StoreUser.fromJson(snapshot.data()!);
  }
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