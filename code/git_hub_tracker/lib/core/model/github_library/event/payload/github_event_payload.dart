
class GitHubEventPayload {
  final String type;
  final dynamic payload;

  GitHubEventPayload(this.type, this.payload);

  @override
  String toString() {
    return '$type, ${payload ?? 'voidPayload'}';
  }


  static const String PUSH =          'PushEvent';
  static const String ISSUE =         'IssuesEvent';
  static const String ISSUE_COMMENT = 'IssueCommentEvent';
  static const String WATCH =         'WatchEvent';
  static const String CREATE =        'CreateEvent';
  static const String DELETE =        'DeleteEvent';
  static const String PUBLIC =        'PublicEvent';
  static const String FORK =          'ForkEvent';


  //No Time To finished
  static const String PULLREQUEST =   'PullRequestEvent';
  static const String REALESE =       'ReleaseEvent';
  static const String MEMBER =        'MemberEvent';
}