import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/modules/ArchivedTasks.dart';
import 'package:todoapp/modules/doneTasks.dart';
import 'package:todoapp/modules/tasks.dart';
import 'package:todoapp/shared/cubit/states.dart';

//logic class

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitalState());

static AppCubit get(context)=> BlocProvider.of(context);

  List<Widget>Screens=[
    tasksPage(),
    doneTasks(),
    archivedTasks()
  ];

  int currentIndex=0;

  void changeIndex(index){
    currentIndex=index;
    emit(AppChangeButtomNavBarState());
  }
}