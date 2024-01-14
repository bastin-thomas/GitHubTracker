import 'package:git_hub_tracker/core/constants/const.dart';

class GitHubEventRepo {
  late int id;
  late String name;
  late String url;
  GitHubEventRepo(Map<String, dynamic> content){
    id = content['id'] == null ? -1 : content['id']!;
    name = content['name'] == null ? kErrorName : content['name']!;
    url = content['url'] == null ? 'unkown' : content['url']!;
  }

  @override
  String toString() {
    return 'repo{$name}';
  }
}