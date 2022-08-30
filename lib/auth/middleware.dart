import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:note_app/main.dart';

class middleWare extends GetMiddleware{
  @override
 RouteSettings? redirect(String? route){
    if(sharepref!.getString('id')!=null) return RouteSettings(name: '/home');


  }

}