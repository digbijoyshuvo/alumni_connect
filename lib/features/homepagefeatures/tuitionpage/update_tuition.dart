import 'package:alumni_connect/data/database/tution_data.dart';
import 'package:alumni_connect/routes/route_names.dart';
import 'package:alumni_connect/utils/app_string.dart';
import 'package:alumni_connect/widgets/custom_snackbar.dart';
import 'package:alumni_connect/widgets/custom_text_form_field.dart';
import 'package:alumni_connect/widgets/elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/saved_data.dart';

class UpdateTuition extends StatefulWidget {
  final String Class,subjects,location,salary,contactInfo,extraInfo,docId;
  const UpdateTuition({super.key, required this.Class, required this.subjects, required this.location, required this.salary, required this.extraInfo, required this.docId, required this.contactInfo});

  @override
  State<UpdateTuition> createState() => _UpdateTuitionState();
}

class _UpdateTuitionState extends State<UpdateTuition> {
  String userId = "";
  final TextEditingController _classEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController = TextEditingController();
  final TextEditingController _subjectEditingController = TextEditingController();
  final TextEditingController _salaryEditingController = TextEditingController();
  final TextEditingController _locationEditingController = TextEditingController();
  final TextEditingController _contactInfoController = TextEditingController();

  @override
  void initState(){
    super.initState();
    userId = SavedData.getUserId();
    _classEditingController.text = widget.Class;
    _subjectEditingController.text = widget.subjects;
    _locationEditingController.text = widget.location;
    _salaryEditingController.text = widget.salary;
    _contactInfoController.text = widget.contactInfo;
    _descriptionEditingController.text = widget.extraInfo;

  }
  @override
  void dispose(){
    _classEditingController.dispose();
    _descriptionEditingController.dispose();
    _salaryEditingController.dispose();
    _subjectEditingController.dispose();
    _locationEditingController.dispose();
    _contactInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
              children: [
                Icon(Icons.today_outlined),
                SizedBox(width: 8,),
                Text("Update Tuition Offer"),
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
                  labelText: "Class",
                  prefixIcon: null
              ),
              SizedBox(height: 13,),
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
                  labelText: "Subjects",
                  prefixIcon: null),
              SizedBox(height: 13,),
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
                  labelText: "Location",
                  prefixIcon: null),
              SizedBox(height: 13,),
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
                  labelText: "Salary",
                  prefixIcon: null),
              SizedBox(height: 13,),
              CustomTextFormField(
                  controller: _contactInfoController,
                  validator: (val){
                    if(val!.isEmpty){
                      return AppString.required;
                    }
                    return null;
                  }, keyboardType: TextInputType.text,
                  obscureText: false,
                  suffix: null,
                  hintText: "Enter Email/Phone No.",
                  labelText: "Enter Email/Phone No.",
                  prefixIcon: null),
              SizedBox(height: 13,),
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
                  labelText: "Other Info.",
                  prefixIcon: null),
              SizedBox(height: 40,),
              RoundedElevatedButton(buttonText: "Update Tuition",
                  onPressed: (){
                    if(_classEditingController.text=="" ||_descriptionEditingController.text==""||
                        _salaryEditingController.text==""|| _subjectEditingController.text=="" ||
                        _locationEditingController.text==""||_contactInfoController.text==""){
                      CustomSnackBar.showError(context, AppString.required);
                    }else {
                      updateTuition(_classEditingController.text,
                          _subjectEditingController.text,
                          _salaryEditingController.text,
                          _descriptionEditingController.text,
                          _locationEditingController.text,
                          _contactInfoController.text,
                          userId, widget.docId).then((value) =>
                          CustomSnackBar.showSuccess(context, "Updated Tuition Offer"));
                      context.pushNamed(RouteNames.homepage);
                    }
                  }),
              SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                showDialog(
                    context: context, builder:(context) =>
                    AlertDialog(title: Text("Are You Sure?"),
                        content: Text("You want to delete it"),
                      actions: [
                        TextButton(onPressed: (){
                          deleteTuition(widget.docId).then((value) {
                            CustomSnackBar.showSuccess(context, "Tuition Offer Deleted Successfully");
                            Navigator.pop(context);
                            context.pushReplacementNamed(RouteNames.homepage);
                          });
                        },
                            child: Text("Yes",style: TextStyle(color: Colors.red),)),
                        TextButton(onPressed: (){
                          Navigator.pop(context);
                        },
                            child: Text("No"))
                      ],)
                );
              },
                  style:ButtonStyle(
                    backgroundColor:WidgetStatePropertyAll(Colors.redAccent),
                    elevation: const WidgetStatePropertyAll(0),
                    shape: const WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                    fixedSize: WidgetStatePropertyAll(
                      Size(
                        MediaQuery.sizeOf(context).width,45,
                      ),
                    ),
                  ),
                  child: Text(
                    "Delete Tuition Offer",
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}
