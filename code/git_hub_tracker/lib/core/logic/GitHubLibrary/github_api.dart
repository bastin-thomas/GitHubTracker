
import 'dart:async';
import 'dart:convert';

import 'package:git_hub_tracker/core/constants/const.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/github_event.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload_create.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload_issue.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload_issuecomment.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload_push.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/event/payload/github_event_payload_watch.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/others/github_commit.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/others/github_issue.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/others/github_issue_comment.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/others/github_repository.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_create.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_issue.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_issuecomment.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_push.dart';
import 'package:git_hub_tracker/feeds/view/partials/content/content_card_watch.dart';
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

    Map<String, String> queryParams = {};

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


  ///Get Common Feed to Populate feed-page
  Future<List<FeedCard>> getFeed(int quantity) async {
      final List<FeedCard> list = [];

      User currentUser = await _github.users.getCurrentUser();


      Map<String, String> queryParams = {
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
              uri: Uri.parse(gitHubRepository.html_url),
              subtitle: 'Push :arrow_heading_up:',
            ),
          );
        } else if(event.type == GitHubEventPayload.ISSUE_COMMENT){
          final GitHubEventPayloadIssueComment issueCommentPayLoad = event.payload as GitHubEventPayloadIssueComment;
          final GitHubIssueComment issueComment = await getCurrentIssueComment(issueCommentPayLoad.comment.url);

          list.add(
            FeedCard(
              publishDate:  event.created_at,
              image: issueCommentPayLoad.issue.user['avatar_url'],
              title: '${issueCommentPayLoad.issue.title} [${event.public == true ? 'Public' : 'Private'}]',
              contentCard: ContentCardIssueComment(eventIssueComment: issueCommentPayLoad, issueComment),
              uri: issueCommentPayLoad.issue.html_url,
              subtitle: 'Issue Comment :memo:',
            ),
          );
        } else if(event.type == GitHubEventPayload.WATCH){
          final GitHubEventPayloadWatch payload = event.payload as GitHubEventPayloadWatch;
          //GetRepositoryInformation
          GitHubRepository gitHubRepository = await getCurrentRepository(event.repo.url);

          list.add(
            FeedCard(
              publishDate:  event.created_at,
              image: gitHubRepository.owner.avatarUrl,
              title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
              contentCard: ContentCardWatch(payload:payload, event: event,),
              uri: Uri.parse(gitHubRepository.html_url),
              subtitle: 'Starred Repository :star:',
            ),
          );

        } else if(event.type == GitHubEventPayload.ISSUE){
          final GitHubEventPayloadIssue payload = event.payload as GitHubEventPayloadIssue;
          GitHubRepository gitHubRepository = await getCurrentRepository(event.repo.url);
          GitHubIssue issue = await getCurrentIssue(payload.issue.url);

          list.add(
            FeedCard(
              publishDate:  event.created_at,
              image: gitHubRepository.owner.avatarUrl,
              title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
              contentCard: ContentCardIssue(payload: payload, event: event, issue: issue,),
              uri: Uri.parse(gitHubRepository.html_url),
              subtitle: '${payload.action} Issue  ${payload.action == 'closed' ? ':lock:' : ':unlock:'}',
            ),
          );

        } else if(event.type == GitHubEventPayload.CREATE){
          final GitHubEventPayloadCreate payload = event.payload as GitHubEventPayloadCreate;
          //GetRepositoryInformation
          GitHubRepository gitHubRepository = await getCurrentRepository(event.repo.url);


          if(payload.ref_type == GitHubEventPayloadCreate.REPOSITORY){
            list.add(
              FeedCard(
                publishDate:  event.created_at,
                image: gitHubRepository.owner.avatarUrl,
                title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
                contentCard: ContentCardCreate(payload:payload, event: event, repository: gitHubRepository, message: ':file_folder: have been created by',),
                uri: Uri.parse(gitHubRepository.html_url),
                subtitle: 'New Repository Created :file_folder:',
              ),
            );
          } else if(payload.ref_type == GitHubEventPayloadCreate.BRANCH){
            list.add(
              FeedCard(
                publishDate:  event.created_at,
                image: gitHubRepository.owner.avatarUrl,
                title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
                contentCard: ContentCardCreateBranch(payload:payload, event: event, repository: gitHubRepository,),
                uri: Uri.parse(gitHubRepository.html_url),
                subtitle: 'New Branch Created :deciduous_tree:',
              ),
            );
          } else if(payload.ref_type == GitHubEventPayloadCreate.TAG){
            list.add(
              FeedCard(
                publishDate:  event.created_at,
                image: gitHubRepository.owner.avatarUrl,
                title: '${gitHubRepository.name} [${event.public == true ? 'Public' : 'Private'}]',
                contentCard: ContentCardCreateTag(payload:payload, event: event, repository: gitHubRepository,),
                uri: Uri.parse(gitHubRepository.html_url),
                subtitle: 'New Tag Created :label:',
              ),
            );
          }



        } else {

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

    Uri repoUrl = Uri.parse(url);
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

    Uri repoUrl = Uri.parse(url);
    var repoResponse = await http.get(repoUrl, headers: headers);
    return GitHubCommit(jsonDecode(repoResponse.body));
  }

  ///Get a commit data from a Repo Url using authentification
  Future<GitHubIssue> getCurrentIssue(String url) async{
    Map<String, String> headers = {
      'Content-Type':'application/json',
      'Accept':'application/vnd.github+json',
      'X-GitHub-Api-Version':'2022-11-28',
      'User-Agent':'GithubTracker',
      'Authorization':'Bearer $_currentToken',
    };

    Uri repoUrl = Uri.parse(url);
    var repoResponse = await http.get(repoUrl, headers: headers);
    return GitHubIssue(jsonDecode(repoResponse.body));
  }



  ///Get a commit data from a Repo Url using authentification
  Future<GitHubIssueComment> getCurrentIssueComment(String url) async{
    Map<String, String> headers = {
      'Content-Type':'application/json',
      'Accept':'application/vnd.github+json',
      'X-GitHub-Api-Version':'2022-11-28',
      'User-Agent':'GithubTracker',
      'Authorization':'Bearer $_currentToken',
    };

    Uri repoUrl = Uri.parse(url);
    var repoResponse = await http.get(repoUrl, headers: headers);
    return GitHubIssueComment(jsonDecode(repoResponse.body));
  }

  Future<String> getCurrentUserName() async {
    User currentUser = await _github.users.getCurrentUser();
    return currentUser.login ?? 'unkown';
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