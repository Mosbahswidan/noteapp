import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/controller/home_controller.dart';
import 'package:note_app/core/constatnt.dart';
import 'package:note_app/main.dart';

import '../../core/component.dart';

class AddNote extends StatelessWidget {
  File? myfile;
  var formKey=GlobalKey<FormState>();
  var titleControler=TextEditingController();
  var contentControler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var addContr=Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add Note',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 38,
                  ),
                  defaultFormField(
                    control: titleControler,
                    labelText: 'title',
                    type: TextInputType.text,

                    vlaidd:(value){
                      if(value.isEmpty){
                        return 'the title must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.title,
                    onChange: (s){
                      return null;
                    },
                    ontap: (){
                      return null;
                    },
                    onSubmit: (z){},

                  ),
                  SizedBox(
                    height: 20,
                  ),

                  defaultFormField(
                    maxLines: 5,
                      labelText: 'content',
                      prefix: Icons.title,
                      type: TextInputType.text,
                      onChange: (s){
                        return null;
                      },
                      ontap: (){
                        return null;
                      },
                      onSubmit: (z){},
                      control: contentControler,
                      vlaidd: (value){
                        if(value.isEmpty){
                          return 'the content must not be empty';
                        }
                        return null;
                      }
                  ),
                  SizedBox(height: 25,),
                  defultButton(
                      width: double.infinity,
                      background: Colors.blue,
                      text: 'Upload Image',
                      function: ()async{
                        XFile? xfile=await ImagePicker().pickImage(source: ImageSource.gallery);
                        myfile=File(xfile!.path);

                      }),
                  SizedBox(height: 25,),
                  defultButton(
                      width: double.infinity,
                      background: Colors.blue,
                      text: 'Add',
                      function: ()async{
                        if(formKey.currentState!.validate()){
                          var rseponse=await addContr.postRequestWithFile(linkadd,
                              {
                                'title':titleControler.text,
                                'content':contentControler.text,
                                'id':sharepref!.getString('id'),
                              },myfile!
                          );
                          if(rseponse['status'] == 'success'){
                              Get.toNamed('/home');
                          }else{
                            print('sign up fail');
                          }

                        }

                      }),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
