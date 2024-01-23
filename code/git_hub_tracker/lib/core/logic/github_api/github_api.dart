
import 'dart:async';
import 'dart:convert';

import 'package:git_hub_tracker/core/constants/const.dart';
import 'package:git_hub_tracker/core/logic/fire_store_api/store_library.dart';
import 'package:git_hub_tracker/core/model/fire_store_dto_library/store_user.dart';
import 'package:git_hub_tracker/core/model/github_library/event/github_event.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload_create.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload_delete.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload_fork.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload_issue.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload_issuecomment.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload_public.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload_push.dart';
import 'package:git_hub_tracker/core/model/github_library/event/payload/github_event_payload_watch.dart';
import 'package:git_hub_tracker/core/model/github_library/github_commit.dart';
import 'package:git_hub_tracker/core/model/github_library/github_issue.dart';
import 'package:git_hub_tracker/core/model/github_library/github_issue_comment.dart';
import 'package:git_hub_tracker/core/model/github_library/github_repository.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_create.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_delete.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_fork.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_issue.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_issuecomment.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_public.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_push.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_watch.dart';
import 'package:git_hub_tracker/feeds/view/partials/feed_card.dart';
import 'package:github/github.dart';
import 'package:http/http.dart' as http;


class GitHubApi {
  //region Properties
  late final GitHub _github;
  final String _currentToken;
  //endregion

  //region Constructors
  GitHubApi(this._currentToken){
    _github = GitHub(auth: Authentication.bearerToken(_currentToken));
  }
  //endregion

  Map<String, String> getHeaders(){
    return {
      'Content-Type':'application/json',
      'Accept':'application/vnd.github+json',
      'X-GitHub-Api-Version':'2022-11-28',
      'User-Agent':'GithubTracker',
      'Authorization':'Bearer $_currentToken',
    };
  }



  ///Get All Feed to Populate feed-page
  Future<List<FeedCard>> getFeed(int quantity, int page) async {
      List<FeedCard> list = [];
      List<Future<List<FeedCard>>> asyncTasks = [];

      //getUserName and User TrackedList Name
      User currentUser = await _github.users.getCurrentUser();
      StoreUser userStore = await getUserStore();

      //Prepare the whole code to be executed in parrallel
      //getCurrentUser
      asyncTasks.add(getUserFeed(currentUser.login!, quantity, page));

      //getTrackedUser
      for (String userLogin in userStore.followed_users) {
        asyncTasks.add(getUserFeed(userLogin, quantity, page));
      }

      //wait all api Call finished
      List<List<FeedCard>> result = await Future.wait(asyncTasks);

      for (List<FeedCard> userFeed in result) {
        list.addAll(userFeed);
      }

      return list;
  }




  ///Get the current User Avatar
  Future<String> getCurrentUserAvatar() async {
    User currentUser = await _github.users.getCurrentUser();

    var url = Uri.https('api.github.com','/users/${currentUser.login}');
    var response = await http.get(url, headers: getHeaders());
    Map<String, dynamic> rootNode = await jsonDecode(response.body);

    return rootNode['avatar_url'] ?? kErrorAvatarUrl;
  }



  ///Get a repository data from a Repo Url using authentification
  Future<GitHubRepository> getCurrentRepository(String url) async{
    Uri repoUrl = Uri.parse(url);
    var repoResponse = await http.get(repoUrl, headers: getHeaders());
    return GitHubRepository(jsonDecode(repoResponse.body));
  }


  ///Get a commit data from a Repo Url using authentification
  Future<GitHubCommit> getCurrentCommit(String url) async{
    Uri repoUrl = Uri.parse(url);
    var repoResponse = await http.get(repoUrl, headers: getHeaders());
    return GitHubCommit(jsonDecode(repoResponse.body));
  }

  ///Get a commit data from a Repo Url using authentification
  Future<GitHubIssue> getCurrentIssue(String url) async{
    Uri repoUrl = Uri.parse(url);
    var repoResponse = await http.get(repoUrl, headers: getHeaders());
    return GitHubIssue(jsonDecode(repoResponse.body));
  }



  ///Get a commit data from a Repo Url using authentification
  Future<GitHubIssueComment> getCurrentIssueComment(String url) async{
    Uri repoUrl = Uri.parse(url);
    var repoResponse = await http.get(repoUrl, headers: getHeaders());
    return GitHubIssueComment(jsonDecode(repoResponse.body));
  }

  Future<String> getCurrentUserName() async {
    User currentUser = await _github.users.getCurrentUser();
    return currentUser.login ?? 'unkown';
  }


