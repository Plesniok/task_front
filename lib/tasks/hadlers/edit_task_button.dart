import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:task_front/services/api/models/add_task_body.dart';
import 'package:task_front/services/api/models/edit_task_body.dart';
import 'package:task_front/services/api/task.dart';
import 'package:task_front/tasks/model/task.dart';
import 'package:task_front/user/bloc/user_bloc.dart';

class EditTaskButton extends StatefulWidget {
  Task taskData;
  String? token;

  EditTaskButton({super.key, required this.taskData, required this.token});

  @override
  _EditTaskButtonState createState() => _EditTaskButtonState();
}

class _EditTaskButtonState extends State<EditTaskButton> {
  final TextEditingController descriptionController = TextEditingController();
  bool? isDone;
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
  void initState() {
    descriptionController.text = widget.taskData.description ?? "";
    selectedTimestamp = widget.taskData.deadlineTimestamp ??
        DateTime.now().millisecondsSinceEpoch ~/ 1000;
    isDone = widget.taskData.isDone ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.taskData.title ?? "-",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
            Row(
              children: [
                Text(
                  'Is Done:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Checkbox(
                  value: isDone,
                  onChanged: (newValue) {
                    setState(() {
                      isDone = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                EditTaskBody newTaskData = new EditTaskBody(
                    id: widget.taskData.id,
                    description: descriptionController.text,
                    timestamp: selectedTimestamp);

                TaskApi.editTask(newTaskData: newTaskData, token: widget.token);

                if (isDone == true && widget.taskData.isDone == false) {
                  TaskApi.markTaskAsDone(
                      taskId: widget.taskData.id, token: widget.token);
                }

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
