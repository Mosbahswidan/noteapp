import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:note_app/controller/login_controller.dart';
import 'package:note_app/main.dart';

import '../../core/component.dart';
import '../../core/constatnt.dart';
import '../home/home_view.dart';
import '../signup_view/signup_view.dart';

class Login extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailControler=TextEditingController();
  var passwordControler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var loginContr=Get.put(loginController());
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
                    'LOGIN',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 38,
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
                  ),
                  SizedBox(height: 25,),
                  defultButton(
                      width: double.infinity,
                      background: Colors.blue,
                      text: 'login',
                      function: ()async{
                        if(formKey.currentState!.validate()){
                          var rseponse=await loginContr.postResponse(linkLogin,
                              {
                                'email':emailControler.text,
                                'password':passwordControler.text,
                              }
                          );
                          if(rseponse['status'] == 'success'){
                            sharepref!.setString('id',rseponse['data']['id'].toString());
                            Get.off(Home());

                          }else{
                            print('sign up fail');
                          }

                        }

                      }),
                  SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'dont have an account?',
                        style: TextStyle(
                          fontSize:16,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          // NavigateTo(context, registerView());
                          Get.to(signUp());
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
