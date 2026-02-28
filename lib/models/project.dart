class Project {
  final String title;
  final String description;
  final String imageUrl;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveDemoUrl;
  final String? date;

  Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.technologies,
    this.githubUrl,
    this.liveDemoUrl,
    this.date,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      technologies: List<String>.from(json['technologies']),
      githubUrl: json['githubUrl'],
      liveDemoUrl: json['liveDemoUrl'],
      date: json['date'],
    );
  }
}
