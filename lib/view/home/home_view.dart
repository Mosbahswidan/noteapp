import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:note_app/controller/home_controller.dart';
import 'package:note_app/core/component.dart';
import 'package:note_app/core/constatnt.dart';
import 'package:note_app/main.dart';
import 'package:note_app/view/notes/edit.dart';

import '../../model/note_model.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var homeContr=Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(onPressed: (){
            sharepref!.clear();
            Get.offAllNamed('/login');

    }, icon: Icon(Icons.exit_to_app)),
        ],
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),onPressed: (){
        Get.toNamed('/add');
      },),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            FutureBuilder(future:homeContr.postResponse(linkView,{'id':sharepref!.getString('id')}) ,
              builder: (BuildContext context,AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                if(snapshot.data['status']=='fail') return Center(child: Text('there is no  notes '),);
              //return buildNoteItem('${snapshot.data['data']['note_title']}','${snapshot.data['data']['note_content']}');
               return ListView.separated(
                 shrinkWrap: true,
                   itemBuilder: (context, index) =>buildNoteItem(NoteModel.fromJson(snapshot.data['data'][index]),homeContr) ,
                   separatorBuilder: (context, index) => myDivider(),
                   itemCount: snapshot.data['data'].length);
              }
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              return Center(child: CircularProgressIndicator(),);

            },)
          ],
        ),
      ),
    );
  }
 }

  Widget buildNoteItem(NoteModel model,HomeController contr)=>InkWell(
    onTap: (){

      Get.to(EditNote(notes: model ,));
    },
    child: Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex:1,
            child: Image(
              width: 100,
              height: 100,
              fit: BoxFit.fill,
              image: NetworkImage(
                  '$ImageRoot/${model.noteImage}'),
            ),
          ),
          Expanded(
            flex: 2,
            child:ListTile
              (
              trailing: IconButton(onPressed: ()async{
                var response=await contr.postResponse(linkdelete,{
                  'id':model.noteId.toString(),
                  'imagename':model.noteImage,
                });
                if(response['status'] == 'success'){
                  Get.offAllNamed('/home');
                }else{
                  print('delete fail');
                }
              }, icon: Icon(Icons.delete)),
              title: Text(model.noteTitle!),
              subtitle: Text(model.noteContent!),
            ),
          ),
        ],
      ),
    ),
  );