  ///Get the currentUser followed user
  Future<List<String>> getFollowedUser() async {
    List<String> user = [];

    var url = Uri.https('api.github.com','/user/following');
    var response = await http.get(url, headers: getHeaders());

    List<dynamic> rootNode = jsonDecode(response.body);

    for(Map<String, dynamic> followed in rootNode){
      user.add(followed['login']);
    }
    return user;
  }


  ///Get the currentUser followed Repository
  Future<List<String>> getFollowedRepository() async {
    List<String> repo = [];

    var url = Uri.https('api.github.com','/user/starred');
    var response = await http.get(url, headers: getHeaders());

    List<dynamic> rootNode = jsonDecode(response.body);

    for(Map<String, dynamic> followed in rootNode){
      repo.add(followed['full_name']);
    }

    return repo;
  }







  ///get Feed for a logged user
  Future<List<FeedCard>> getUserFeed(String userLogin, int quantity, int page) async {
    final List<FeedCard> list = [];
    final List<Future<FeedCard>> parallelTasks = [];


    Map<String, String> queryParams = {
      'per_page':'$quantity',
      'page':'$page',
    };

    var url = Uri.https('api.github.com','/users/$userLogin/events', queryParams);
    var response = await http.get(url, headers: getHeaders());

    dynamic rootNode = jsonDecode(response.body);

    if(rootNode is List<dynamic>){
      //init Parrallel Task
      for(var element in rootNode){
        parallelTasks.add(instanceGoodCard(element));
      }

      List<FeedCard> result = await Future.wait(parallelTasks);

      FeedCard defaultCard = FeedCard.Default();
      for(FeedCard card in result){
        if(card.publishDate != defaultCard.publishDate){
          list.add(card);
        }
      }

      return list;
    }
    else{
      rootNode as Map<String, dynamic>;
      if (kDebugMode) {
        print('ErrorMessage: ${rootNode['message']}');
      }
      return list;
    }
  }


