class GithubRepository {
  final String name;
  final String htmlUrl;
  final String language;

  GithubRepository({
    required this.language,
    required this.name,
    required this.htmlUrl,
  });

  factory GithubRepository.fromJson(Map<String, dynamic> json) {
    return GithubRepository(
      language: json['language'] ?? '',
      name: json['name'],
      htmlUrl: json['html_url'],
    );
  }
}
