import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/portfolio_provider.dart';
import 'screens/home_screen.dart';
import 'constants/app_colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => PortfolioProvider())],
      child: const PortfolioApp(),
    ),
  );
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boopathi | AI & Flutter Engineer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          background: AppColors.background,
        ),
        textTheme: GoogleFonts.interTextTheme(
          ThemeData.light().textTheme,
        ).copyWith(
          displayLarge: GoogleFonts.lora(
            textStyle: ThemeData.light().textTheme.displayLarge,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          displayMedium: GoogleFonts.lora(
            textStyle: ThemeData.light().textTheme.displayMedium,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          bodyLarge: GoogleFonts.inter(
            textStyle: ThemeData.light().textTheme.bodyLarge,
            color: AppColors.textPrimary,
          ),
          bodyMedium: GoogleFonts.inter(
            textStyle: ThemeData.light().textTheme.bodyMedium,
            color: AppColors.textSecondary,
          ),
        ),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const HomeScreen(),
    );
  }
}
