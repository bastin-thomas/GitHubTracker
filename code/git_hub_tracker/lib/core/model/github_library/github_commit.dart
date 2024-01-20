
import 'package:git_hub_tracker/core/logic/utils.dart';

class GitHubCommit {
  late String? author_avatar;
  late DateTime date;
  late int additions;
  late int deletions;
  late Uri html_url;

  GitHubCommit(Map<String, dynamic> content){

    if(content['author'] != null){
      author_avatar = content['author']['avatar_url'];
    }else{
      author_avatar = null;
    }

    date = TimeConverter(content['commit']['author']['date']);
    additions = content['stats']['additions'];
    deletions = content['stats']['deletions'];
    html_url = Uri.parse(content['html_url']);
  }

  @override
  String toString() {
    return 'repo{$date}';
  }
}