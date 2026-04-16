import 'package:flutter/material.dart';
import 'package:curebay_app/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize ONNX and Vosk services here eventually
  runApp(const CurebayApp());
}

class CurebayApp extends StatelessWidget {
  const CurebayApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Curebay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        useMaterial3: true,
        fontFamily: 'Roboto', // Using default standard font which looks clean
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
        ),
      ),
      initialRoute: AppRoutes.home,
      routes: AppRoutes.getRoutes(),
    );
  }
}
