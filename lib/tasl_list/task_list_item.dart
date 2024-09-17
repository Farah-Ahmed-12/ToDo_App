import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/firebase_units.dart';

import '../model/task.dart';
import '../providers/list_provider.dart';

class TaskListItem extends StatelessWidget {
  Task task;

  TaskListItem({required this.task});

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          Container(
            margin: EdgeInsets.all(12),
            child: SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                FirebaseUnits.deletTaskFromFireStore(task)
                    .timeout(Duration(seconds: 1), onTimeout: () {
                  print('task deleted successfully');
                  listProvider.getAllTaskFromFireStore();
                });
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whitcolor,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.all(12),
              color: AppColors.primmarycolor,
              height: MediaQuery.of(context).size.height * 0.09,
              width: 4,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  task.description,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            )),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.01,
                horizontal: MediaQuery.of(context).size.height * 0.03,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.primmarycolor,
              ),
              child: Icon(
                Icons.check,
                color: AppColors.whitcolor,
                size: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
