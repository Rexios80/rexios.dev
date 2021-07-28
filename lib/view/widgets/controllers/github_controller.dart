import 'package:github/github.dart';

class GithubController {
  final _githubClient = GitHub(
    auth: Authentication.basic(
      '4fe008104bfe648d932c',
      'b80ad06d798c6c77773d61d7da9266b73739ca05',
    ),
  );

  Future<Repository> getRepository(RepositorySlug slug) {
    return _githubClient.repositories.getRepository(slug);
  }
}
