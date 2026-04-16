import 'package:flutter/material.dart';
import 'package:curebay_app/screens/dashboard_screen.dart';
import 'package:curebay_app/screens/input_screen.dart';
import 'package:curebay_app/screens/results_screen.dart';
import 'package:curebay_app/screens/history_screen.dart';
import 'package:curebay_app/screens/epidemic_screen.dart';
import 'package:curebay_app/screens/seasonal_screen.dart';
import 'package:curebay_app/screens/drug_database_screen.dart';
import 'package:curebay_app/screens/vitals_guide_screen.dart';
import 'package:curebay_app/screens/whatsapp_export_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String input = '/input';
  static const String results = '/results';
  static const String history = '/history';
  static const String epidemic = '/epidemic';
  static const String seasonal = '/seasonal';
  static const String drugs = '/drugs';
  static const String vitalsGuide = '/vitals-guide';
  static const String whatsapp = '/whatsapp';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const DashboardScreen(),
      input: (context) => const InputScreen(),
      results: (context) => const ResultsScreen(),
      history: (context) => const HistoryScreen(),
      epidemic: (context) => const EpidemicScreen(),
      seasonal: (context) => const SeasonalRiskScreen(),
      drugs: (context) => const DrugDatabaseScreen(),
      vitalsGuide: (context) => const VitalsGuideScreen(),
      whatsapp: (context) => const WhatsAppExportScreen(),
    };
  }
}
