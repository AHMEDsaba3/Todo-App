import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/Constant/constant.dart';
import 'package:todoapp/Widgets/text_form_field.dart';
import 'package:todoapp/modules/ArchivedTasks.dart';
import 'package:todoapp/modules/doneTasks.dart';
import 'package:todoapp/modules/tasks.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int currentIndex=0;
  Database? database;
  bool ButtomSheetShow =false;
  IconData ButtomSheetIcon=Icons.edit;
  var ScaffoldKey =GlobalKey<ScaffoldState>();
  var Formkey =GlobalKey<FormState>();
  var TitleController =TextEditingController();
  var DateController =TextEditingController();
  var TimeController =TextEditingController();
  var StatusController =TextEditingController();

  List<Widget>Screens=[
    tasksPage(),
    doneTasks(),
    archivedTasks()
  ];
  @override
  void initState() {
    super.initState();
    CreateDb();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      key: ScaffoldKey,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text("TODO",style: TextStyle(fontWeight: FontWeight.bold),)),backgroundColor: Colors.deepPurple),
      floatingActionButton: FloatingActionButton(onPressed: () {
        if(ButtomSheetShow){
          if(Formkey.currentState!.validate()){
            InsertDb(TitleController.text, TimeController.text, DateController.text).then((value) {
              Navigator.pop(context);
              ButtomSheetShow=false;
              setState(() {
                ButtomSheetIcon =Icons.edit;
            });

            });
          }

        }else{
          ScaffoldKey.currentState?.showBottomSheet((context) => SingleChildScrollView(
            child: Container(
              color: Colors.grey[200],
              child: Padding(
                padding:  EdgeInsets.all(20.0),
                child: Form(
                  key: Formkey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormWidget(Controller: TitleController , label: "Title", keyboardType: TextInputType.text, preIcon: Icons.title,validator: (value) {
                        if(value == null||value.isEmpty){
                          return 'title must not be empty';
                        }
                        return null;
                      },),
                      TextFormWidget(Controller: TimeController , label: "Time", keyboardType: TextInputType.text, preIcon: Icons.watch_later,validator: (value) {
                        if( value == null||value.isEmpty){
                          return 'Time must not be empty';
                        }
                        return null;
                      },ontap: () {
                        showTimePicker(context: context, initialTime: TimeOfDay.now()).
                        then((value) => TimeController.text = value!.format(context).toString());
                      },
                      Clickable: false,
                      ),
                      TextFormWidget(Controller: DateController , label: "Date", keyboardType: TextInputType.text, preIcon: Icons.date_range,validator: (value) {
                        if(value == null||value.isEmpty){
                          return 'Date must not be empty';
                        }
                        return null;
                      },ontap: () {
                        showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime.parse("2030-12-31")).
                        then((value) => DateController.text="${value?.day}/${value?.month}/${value?.year}");
                      },
                        Clickable: false,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),elevation: 20
          ).closed.then((value) {
            ButtomSheetShow=false;
            setState(() {
              ButtomSheetIcon =Icons.edit;
            });
          });
          ButtomSheetShow=true;
          setState(() {
            ButtomSheetIcon=Icons.add;
          });
        }

      },child: Icon(ButtomSheetIcon)),
      body: tasks.length == 0 ? Center(child: CircularProgressIndicator()) : Screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex ,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: [
        BottomNavigationBarItem(icon: Icon(Icons.task),label: 'Tasks'),
        BottomNavigationBarItem(icon: Icon(Icons.task_alt),label: 'Done'),
        BottomNavigationBarItem(icon: Icon(Icons.archive),label: 'Archived'),

      ]),

    );
  }
//creat and open database
  void CreateDb()async{
    // id integer
    // title string
    // date string
    // time string
    // status string

    database = await openDatabase(
      'todo.db',
      version: 1,
      onCreate:(database, version){
        print('Database Created');
        database.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)').then((value) => print('table created')).catchError((error){'Error when creat table ${error.toString()}';});
    },
      onOpen: (db) {
        GetDataBase(db).then((value) {
          setState(() {
            tasks =value;
          });
          print(tasks);
        });
        print('database opened');
      },

        );
  }
//insert into database
  Future InsertDb(@required String title,@required String time,@required String date)async{
    return await database?.transaction((txn) async{
      txn.rawInsert('INSERT INTO tasks(title,date,time,status) VALUES ("$title","$date","$time","new")').
      then((value){print('Task ${value} inserted successfully');}).catchError((error){
        print("error is${error.toString()}");
      });
      return null;
    });
  }
  //get database
  Future<List<Map>> GetDataBase(database)async{
   return await database.rawQuery("SELECT * FROM tasks ");
  }
}



/*
 GetName().then((value){
          print(value);
          print("aaaaaaaaaas");
          throw('rrrrrrrrrrrrrrrrrr');
        }).catchError((error){
          print('erro is ${error.toString()}');
        });

 */
/*
Future<String> GetName()async{
    return "Ahmed";
  }
 */