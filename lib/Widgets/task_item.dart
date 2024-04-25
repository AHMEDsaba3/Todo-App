import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key,required this.model});
  final Map model;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder:(context, state) {
        AppCubit cubit = AppCubit.get(context);
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: Card(child: Row(
          children: [
            CircleAvatar(child: Text('${model['time']}'),radius: 40,),
            SizedBox(width: 20,),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${model['title']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Text('${model['date']}',style: TextStyle(color: Colors.grey),),
                ],),
            ),
            SizedBox(width: 20,),
            IconButton(onPressed: () {
              cubit.updateDataBase("done", model['id']);
            }, icon: Icon(Icons.check_box,color: Colors.green,)),
            IconButton(onPressed: () {
              cubit.updateDataBase("archive", model['id']);
            }, icon: Icon(Icons.archive,color: Colors.black54,)),


          ],
        ),),
      );
    }, );
  }
}
