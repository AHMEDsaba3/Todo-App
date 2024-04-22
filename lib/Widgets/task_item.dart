import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key,required this.model});
  final Map model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(child: Row(
        children: [
          CircleAvatar(child: Text('${model['time']}'),radius: 40,),
          SizedBox(width: 20,),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${model['title']}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              Text('${model['date']}',style: TextStyle(color: Colors.grey),),
            ],)

        ],
      ),),
    );
  }
}
