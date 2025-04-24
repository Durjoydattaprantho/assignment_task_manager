import 'package:assignment_task_manager/ui/screens/computer_task_screen.dart';
import 'package:assignment_task_manager/ui/screens/new_task_screen.dart';
import 'package:assignment_task_manager/ui/screens/progress_task_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/tm_app_bar.dart';
import 'cancel_task_screen.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  @override
  void initState() {
    super.initState();
  }

  int selectedIndex = 0;
  final List<Widget> _screens = [
    NewTaskScreen(),
    CompletedTaskScreen(),
    CancelTaskScreen(),
    InProgressTaskScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          selectedIndex = index;
          setState(() {});
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.newspaper, color: Colors.blue),
            label: 'New',
          ),
          NavigationDestination(
            icon: Icon(Icons.compare, color: Colors.green),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.one_k, color: Colors.redAccent),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel, color: Colors.purple),
            label: 'Canceled',
          ),
        ],
      ),
    );
  }
}
