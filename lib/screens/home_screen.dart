import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/hero_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/education_section.dart';
import '../widgets/internship_section.dart';
import '../widgets/project_grid.dart';
import '../widgets/contact_section.dart';
import '../widgets/certification_section.dart';
import '../constants/app_colors.dart';

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
  final GlobalKey _certificationsKey = GlobalKey();
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
      case 'Projects':
        key = _projectsKey;
        break;
      case 'Education':
        key = _educationKey;
        break;
      case 'Certifications':
        key = _certificationsKey;
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
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.95),
            border: const Border(
              bottom: BorderSide(color: AppColors.border, width: 1),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: false,
            title: Text(
              "Boopathi",
              style: GoogleFonts.lora(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            actions: [
              if (MediaQuery.of(context).size.width > 900)
                _navActions()
              else
                Builder(
                  builder: (context) => IconButton(
                    icon: const Icon(Icons.menu, color: Colors.black),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ),
      endDrawer: _buildMobileDrawer(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: HeroSection(
              onMenuClick: _scrollToSection,
              onViewWork: () => _scrollToSection('Projects'),
              onContact: () => _scrollToSection('Contact'),
            ),
          ),
          SliverToBoxAdapter(key: _skillsKey, child: const SkillsSection()),
          SliverToBoxAdapter(
            key: _experienceKey,
            child: const InternshipSection(),
          ),
          SliverToBoxAdapter(
            key: _projectsKey,
            child: const ProjectGrid(),
          ),
          SliverToBoxAdapter(
            key: _educationKey,
            child: const EducationSection(),
          ),
          SliverToBoxAdapter(
            key: _certificationsKey,
            child: const CertificationSection(),
          ),
          SliverToBoxAdapter(key: _contactKey, child: const ContactSection()),
        ],
      ),
    );
  }

  Widget _navActions() {
    return Row(
      children: [
        _navButton("Skills"),
        _navButton("Experience"),
        _navButton("Projects"),
        _navButton("Education"),
        _navButton("Certifications"),
        _navButton("Contact"),
      ],
    );
  }

  Widget _navButton(String title) {
    return TextButton(
      onPressed: () => _scrollToSection(title),
      child: Text(
        title,
        style: GoogleFonts.inter(
          color: AppColors.textSecondary,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Colors.black, size: 30),
            ),
          ),
          const SizedBox(height: 40),
          _drawerItem('Skills'),
          _drawerItem('Experience'),
          _drawerItem('Projects'),
          _drawerItem('Education'),
          _drawerItem('Certifications'),
          _drawerItem('Contact'),
        ],
      ),
    );
  }

  Widget _drawerItem(String title) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.lora(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
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
