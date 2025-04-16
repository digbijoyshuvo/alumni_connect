


import 'package:alumni_connect/routes/route_names.dart';
import 'package:alumni_connect/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/auth/auth.dart';
import '../../theme/app_color.dart';
import '../../utils/app_image_url.dart';
import '../../utils/app_string.dart';
import '../../utils/validation_rules.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/elevated_button.dart';

class RegisterView extends StatefulWidget{
  const RegisterView({super.key});
  @override
  State<RegisterView> createState() => _RegisterViewState();
}
class _RegisterViewState extends State<RegisterView>{
  final _registerFormKey=GlobalKey<FormState>();
  final TextEditingController _nameController =TextEditingController();
  // final TextEditingController _lastNameController =TextEditingController();
  final TextEditingController _emailController =TextEditingController();
  final TextEditingController _passwordController =TextEditingController();
  bool isPasswordVisible=false;

  clearText(){
    _nameController.clear();
    // _lastNameController.clear();
    _emailController.clear();
    _passwordController.clear();
  }

  @override
  void dispose(){
    _nameController.dispose();
    // _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
            child: Form(
                  key: _registerFormKey,
                  child: Column(
                    children: [
                      Image.asset(
                        AppImageUrl.logo,
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 16,),
                      CustomTextFormField(
                        controller: _nameController,
                        validator: (val){
                          if(val!.isEmpty){
                            return AppString.required;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        obscureText: false,
                        hintText: AppString.name,
                        suffix: null,
                        prefixIcon: Icon(Icons.person, color: Colors.grey),
                      ),
                      const SizedBox(height: 10,),
                      // CustomTextFormField(
                      //   controller: _lastNameController,
                      //   validator: (val){
                      //     if(val!.isEmpty){
                      //       return AppString.required;
                      //     }
                      //     return null;
                      //   },
                      //   keyboardType: TextInputType.name,
                      //   obscureText: false,
                      //   hintText: AppString.lastName,
                      //   suffix: null,
                      //   prefixIcon: Icon(Icons.person, color: Colors.grey),
                      // ),
                      // const SizedBox(height: 10,),
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
                      const SizedBox(height: 10,),
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
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible?Icons.visibility:Icons.visibility_off,
                            color: AppColor.greyColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      RoundedElevatedButton(
                          buttonText: AppString.register,
                          onPressed: (){
                            createUser(_nameController.text,
                                _emailController.text,
                                _passwordController.text).
                              then((value){
                             if(value=="success"){
                            CustomSnackBar.showSuccess(context, "Account Created");
                            context.pushNamed(RouteNames.login);
                             }
                             else{
                               CustomSnackBar.showError(context, value);
                             }
                            });

                          }),
                    ],
                  ),
                )
            ),
          ),
        ),
      );
  }
}