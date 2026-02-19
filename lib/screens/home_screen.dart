import 'package:flutter/material.dart';
import '../widgets/hero_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/education_section.dart';
import '../widgets/internship_section.dart';
import '../widgets/project_grid.dart';
import '../widgets/contact_section.dart';

import '../widgets/certification_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _certificationsKey = GlobalKey(); // Added Key
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(String sectionName) {
    GlobalKey? key;
    switch (sectionName) {
      case 'Skills':
        key = _skillsKey;
        break;
      case 'Experience':
        key = _experienceKey;
        break;
      case 'Education':
        key = _educationKey;
        break;
      case 'Certifications':
        key = _certificationsKey;
        break;
      case 'Projects':
        key = _projectsKey;
        break;
      case 'Contact':
        key = _contactKey;
        break;
    }

    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      endDrawer: _buildMobileDrawer(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: HeroSection(
              onMenuClick: _scrollToSection, // Pass the generic handler
            ),
          ),
          SliverToBoxAdapter(key: _skillsKey, child: const SkillsSection()),
          SliverToBoxAdapter(
            key: _experienceKey,
            child: const InternshipSection(),
          ),
          SliverToBoxAdapter(
            key: _educationKey,
            child: const EducationSection(),
          ),
          SliverToBoxAdapter(
            key: _certificationsKey,
            child: const CertificationSection(),
          ),
          SliverToBoxAdapter(key: _projectsKey, child: const ProjectGrid()),
          SliverToBoxAdapter(key: _contactKey, child: const ContactSection()),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFF0A0A0A),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Colors.white70, size: 30),
            ),
          ),
          const SizedBox(height: 40),
          _drawerItem('Skills'),
          _drawerItem('Experience'),
          _drawerItem('Education'),
          _drawerItem('Certifications'),
          _drawerItem('Projects'),
          _drawerItem('Contact'),
        ],
      ),
    );
  }

  Widget _drawerItem(String title) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      title: Text(
        "> $title",
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontFamily: 'FiraCode', // Terminal feel
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context); // Close drawer
        _scrollToSection(title);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
