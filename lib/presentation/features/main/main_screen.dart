import 'package:fino/presentation/common/resources/colors/app_colors.dart';
import 'package:fino/presentation/features/count/count_screen.dart';

import 'package:fino/presentation/features/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fino"),
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.foreground,
        centerTitle: true,
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _tabController,
        children: const [
          CountScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.foreground,
        unselectedItemColor: AppColors.inactive,
        onTap: _switchTab,
        currentIndex: tabIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Board',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }

  void _switchTab(currentIndex) {
    setState(() => tabIndex = currentIndex);
    _tabController.animateTo(currentIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
