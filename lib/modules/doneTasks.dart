import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Constant/constant.dart';
import 'package:todoapp/Widgets/task_item.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class doneTasks extends StatelessWidget {
  const doneTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).DoneTask;
        return AppCubit.get(context).DoneTask.length == 0
            ? Center(
            child: Text(
              'No Done Tasks Added',
              style: TextStyle(fontWeight: FontWeight.bold),
            )) :ListView.builder(
          itemBuilder: (context, index) => TaskItem(model: tasks[index],IsDone: true),
          itemCount: tasks.length,
        );
      },
    );
  }
}
