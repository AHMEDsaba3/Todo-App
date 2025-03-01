import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/Widgets/text_form_field.dart';
import 'package:todoapp/shared/cubit/cubit.dart';
import 'package:todoapp/shared/cubit/states.dart';

class HomeLayout_SL extends StatelessWidget {
  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var Formkey = GlobalKey<FormState>();
  var TitleController = TextEditingController();
  var DateController = TextEditingController();
  var TimeController = TextEditingController();
  var StatusController = TextEditingController();

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..CreateDb(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: ScaffoldKey,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Center(
                    child: Text(
                  "TODO",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    //   shadows: [
                    //   Shadow( // bottomLeft
                    //       offset: Offset(-1.5, -1.5),
                    //       color: Colors.black
                    //   ),
                    //   Shadow( // bottomRight
                    //       offset: Offset(1.5, -1.5),
                    //       color: Colors.black
                    //   ),
                    //   Shadow( // topRight
                    //       offset: Offset(1.5, 1.5),
                    //       color: Colors.black
                    //   ),
                    //   Shadow( // topLeft
                    //       offset: Offset(-1.5, 1.5),
                    //       color: Colors.black
                    //   ),
                    // ],
                    foreground: Paint()
                      ..color = Colors.white ?? Theme.of(context).shadowColor
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 3,
                  ),
                )),
                backgroundColor: Colors.deepPurple),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.ButtomSheetShow) {
                    if (Formkey.currentState!.validate()) {
                      cubit.InsertDb(TitleController.text, TimeController.text,
                              DateController.text)
                          .then((value) {
                        Navigator.pop(context);
                        cubit.changeButtonSheetIcon(false, Icons.edit);
                      });
                    }
                  } else {
                    ScaffoldKey.currentState
                        ?.showBottomSheet(
                            (context) => SingleChildScrollView(
                                  child: Container(
                                    color: Colors.grey[200],
                                    child: Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Form(
                                        key: Formkey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormWidget(
                                              Controller: TitleController,
                                              label: "Title",
                                              keyboardType: TextInputType.text,
                                              preIcon: Icons.title,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'title must not be empty';
                                                }
                                                return null;
                                              },
                                            ),
                                            TextFormWidget(
                                              Controller: TimeController,
                                              label: "Time",
                                              keyboardType: TextInputType.text,
                                              preIcon: Icons.watch_later,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Time must not be empty';
                                                }
                                                return null;
                                              },
                                              ontap: () {
                                                showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now())
                                                    .then((value) =>
                                                        TimeController.text =
                                                            value!
                                                                .format(context)
                                                                .toString());
                                              },
                                              Clickable: false,
                                            ),
                                            TextFormWidget(
                                              Controller: DateController,
                                              label: "Date",
                                              keyboardType: TextInputType.text,
                                              preIcon: Icons.date_range,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Date must not be empty';
                                                }
                                                return null;
                                              },
                                              ontap: () {
                                                showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime.now(),
                                                        lastDate:
                                                            DateTime.parse(
                                                                "2030-12-31"))
                                                    .then((value) => DateController
                                                            .text =
                                                        "${value?.day}/${value?.month}/${value?.year}");
                                              },
                                              Clickable: false,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            elevation: 20)
                        .closed
                        .then((value) {
                      cubit.changeButtonSheetIcon(false, Icons.edit);
                    });
                    cubit.changeButtonSheetIcon(true, Icons.add);
                  }
                },
                child: Icon(cubit.ButtomSheetIcon)),
            body:
                // add loading Circular
                state is AppGetDataBaseLoading
                    ? Center(child: CircularProgressIndicator())
                    : cubit.Screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: cubit.currentIndex,
                onTap: (value) {
                  cubit.changeIndex(value);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.task), label: 'Tasks'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.task_alt), label: 'Done'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive), label: 'Archived'),
                ]),
          );
        },
      ),
    );
  }
}
