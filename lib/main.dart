import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import './src/models/workout_record.dart';
import './firebase_options.dart';
import './src/features/authentication/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutRecord(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xfffffff4),
                primary: const Color(0xff3ea9a9),
                brightness: Brightness.dark),
            useMaterial3: true,
            // Append xff for full opacity (255). Last six digits are Hex color code.
            scaffoldBackgroundColor: const Color(0xff2f2f2f)),
        home: const AuthGate(),
      ),
    );
  }
}
