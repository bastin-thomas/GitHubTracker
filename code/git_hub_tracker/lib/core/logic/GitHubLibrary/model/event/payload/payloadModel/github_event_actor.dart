import 'package:git_hub_tracker/core/constants/const.dart';

class GitHubEventActor{
  late int id;
  late String login;
  late String display_login;
  late String url;
  late String avatar_url;

  GitHubEventActor(Map<String, dynamic> content){
    id = content['id'] == null ? -1 : content['id']!;
    login = content['login'] == null ? 'unkown' : content['login']!;
    display_login = content['display_login'] == null ? 'unkown' : content['display_login']!;
    url = content['url'] == null ? 'unkown' : content['url']!;
    avatar_url = content['avatar_url'] == null ? kErrorAvatarUrl : content['avatar_url']!;
  }

  @override
  String toString() {
    return 'actor{$login}';
  }
}