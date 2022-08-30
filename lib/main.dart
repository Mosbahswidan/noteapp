import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:note_app/view/home/home_view.dart';
import 'package:note_app/view/login_view/login_view.dart';
import 'package:note_app/view/notes/add.dart';
import 'package:note_app/view/signup_view/signup_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/middleware.dart';
 SharedPreferences ?sharepref;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  sharepref=await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      getPages: [
        GetPage(name: '/', page: ()=>Login(),middlewares: [
          middleWare(),
        ]),
        GetPage(name: '/signup', page: ()=>signUp()),
        GetPage(name: '/home', page: ()=>Home()),
        GetPage(name: '/add', page: ()=>AddNote()),
      ],
    );
  }
}

