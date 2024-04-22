import 'package:flutter/material.dart';
import 'package:todoapp/Constant/constant.dart';
import 'package:todoapp/Widgets/task_item.dart';

class tasksPage extends StatelessWidget {
  const tasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) => TaskItem(model: tasks[index]),itemCount: tasks.length,);
  }
}
