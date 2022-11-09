import 'package:dev_store/screens/supplier/profile_screen.dart';
import 'package:dev_store/widgets/appbar.dart';
import 'package:dev_store/widgets/default_page_container.dart';
import 'package:flutter/material.dart';

class SupplierMainPage extends StatefulWidget {
  const SupplierMainPage({super.key});

  @override
  State<SupplierMainPage> createState() => _SupplierMainPageState();
}

class _SupplierMainPageState extends State<SupplierMainPage> {
  int _selectedIndex = 0;
  final List<Widget?> tabs = [const Text('sup'), const ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: personalBar(title: 'DevStore 🔥'),
      body: defaultPageContainer(child: tabs[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Category',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
