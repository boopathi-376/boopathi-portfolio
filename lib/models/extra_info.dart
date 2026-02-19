class SkillCategory {
  final String title;
  final List<String> skills;

  SkillCategory({required this.title, required this.skills});

  factory SkillCategory.fromJson(Map<String, dynamic> json) {
    return SkillCategory(
      title: json['title'],
      skills: List<String>.from(json['skills']),
    );
  }
}

class Education {
  final String title;
  final String institution;
  final String? subtitle;
  final String? date;
  final String? score;

  Education({
    required this.title,
    required this.institution,
    this.subtitle,
    this.date,
    this.score,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      title: json['title'],
      institution: json['institution'],
      subtitle: json['subtitle'],
      date: json['date'],
      score: json['score'],
    );
  }
}

class Internship {
  final String title;
  final String company;
  final String date;
  final String description;

  Internship({
    required this.title,
    required this.company,
    required this.date,
    required this.description,
  });

  factory Internship.fromJson(Map<String, dynamic> json) {
    return Internship(
      title: json['title'],
      company: json['company'],
      date: json['date'],
      description: json['description'],
    );
  }
}
