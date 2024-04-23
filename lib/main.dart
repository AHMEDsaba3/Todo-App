import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/Layout/homeLayout.dart';
import 'package:todoapp/shared/BlocObserver.dart';

import 'Layout/HomeLayout_SL.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'to do app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomeLayout_SL()
    );
  }
}
