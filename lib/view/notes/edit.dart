import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:image_picker/image_picker.dart';
import 'package:note_app/controller/home_controller.dart';
import 'package:note_app/core/constatnt.dart';

import '../../core/component.dart';
import '../../main.dart';
import '../../model/note_model.dart';

class EditNote extends StatefulWidget {
  const EditNote({Key? key, required this.notes}) : super(key: key);
  final NoteModel notes;
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
   File? myfile;
  var formKey=GlobalKey<FormState>();
  var titleControler=TextEditingController();
  var contentControler=TextEditingController();
  @override
  void initState() {
   titleControler.text=widget.notes.noteTitle!;
   contentControler.text=widget.notes.noteContent!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var editContr=Get.put(HomeController());
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
                    'EditNote',
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
                      text: 'Edit Note',
                      function: ()async{
                        if(formKey.currentState!.validate()){
                          var response;
                          if(myfile==null){
                            response=await editContr.postResponse(linkedit,
                                {
                                  'id':widget.notes.noteId.toString(),
                                  'title':titleControler.text,
                                  'content':contentControler.text,
                                  'imagename':widget.notes.noteImage,
                                }
                            );
                            if(response['status'] == 'success'){
                              Get.toNamed('/home');
                            }else{
                              print('edit fail');
                            }
                          }else{
                            response=await editContr.postRequestWithFile(
                                linkedit,
                                {
                                  'id':widget.notes.noteId.toString(),
                                  'title':titleControler.text,
                                  'content':contentControler.text,
                                  'imagename':widget.notes.noteImage,

                                },
                                myfile!);
                            if(response['status'] == 'success'){
                              Get.toNamed('/home');
                            }else{
                              print('edit fail');
                            }


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
