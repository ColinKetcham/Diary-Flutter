import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stack/form.dart';
import 'package:stack/posts.dart';
import 'package:stack/user.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  int _selectedIndex = 1;

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        pages: [
          if (_selectedIndex == 0) MaterialPage(child: MyForm()),
          if (_selectedIndex == 1) MaterialPage(child: UserPostsWidget()),
          if (_selectedIndex == 2) MaterialPage(child: UserPostsWidget()),
          if (_selectedIndex == 3) MaterialPage(child: UserInfo())
        ],
        onPopPage: (route, result) {
          if (route.didPop(result)) return true;

          return false;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add_rounded),
            label: 'My Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Friends Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
