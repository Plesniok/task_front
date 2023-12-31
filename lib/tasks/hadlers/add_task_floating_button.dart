import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_front/services/api/models/add_task_body.dart';
import 'package:task_front/services/api/task.dart';
import 'package:task_front/user/bloc/user_bloc.dart';

class AddTaskFloatingButton extends StatefulWidget {
  String? token;

  AddTaskFloatingButton({super.key, this.token});

  @override
  _AddTaskFloatingButtonState createState() => _AddTaskFloatingButtonState();
}

class _AddTaskFloatingButtonState extends State<AddTaskFloatingButton> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  int? selectedTimestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedTimestamp = picked.millisecondsSinceEpoch ~/ 1000;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Enter task title',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            const Text(
              'Enter task description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Select task date:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text('Pick Date'),
                ),
                const SizedBox(width: 8),
                Text( 
                  'Selected Date: ${selectedDate.year}-${selectedDate.month}-${selectedDate.day}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                AddTaskBody newTaskData = new AddTaskBody(
                    title: titleController.text,
                    description: descriptionController.text,
                    timestamp: selectedTimestamp);

                TaskApi.addTask(newTaskData: newTaskData, token: widget.token);

                Navigator.pop(context);
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
