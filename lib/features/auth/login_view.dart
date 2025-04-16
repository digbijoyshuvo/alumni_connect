


import 'package:alumni_connect/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/auth/auth.dart';
import '../../routes/route_names.dart';
import '../../theme/app_color.dart';
import '../../utils/app_image_url.dart';
import '../../utils/app_string.dart';
import '../../utils/validation_rules.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/elevated_button.dart';

class LoginView extends StatefulWidget{
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();

}

class _LoginViewState extends State<LoginView>{
  final _loginFormKey =GlobalKey<FormState>();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  bool isPasswordVisible =false;
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  clearText(){
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      Image.asset(
                        AppImageUrl.logo,
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextFormField(
                        controller: _emailController,
                        validator: (val){
                          if(val!.isEmpty){
                            return AppString.required;
                          }else if(!ValidationRules.emailValidation.hasMatch(val)){
                            return AppString.provideValidEmail;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        hintText: AppString.email,
                        suffix: null,
                        prefixIcon: Icon(Icons.email, color: Colors.grey),
                      ),
                      SizedBox(height: 10,),
                      CustomTextFormField(
                        controller: _passwordController,
                        validator: (val){
                          if(val!.isEmpty){
                            return AppString.required;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: !isPasswordVisible,
                        hintText: AppString.password,
                        prefixIcon: Icon(Icons.lock, color: Colors.grey),
                        suffix: InkWell(
                          onTap: (){
                            setState(() {
                              isPasswordVisible =!isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible?Icons.visibility:Icons.visibility_off,
                            color: AppColor.greyColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      RoundedElevatedButton(
                          buttonText: AppString.login,
                          onPressed: (){
                            loginUser(_emailController.text,
                                _passwordController.text).then((value){
                               if(value){
                                 CustomSnackBar.showSuccess(context, AppString.loginSuccessful);
                                 context.pushNamed(RouteNames.homepage);
                               }else{
                                 CustomSnackBar.showError(context, "Login Failed! Try Again.");
                               }
                            });

                          }
                      ),
                      const SizedBox(height: 10,),
                      GestureDetector(
                        onTap: (){
                          context.pushNamed(RouteNames.register);
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: AppString.newUser,
                            style: TextStyle(color: AppColor.greyColor),
                            children: [
                              TextSpan(
                                text: AppString.register,
                                style: TextStyle(color: AppColor.appColor,fontWeight: FontWeight.w500
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
          )
        ),
      ),
    );
  }
}