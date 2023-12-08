class SecretConsts {
  static const clientId = '8bce74626b16c23dc4ac';
  static const clientSecret = '702d1aedfc3d13c9e9c0dc64ff0509436f0ef395';

  static final authEndPoint = Uri.parse('https://github.com/login/oauth/authorize');
  static final tokenEndPoint = Uri.parse('https://github.com/login/oauth/access_token');
  static final redirectUrl = Uri.parse('https://localhost:3000/callback');

  static const scopes = ['user','repo','gist','read:org','notifications'];

  static final revocationEndpoint = Uri.parse('https://api.github.com/applications/$clientId/token');
}

