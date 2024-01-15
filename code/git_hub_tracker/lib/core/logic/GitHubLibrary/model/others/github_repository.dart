import 'package:git_hub_tracker/core/constants/const.dart';
import 'package:git_hub_tracker/core/logic/GitHubLibrary/model/others/github_owner.dart';

class GitHubRepository {
  late int id;
  late String name;
  late String fullName;
  late String html_url;
  late String description;
  late int star;
  late int watch;
  late String language;
  late GithubOwner owner;

  GitHubRepository(Map<String, dynamic> content){
    id = content['id'] == null ? -1 : content['id']!;
    name = content['name'] == null ? kErrorName : content['name']!;
    fullName = content['full_name'] == null ? kErrorName : content['full_name']!;
    html_url = content['html_url'] == null ? 'unkown' : content['html_url']!;
    description = content['description'] == null ? 'unkown' : content['description']!;
    star = content['stargazers_count'] == null ? 0 : content['stargazers_count']!;
    watch = content['watchers_count'] == null ? 0 : content['watchers_count']!;
    language = content['language'] == null ? 'unkown' : content['language']!;
    owner = GithubOwner(content['owner'] == null ? {} : content['owner']!);
  }

  @override
  String toString() {
    return 'repo{$name}';
  }
}