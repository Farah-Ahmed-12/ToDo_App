import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/home/setting_tab/setting_tab.dart';
import 'package:to_do_app/tasl_list/add_task_buttonsheet.dart';
import 'package:to_do_app/tasl_list/task_list_tab.dart';

class homescreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: TextStyle(fontSize: 27),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: AppLocalizations.of(context)!.taskList),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settings),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTaskButtonSheet();
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: selectedIndex == 0 ? TaskListTab() : SettingTab(),
    );
  }

  List<Widget> tabs = [TaskListTab(), SettingTab()];

  void addTaskButtonSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTaskButtonSheet(),
    );
  }
}
