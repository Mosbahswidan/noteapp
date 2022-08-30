import 'package:flutter/material.dart';

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);
void NavigateTo(context,widget)=>Navigator.push(
  context, MaterialPageRoute(builder:(context)=>widget),);
Widget defaultFormField({
  required TextEditingController control,
  required String labelText,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  Function? ontap,
  Function? onChange,
  required Function vlaidd,
  IconData? prefix,
  Function? suffixPress,
  bool isPass=false,
  IconData? suffix,
  int? minLines,
  int ?maxLines
})=>TextFormField(
  minLines: minLines,
  maxLines: maxLines,
  controller: control,
  obscureText: isPass?true:false,
  keyboardType:type ,
  onFieldSubmitted: onSubmit,
  decoration:InputDecoration(
    labelText: labelText,
    prefixIcon:Icon(
      prefix,

    ),

    suffixIcon:suffix!=null? IconButton(
      onPressed: (){
        return suffixPress!();
      },
      icon: Icon(
        suffix,

      ),
    ):null,
    border:OutlineInputBorder() ,
  ) ,
  validator: (s){
    return vlaidd(s);
  },
  onTap: (){
    return ontap!();
  },
  onChanged:(s){
    return onChange!(s);
  } ,
);
Widget defultButton({
  double? width,
  required Color background,
  required String text,
  bool isUpperCase=true,
  required Function function,

})=> Container(
  width: width,
  color: background,
  child: MaterialButton(
    onPressed:(){
      return function();
    },
    child: Text(isUpperCase?text.toUpperCase():text,
      style: TextStyle(
        color:Colors.white,
      ),
    ),
  ),
);

void navigateAndFinish(
    context,
    widget,
    ) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
          (route) {
        return false;
      },
    );