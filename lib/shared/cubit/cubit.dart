import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
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
  Database? database;
  List<Map> NewTask =[];
  List<Map> DoneTask =[];
  List<Map> ArchiveTask =[];
  bool ButtomSheetShow =false;
  IconData ButtomSheetIcon=Icons.edit;



  void changeIndex(index){
    currentIndex=index;
    emit(AppChangeButtomNavBarState());
  }

  //creat and open database
  void CreateDb(){
    // id integer
    // title string
    // date string
    // time string
    // status string

    openDatabase(
      'todo.db',
      version: 1,
      onCreate:(database, version){
        print('Database Created');
        database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)').then((value) => print('table created')).catchError((error){'Error when creat table ${error.toString()}';});
      },
      onOpen: (database) {
        GetDataBase(database);
        print('database opened');
      },

    ).then((value) {
      database = value;
      emit(AppCreateDataBase());
    });
  }
//insert into database
  Future InsertDb(@required String title,@required String time,@required String date)async{
     await database?.transaction((txn) async{
      txn.rawInsert('INSERT INTO tasks(title,date,time,status) VALUES ("$title","$date","$time","new")').
      then((value){print('Task ${value} inserted successfully');
      emit(AppInsertDataBase());
      GetDataBase(database);
      }).catchError((error){
        print("error is${error.toString()}");
      });
      return null;
    });
  }
  //get database
 void GetDataBase(database){
    //to make clear
    NewTask =[];
    DoneTask=[];
    ArchiveTask=[];
    emit(AppGetDataBaseLoading());
    database.rawQuery("SELECT * FROM tasks ").then((value) {
      value.forEach((element) {
        if(element['status']=='new')
          NewTask.add(element);
        else if(element['status']=='done')
          DoneTask.add(element);
        else ArchiveTask.add(element);
      });
      emit(AppGetDataBase());
    });
  }
  //update Database
void updateDataBase(
      @required String status,
      @required int id
      )async{
   database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]).then((value) {
          GetDataBase(database);
          emit(AppUpdateDataBase());
    });
  }

  void changeButtonSheetIcon(@required bool isShow , @required IconData icon){
    ButtomSheetShow = isShow;
    ButtomSheetIcon = icon;
    emit(ButtonSheetIcon());
  }
}