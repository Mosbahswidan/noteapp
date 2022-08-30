import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:note_app/core/constatnt.dart';
import 'package:note_app/main.dart';
import 'package:path/path.dart';
String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'mosbah:2481973mosbah'));

Map<String, String> myheaders = {
  'authorization': _basicAuth
};
class HomeController extends GetxController{

  postResponse(String url,Map data) async{
    try{
      var response= await http.post(Uri.parse(url),body: data,headers: myheaders);
      if(response.statusCode==200){

        var responseBody=jsonDecode(response.body);

        return responseBody;

      }else{
        print('error is ${response.statusCode}');

      }

    }catch(e){
      print(e.toString());
    }
  }

  getNote()async{
    var response =await postResponse(linkView, {
      'id':sharepref!.getString('id'),
    });
    return response;

  }

  postRequestWithFile(String url,Map data,File file)async {
   var request =http.MultipartRequest('POST',Uri.parse(url));
   var length=await file.length();
   var stream=http.ByteStream(file.openRead());

   var filepart=http.MultipartFile('file',stream,length,filename:basename(file.path) );
    request.files.add(filepart);
    request.headers.addAll(myheaders);

    data.forEach((key, value) {
      request.fields[key]=value;
    });
    var myrequest=await request.send();
    var response= await http.Response.fromStream(myrequest);

    if(myrequest.statusCode==200){
      return jsonDecode(response.body);
    }else{
   print('Error');

    }

  }

  // void onInit() {
  //   super.onInit();
  //
  //
  //
  // }


}