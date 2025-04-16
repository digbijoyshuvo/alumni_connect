import 'package:alumni_connect/routes/route_names.dart';
import 'package:alumni_connect/widgets/custom_snackbar.dart';
import 'package:alumni_connect/widgets/custom_text_form_field.dart';
import 'package:alumni_connect/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CheckPermission extends StatefulWidget {
  const CheckPermission({super.key});

  @override
  State<CheckPermission> createState() => _CheckPermissionState();
}

class _CheckPermissionState extends State<CheckPermission> {
  final TextEditingController _passController = TextEditingController();
  bool isPasswordVisible = false;
  String pass = "shuvo12345";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text("** Note :Only The Admins can Add, Delete or Update any Event **",
              style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,
              color: Colors.greenAccent),),
              SizedBox(height: 50,),
              Text("Please Provide the Password for Admin Verification"),
              SizedBox(height: 10,),
              CustomTextFormField(
                  controller: _passController,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Please Provide the Password";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: !isPasswordVisible,
                  hintText: "Enter Your Password",
                  suffix: InkWell(
                    onTap: (){
                      setState(() {
                        isPasswordVisible =!isPasswordVisible;
                      });
                      },
                    child: Icon(
                      isPasswordVisible?Icons.visibility:Icons.visibility_off,
                    ),
                  ),
                  prefixIcon: Icon(Icons.lock),
              ),
              SizedBox(height: 20,),
              RoundedElevatedButton(
                  buttonText: "Submit",
                  onPressed: (){
                    if(_passController.text == pass){
                      context.pushReplacementNamed(RouteNames.createEvent);
                      CustomSnackBar.showSuccess(context, "Verification Successful");
                    }
                    else{
                      CustomSnackBar.showError(context, "Wrong Password");
                    }
                  }),
            ],
          ),
        ),
      ),
    ),



    );
  }
}
