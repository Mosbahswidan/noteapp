import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/register_controller.dart';
import 'package:note_app/view/home/home_view.dart';

import '../../core/component.dart';
import '../../core/constatnt.dart';

class signUp extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailControler=TextEditingController();
  var passwordControler=TextEditingController();
  var nameControler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var signUpContr=Get.put(signUpController());
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
                    'REGISTER',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 38,
                  ),
                  defaultFormField(
                    control: nameControler,
                    labelText: 'Name',
                    type: TextInputType.text,
                    vlaidd:(value){
                      if(value.isEmpty){
                        return 'the name must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.person,
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
                    control: emailControler,
                    labelText: 'email',
                    type: TextInputType.emailAddress,

                    vlaidd:(value){
                      if(value.isEmpty){
                        return 'the email must not be empty';
                      }
                      return null;
                    },
                    prefix: Icons.email,
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
                      labelText: 'password',
                      prefix: Icons.lock,
                      suffix: Icons.remove_red_eye,
                      type: TextInputType.visiblePassword,
                      onChange: (s){
                        return null;
                      },
                      ontap: (){
                        return null;
                      },
                      onSubmit: (z){},
                      control: passwordControler,
                      vlaidd: (value){
                        if(value.isEmpty){
                          return 'the password must not be empty';
                        }
                        return null;
                      }
                  ),SizedBox(
                    height: 20,
                  ),
                  SizedBox(height: 25,),
                  defultButton(width: double.infinity,
                      background: Colors.blue,
                      text: 'register',
                      function: ()async{
                    if(formKey.currentState!.validate()){
                      var rseponse=await signUpContr.postResponse(linkSignup,
                          {
                            'username':nameControler.text,
                            'email':emailControler.text,
                            'password':passwordControler.text,
                          }
                      );
                      if(rseponse['status'] == 'success'){
                        Get.off(Home());

                      }else{
                        print('sign up fail');
                      }
                    }

                      }
                  ),
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
