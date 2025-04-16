import 'package:alumni_connect/data/database/tution_data.dart';
import 'package:alumni_connect/utils/app_string.dart';
import 'package:alumni_connect/widgets/custom_snackbar.dart';
import 'package:alumni_connect/widgets/custom_text_form_field.dart';
import 'package:alumni_connect/widgets/elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../data/saved_data.dart';

class AddTuition extends StatefulWidget {
  const AddTuition({super.key});

  @override
  State<AddTuition> createState() => _AddTuitionState();
}

class _AddTuitionState extends State<AddTuition> {
  String userId = "";
 final TextEditingController _classEditingController = TextEditingController();
 final TextEditingController _descriptionEditingController = TextEditingController();
 final TextEditingController _subjectEditingController = TextEditingController();
 final TextEditingController _salaryEditingController = TextEditingController();
 final TextEditingController _locationEditingController = TextEditingController();

  @override
  void initState(){
    userId = SavedData.getUserId();
    super.initState();
  }
 @override
 void dispose(){
   _classEditingController.dispose();
   _descriptionEditingController.dispose();
   _salaryEditingController.dispose();
   _subjectEditingController.dispose();
   _locationEditingController.dispose();

  super.dispose();
 }

 @override
 void cearText(){
   _classEditingController.clear();
   _descriptionEditingController.clear();
   _salaryEditingController.clear();
   _subjectEditingController.clear();
    _locationEditingController.clear();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.today_outlined),
            SizedBox(width: 8,),
            Text("Add a Tuition Offer"),
          ]

        )
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextFormField(
                  controller: _classEditingController,
                  validator: (val){
                    if(val!.isEmpty){
                      return AppString.required;
                    }
                    return null;
                  }, keyboardType: TextInputType.text,
                  obscureText: false,
                  suffix: null,
                  hintText: "Class",
                  prefixIcon: null
              ),
              SizedBox(height: 10,),
              CustomTextFormField(
                  controller: _subjectEditingController,
                  validator: (val){
                    if(val!.isEmpty){
                      return AppString.required;
                    }
                    return null;
                  }, keyboardType: TextInputType.text,
                  obscureText: false,
                  suffix: null,
                  hintText: "Subjects",
                  prefixIcon: null),
              SizedBox(height: 10,),
              CustomTextFormField(
                  controller: _locationEditingController,
                  validator: (val){
                    if(val!.isEmpty){
                      return AppString.required;
                    }
                    return null;
                  }, keyboardType: TextInputType.text,
                  obscureText: false,
                  suffix: null,
                  hintText: "Location",
                  prefixIcon: null),
              SizedBox(height: 10,),
              CustomTextFormField(
                  controller: _salaryEditingController,
                  validator: (val){
                    if(val!.isEmpty){
                      return AppString.required;
                    }
                    return null;
                  }, keyboardType: TextInputType.number,
                  obscureText: false,
                  suffix: null,
                  hintText: "Salary",
                  prefixIcon: null),
              SizedBox(height: 10,),
              CustomTextFormField(
                  controller: _descriptionEditingController,
                  validator: (val){
                    if(val!.isEmpty){
                      return AppString.required;
                    }
                    return null;
                  }, keyboardType: TextInputType.text,
                  obscureText: false,
                  suffix: null,
                  maxLine: 3,
          
                  hintText: "Other Required Information's",
                  prefixIcon: null),
              SizedBox(height: 10,),
              RoundedElevatedButton(buttonText: "Add Tuition",
                  onPressed: (){
                if(_classEditingController.text=="" ||_descriptionEditingController.text==""||
                _salaryEditingController.text==""|| _subjectEditingController.text=="" ||
                _locationEditingController.text==""){
                  CustomSnackBar.showError(context, AppString.required);
                }else {
                  addTuition(_classEditingController.text,
                      _subjectEditingController.text,
                      _salaryEditingController.text,
                      _descriptionEditingController.text,
                        _locationEditingController.text,userId).then((value) =>
                      CustomSnackBar.showSuccess(context, "Tuition Offer Added"));
                  Navigator.pop(context);
                }
                  }),
            ],
                ),
        ),
      ),
    );
  }
}