  Future<FeedCard> instanceGoodCard(var element) async {
    GitHubEvent event = GitHubEvent(element);

    switch(event.type){
      case GitHubEventPayload.PUSH:
        final GitHubEventPayloadPush pushPayload = event.payload as GitHubEventPayloadPush;
        GitHubRepository gitHubRepository = await getCurrentRepository(event.repo.url);

        return FeedCard(
          publishDate:  event.created_at,
          image: gitHubRepository.owner.avatarUrl,
          title: '${event.repo.name} [${event.public == true ? 'Public' : 'Private'}]',
          contentCard: ContentCardPush(payloadPush: pushPayload),
          uri: Uri.parse(gitHubRepository.html_url),
          subtitle: 'Push :arrow_heading_up:',
        );

      case GitHubEventPayload.ISSUE_COMMENT:
        final GitHubEventPayloadIssueComment issueCommentPayLoad = event.payload as GitHubEventPayloadIssueComment;
        final GitHubIssueComment issueComment = await getCurrentIssueComment(issueCommentPayLoad.comment.url);

        return FeedCard(
            publishDate:  event.created_at,
            image: issueCommentPayLoad.issue.user['avatar_url'],
            title: '${issueCommentPayLoad.issue.title} [${event.public == true ? 'Public' : 'Private'}]',
            contentCard: ContentCardIssueComment(eventIssueComment: issueCommentPayLoad, issueComment),
            uri: issueCommentPayLoad.issue.html_url,
            subtitle: 'Issue Comment :memo:',
        );

      case GitHubEventPayload.WATCH:
        final GitHubEventPayloadWatch payload = event.payload as GitHubEventPayloadWatch;
        GitHubRepository gitHubRepository = await getCurrentRepository(event.repo.url);

        return FeedCard(
          publishDate:  event.created_at,
          image: gitHubRepository.owner.avatarUrl,
          title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
          contentCard: ContentCardWatch(payload:payload, event: event,),
          uri: Uri.parse(gitHubRepository.html_url),
          subtitle: 'Starred Repository :star:',
        );

      case GitHubEventPayload.ISSUE:
        final GitHubEventPayloadIssue payload = event.payload as GitHubEventPayloadIssue;
        GitHubRepository gitHubRepository = await getCurrentRepository(event.repo.url);
        GitHubIssue issue = await getCurrentIssue(payload.issue.url);

        return FeedCard(
          publishDate:  event.created_at,
          image: gitHubRepository.owner.avatarUrl,
          title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
          contentCard: ContentCardIssue(payload: payload, event: event, issue: issue,),
          uri: Uri.parse(gitHubRepository.html_url),
          subtitle: '${payload.action} Issue  ${payload.action == 'closed' ? ':lock:' : ':unlock:'}',
        );

      case GitHubEventPayload.CREATE:
        final GitHubEventPayloadCreate payload = event.payload as GitHubEventPayloadCreate;
        GitHubRepository gitHubRepository = await getCurrentRepository(event.repo.url);

        switch(payload.ref_type){
          case GitHubEventPayloadCreate.BRANCH:
            return FeedCard(
              publishDate:  event.created_at,
              image: gitHubRepository.owner.avatarUrl,
              title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
              contentCard: ContentCardCreateBranch(payload:payload, event: event, repository: gitHubRepository,),
              uri: Uri.parse(gitHubRepository.html_url),
              subtitle: 'New Branch Created :deciduous_tree:',
            );


          case GitHubEventPayloadCreate.TAG:
            return FeedCard(
              publishDate:  event.created_at,
              image: gitHubRepository.owner.avatarUrl,
              title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
              contentCard: ContentCardCreateTag(payload:payload, event: event, repository: gitHubRepository,),
              uri: Uri.parse(gitHubRepository.html_url),
              subtitle: 'New Tag Created :label:',
            );


          default:
            return FeedCard(
              publishDate:  event.created_at,
              image: gitHubRepository.owner.avatarUrl,
              title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
              contentCard: ContentCardCreate(payload:payload, event: event, repository: gitHubRepository, message: ':file_folder: have been created by',),
              uri: Uri.parse(gitHubRepository.html_url),
              subtitle: 'New Repository Created :file_folder:',
            );
        }


      case GitHubEventPayload.DELETE:
        final GitHubEventPayloadDelete payload = event.payload as GitHubEventPayloadDelete;
        GitHubRepository gitHubRepository = await getCurrentRepository(event.repo.url);

        switch(payload.ref_type){
          case GitHubEventPayloadDelete.BRANCH:
            return FeedCard(
              publishDate:  event.created_at,
              image: gitHubRepository.owner.avatarUrl,
              title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
              contentCard: ContentCardDeleteBranch(payload:payload, event: event, repository: gitHubRepository,),
              uri: Uri.parse(gitHubRepository.html_url),
              subtitle: 'Branch Deleted :deciduous_tree:',
            );


          case GitHubEventPayloadDelete.TAG:
            return FeedCard(
              publishDate:  event.created_at,
              image: gitHubRepository.owner.avatarUrl,
              title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
              contentCard: ContentCardDeleteTag(payload:payload, event: event, repository: gitHubRepository,),
              uri: Uri.parse(gitHubRepository.html_url),
              subtitle: 'Tag Deleted :label:',
            );
          default:
            return FeedCard(
              publishDate:  event.created_at,
              image: gitHubRepository.owner.avatarUrl,
              title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
              contentCard: ContentCardDeleteTag(payload:payload, event: event, repository: gitHubRepository,),
              uri: Uri.parse(gitHubRepository.html_url),
              subtitle: 'Tag Deleted :label:',
            );
        }


      case GitHubEventPayload.PUBLIC:
        final GitHubEventPayloadPublic payload = event.payload as GitHubEventPayloadPublic;
        GitHubRepository gitHubRepository = await getCurrentRepository(event.repo.url);

        return FeedCard(
          publishDate:  event.created_at,
          image: gitHubRepository.owner.avatarUrl,
          title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
          contentCard: ContentCardPublic(payload:payload, event: event, repository: gitHubRepository,),
          uri: Uri.parse(gitHubRepository.html_url),
          subtitle: 'made Public :globe_with_meridians:',
        );


      case GitHubEventPayload.FORK:
        final GitHubEventPayloadFork payload = event.payload as GitHubEventPayloadFork;
        GitHubRepository gitHubRepository = await getCurrentRepository(event.repo.url);

        return FeedCard(
          publishDate:  event.created_at,
          image: gitHubRepository.owner.avatarUrl,
          title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
          contentCard: ContentCardFork(payload:payload, event: event, repository: gitHubRepository,),
          uri: Uri.parse(gitHubRepository.html_url),
          subtitle: 'fork created :trident:',
        );

      default:
        return FeedCard.Default();
    }
  }
}

class GitHubApiSingleTon {
  static late GitHubApi api;

  static void setApi(GitHubApi githubapi){
    api = githubapi;
  }

  static GitHubApi getApi(){
    return api;
  }
}