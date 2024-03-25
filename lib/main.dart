import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/data/workout_record.dart';
import 'package:test_drive/screens/profile_screen.dart';
import 'screens/checklist_screen.dart';
import 'screens/friends_screen.dart';
import './firebase_options.dart';
import './features/authentication/auth_gate.dart';
import './data/workout_record.dart';


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
        title: 'GymPal',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: const AuthGate(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    // Add other screens here like Friends, Profile, Map, etc.
    const UserProfileScreen(),
    const ChecklistScreen(),
    // Friends/Search Button
    const PlaceholderWidget(color: Colors.green),
    // Map Button
    const PlaceholderWidget(color: Colors.yellow),
    const FriendsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Workouts'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Locations'),
          BottomNavigationBarItem(icon: Icon(Icons.co_present), label: 'Friends'),
        ],
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final Color color;
  const PlaceholderWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}
