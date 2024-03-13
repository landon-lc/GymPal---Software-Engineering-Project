import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/data/workout_record.dart';
import 'pages/checklist_page.dart';

void main() {
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
        home: const MyHomePage(title: 'GymPal Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

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
    const ChecklistPage(),
    const PlaceholderWidget(color: Colors.red),
    const PlaceholderWidget(color: Colors.green),
    const PlaceholderWidget(color: Colors.yellow),
    // Add other pages here like FriendsPage(), ProfilePage(), GymMapPage(), etc.
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
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
