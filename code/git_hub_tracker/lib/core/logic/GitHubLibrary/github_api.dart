
import 'dart:async';
import 'dart:convert';

import 'package:git_hub_tracker/core/constants/const.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/github_event.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload_push.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/repository/github_commit.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/repository/github_repository.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_push.dart';
import 'package:git_hub_tracker/feeds/view/partials/feed_card.dart';
import 'package:github/github.dart';
import 'package:http/http.dart' as http;


class GitHubApi {
  late final GitHub _github;
  final String _currentToken;

  getAccessToken() {
    return _currentToken;
  }

  GitHubApi(this._currentToken){
    _github = GitHub(auth: Authentication.bearerToken(_currentToken));
  }


  ///Get the current User Avatar
  Future<String> getCurrentUserAvatar() async {
    User currentUser = await _github.users.getCurrentUser();

    Map<String, String> queryParams = {
      'auth':_currentToken,
    };

    Map<String, String> headers = {
      'Content-Type':'application/json',
      'Accept':'application/vnd.github+json',
      'X-GitHub-Api-Version':'2022-11-28',
      'User-Agent':'GithubTracker',
      'Authorization':'Bearer $_currentToken',
    };


    var url = Uri.https('api.github.com','/users/${currentUser.login}', queryParams);
    var response = await http.get(url, headers: headers);
    Map<String, dynamic> rootNode = await jsonDecode(response.body);

    return rootNode['avatar_url'] ?? kErrorAvatarUrl;
  }





  ///Get Common Feed to Populate feedpage
  Future<List<FeedCard>> getFeed(int quantity) async {
      final List<FeedCard> list = [];

      User currentUser = await _github.users.getCurrentUser();
      Map<String, String> queryParams = {
        'auth':_currentToken,
        'per_page':'$quantity',
      };

      Map<String, String> headers = {
        'Content-Type':'application/json',
        'Accept':'application/vnd.github+json',
        'X-GitHub-Api-Version':'2022-11-28',
        'User-Agent':'GithubTracker',
        'Authorization':'Bearer $_currentToken',
      };

      var url = Uri.https('api.github.com','/users/${currentUser.login}/events', queryParams);
      var response = await http.get(url, headers: headers);

      List<dynamic> rootNode = jsonDecode(response.body);

      await Future.forEach(rootNode, (element) async {
        GitHubEvent event = GitHubEvent(element);

        if(event.type == GitHubEventPayload.PUSH){
          final GitHubEventPayloadPush pushPayload = event.payload as GitHubEventPayloadPush;

          //GetRepositoryInformation
          GitHubRepository gitHubRepository = await getCurrentRepository(event.repo.url);
          list.add(
            FeedCard(
              publishDate:  event.created_at,
              image: gitHubRepository.owner.avatarUrl,
              title: '${event.repo.name} [${event.public == true ? 'Public' : 'Private'}]',
              contentCard: ContentCardPush(payloadPush: pushPayload),
              uri: Uri.parse(gitHubRepository.url), subtitle: 'Push',
            ),
          );
        }
      });

    return list;
  }


  ///Get a repository data from a Repo Url using authentification
  Future<GitHubRepository> getCurrentRepository(String url) async{
    Map<String, String> headers = {
      'Content-Type':'application/json',
      'Accept':'application/vnd.github+json',
      'X-GitHub-Api-Version':'2022-11-28',
      'User-Agent':'GithubTracker',
      'Authorization':'Bearer $_currentToken',
    };

    Uri repoUrl = Uri.parse('$url?$_currentToken');
    var repoResponse = await http.get(repoUrl, headers: headers);
    return GitHubRepository(jsonDecode(repoResponse.body));
  }


  ///Get a commit data from a Repo Url using authentification
  Future<GitHubCommit> getCurrentCommit(String url) async{
    Map<String, String> headers = {
      'Content-Type':'application/json',
      'Accept':'application/vnd.github+json',
      'X-GitHub-Api-Version':'2022-11-28',
      'User-Agent':'GithubTracker',
      'Authorization':'Bearer $_currentToken',
    };

    Uri repoUrl = Uri.parse('$url?$_currentToken');
    var repoResponse = await http.get(repoUrl, headers: headers);
    return GitHubCommit(jsonDecode(repoResponse.body));
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