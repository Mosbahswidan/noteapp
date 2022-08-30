import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;

String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'mosbah:2481973mosbah'));

Map<String, String> myheaders = {
  'authorization': _basicAuth
};

class loginController extends GetxController{






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

}