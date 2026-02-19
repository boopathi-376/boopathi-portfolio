class PersonalInfo {
  final String name;
  final String role;
  final String bio;
  final String email;
  final String phone;
  final String location;
  final String? imageUrl;
  final Map<String, String> socialLinks;

  PersonalInfo({
    required this.name,
    required this.role,
    required this.bio,
    required this.email,
    required this.phone,
    required this.location,
    this.imageUrl,
    required this.socialLinks,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      name: json['name'],
      role: json['role'],
      bio: json['bio'],
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      location: json['location'] ?? '',
      imageUrl: json['imageUrl'],
      socialLinks: Map<String, String>.from(json['socialLinks']),
    );
  }
}
