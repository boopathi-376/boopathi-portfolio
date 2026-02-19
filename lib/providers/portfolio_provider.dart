import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/project.dart';
import '../models/personal_info.dart';
import '../models/extra_info.dart';

class PortfolioProvider with ChangeNotifier {
  PersonalInfo? _personalInfo;
  List<Project> _projects = [];
  List<SkillCategory> _skillCategories = [];
  List<Education> _education = [];
  List<Education> _certifications = [];
  List<Internship> _internships = [];

  bool _isLoading = true;
  String? _errorMessage;

  PortfolioProvider() {
    loadData();
  }

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  PersonalInfo? get personalInfo => _personalInfo;
  List<Project> get projects => _projects;
  List<SkillCategory> get skillCategories => _skillCategories;
  List<Education> get education => _education;
  List<Education> get certifications => _certifications;
  List<Internship> get internships => _internships;

  Future<void> loadData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final String response = await rootBundle.loadString(
        'assets/data/portfolio.json',
      );
      final data = await json.decode(response);

      _personalInfo = PersonalInfo.fromJson(data['personalInfo']);

      _projects =
          (data['projects'] as List)
              .map((item) => Project.fromJson(item))
              .toList();

      _skillCategories =
          (data['skillCategories'] as List)
              .map((item) => SkillCategory.fromJson(item))
              .toList();

      _education =
          (data['education'] as List)
              .map((item) => Education.fromJson(item))
              .toList();

      _certifications =
          (data['certifications'] as List)
              .map((item) => Education.fromJson(item))
              .toList();

      if (data['internships'] != null) {
        _internships =
            (data['internships'] as List)
                .map((item) => Internship.fromJson(item))
                .toList();
      }

      debugPrint("Portfolio data loaded successfully");
      debugPrint(
        "Skills: ${_skillCategories.length}, Projects: ${_projects.length}",
      );

      _isLoading = false;
    } catch (e) {
      debugPrint("Error loading portfolio data: $e");
      _errorMessage = "Failed to load portfolio data: $e";
      _isLoading = false;
    }
    notifyListeners();
  }

  // Admin Update Methods (Preserving for logical structure, though admin screen deleted)
  void updatePersonalInfo(PersonalInfo info) {
    _personalInfo = info;
    notifyListeners();
  }

  void updateProjects(List<Project> projects) {
    _projects = projects;
    notifyListeners();
  }

  void updateSkillCategories(List<SkillCategory> categories) {
    _skillCategories = categories;
    notifyListeners();
  }

  void updateEducation(List<Education> education) {
    _education = education;
    notifyListeners();
  }

  void updateCertifications(List<Education> certifications) {
    _certifications = certifications;
    notifyListeners();
  }

  String generateJson() {
    final data = {
      'personalInfo': {
        'name': _personalInfo?.name,
        'role': _personalInfo?.role,
        'bio': _personalInfo?.bio,
        'socialLinks': _personalInfo?.socialLinks,
      },
      'projects':
          _projects
              .map(
                (p) => {
                  'title': p.title,
                  'description': p.description,
                  'imageUrl': p.imageUrl,
                  'technologies': p.technologies,
                  'githubUrl': p.githubUrl,
                  'liveDemoUrl': p.liveDemoUrl,
                },
              )
              .toList(),
      'skillCategories':
          _skillCategories
              .map((sc) => {'title': sc.title, 'skills': sc.skills})
              .toList(),
      'education':
          _education
              .map(
                (e) => {
                  'title': e.title,
                  'institution': e.institution,
                  'subtitle': e.subtitle,
                  'date': e.date,
                  'score': e.score,
                },
              )
              .toList(),
      'certifications':
          _certifications
              .map(
                (c) => {
                  'title': c.title,
                  'institution': c.institution,
                  'date': c.date,
                },
              )
              .toList(),
      'internships':
          _internships
              .map(
                (i) => {
                  'title': i.title,
                  'company': i.company,
                  'date': i.date,
                  'description': i.description,
                },
              )
              .toList(),
    };
    return const JsonEncoder.withIndent('  ').convert(data);
  }
}
