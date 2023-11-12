import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/home/settings/SettingsTab.dart';
import 'package:todo_app/home/tasksList/TasksListTab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';

   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
          side: BorderSide(
            color: Colors.white,
            width: 4
          )
        ),
        onPressed: (){},
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 12,
        child: BottomNavigationBar(
          currentIndex : selectedIndex,
          onTap: (index){
            setState((){
              selectedIndex = index;
            });
          },
          elevation:  0.0,
          backgroundColor: Colors.transparent,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: '')
          ],
        ),
      ),

    );
  }

  int selectedIndex = 0;

  var tabs = [TasksListTab() , SettingsTab()];
}
