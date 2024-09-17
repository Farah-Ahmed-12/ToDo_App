import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/firebase_units.dart';
import 'package:to_do_app/model/task.dart';
import 'package:to_do_app/providers/list_provider.dart';

class AddTaskButtonSheet extends StatefulWidget {
  @override
  State<AddTaskButtonSheet> createState() => _AddTaskButtonSheetState();
}

class _AddTaskButtonSheetState extends State<AddTaskButtonSheet> {
  final formKey = GlobalKey<FormState>();
  var selectedDate = DateTime.now();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  String title = '';
  String description = '';
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.addNewTask,
            style: TextStyle(fontSize: 22),
          ),
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: titleController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!.plEnterTaskTitle;
                    }
                    return null;
                  },
                  onChanged: (text) {
                    title = text;
                  },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.taskTitle,
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  onChanged: (text) {
                    description = text;
                  },
                  controller: descriptionController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return AppLocalizations.of(context)!.plEnterTaskDes;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.taskDescription,
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 12),
                Text(
                  AppLocalizations.of(context)!.selectDate,
                  style: TextStyle(fontSize: 18),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: InkWell(
                    onTap: () {
                      showCalendar();
                    },
                    child: Text(
                      selectedDate != null
                          ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}' // عرض التاريخ المختار
                          : AppLocalizations.of(context)!.noDateSelected,
                      style: const TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    addTask();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.add,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      Task task = Task(
        title: title,
        description: description,
        dateTime: selectedDate,
      );
      FirebaseUnits.addTaskToFireStor(task).timeout(Duration(seconds: 2),
          onTimeout: () {
        print('task added successfuly');
        listProvider.getAllTaskFromFireStore();
        Navigator.pop(context);
      });
    }
  }

  void showCalendar() async {
    var chosenDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365)))
        .then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          this.selectedDate = selectedDate;
        });
      }
    });
  }
}
