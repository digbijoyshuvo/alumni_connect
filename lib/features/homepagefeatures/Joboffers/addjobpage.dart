import 'package:alumni_connect/widgets/custom_snackbar.dart';
import 'package:alumni_connect/widgets/custom_text_form_field.dart';
import 'package:alumni_connect/widgets/elevated_button.dart';
import 'package:flutter/material.dart';

import '../../../data/database/jobdata.dart';
import '../../../data/saved_data.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({super.key});

  @override
  State<AddJobPage> createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  String userId = "";
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _jobDescriptionController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _contactInfoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();

  @override
  void initState(){
    userId = SavedData.getUserId();
    super.initState();
  }
  @override
  void dispose(){
    _jobTitleController.dispose();
    _jobDescriptionController.dispose();
    _salaryController.dispose();
    _locationController.dispose();
    _contactInfoController.dispose();
    _emailController.dispose();
    _companyNameController.dispose();
    super.dispose();
  }

  void clearText(){
    _jobTitleController.clear();
    _jobDescriptionController.clear();
    _salaryController.clear();
    _locationController.clear();
    _contactInfoController.clear();
    _emailController.clear();
    _companyNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.work_outline),
            SizedBox(width: 8,),
            const Text("Add a Job Offers"),
          ],
        ),
        backgroundColor: const Color(0xFF3D348B), // Purple color
        centerTitle: true,
      ),

      body: Padding(padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              CustomTextFormField(
                controller: _jobTitleController,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Job title is required";
                    }
                    return null;
                  },
                  obscureText: false,
                  suffix: null,
                  hintText: 'Enter the Job Title',
                  prefixIcon: const Icon(Icons.title),
                  keyboardType: TextInputType.text,),
              SizedBox(height: 15,),
              CustomTextFormField(
                controller: _jobDescriptionController,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Job description is required";
                    }
                    return null;
                  },
                  obscureText: false,
                  suffix: null,
                  labelText: "Provide a brief description of the job",
                  prefixIcon: const Icon(Icons.description),
                  maxLine: 3,
                  keyboardType: TextInputType.text,),
              SizedBox(height: 15,),
              CustomTextFormField(
                controller: _salaryController,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Salary is required";
                    }
                    return null;
                  },
                  obscureText: false,
                  suffix: null,
                  hintText: 'Enter the Salary to be offered',
                  prefixIcon: const Icon(Icons.monetization_on),
                  keyboardType: TextInputType.number,),
              SizedBox(height: 15,),
              CustomTextFormField(
                controller: _companyNameController,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Company name is required";
                    }
                    return null;
                  },
                  obscureText: false,
                  suffix: null,
                  hintText: 'Enter the Name of the Company',
                  prefixIcon: const Icon(Icons.business),
                  keyboardType: TextInputType.text,),
              SizedBox(height: 15,),
              CustomTextFormField(
                controller: _locationController,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Company name is required";
                    }
                    return null;
                  },
                  obscureText: false,
                  suffix: null,
                 hintText: 'Enter the Location of the company',
                  prefixIcon: const Icon(Icons.location_on),
                  keyboardType: TextInputType.text,),
              SizedBox(height: 15,),

              CustomTextFormField(
                controller: _contactInfoController,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Provide Helpline Number of the company";
                    }
                    return null;
                  },
                  obscureText: false,
                  suffix: null,
                  hintText: 'Enter the Contact Number for query',
                  prefixIcon: const Icon(Icons.phone),
                  keyboardType: TextInputType.phone,),
              SizedBox(height: 15,),
              CustomTextFormField(
                controller: _emailController,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Email is required";
                    }
                    return null;
                  },
                  obscureText: false,
                  suffix: null,
                  hintText: 'Enter the Email Address of the company',
                  prefixIcon: const Icon(Icons.email),
                  keyboardType: TextInputType.emailAddress,),

              SizedBox(height: 40,),
              RoundedElevatedButton(
                  buttonText: 'Add Job Offer',
                  onPressed: (){
                    if(_jobTitleController.text.isEmpty || _jobDescriptionController.text.isEmpty || _salaryController.text.isEmpty || _locationController.text.isEmpty || _contactInfoController.text.isEmpty || _emailController.text.isEmpty || _companyNameController.text.isEmpty){
                      CustomSnackBar.showError(context, "All fields are required");
                    } else {
                      try {
                        addJobOffer(
                          _jobTitleController.text,
                          _jobDescriptionController.text,
                          _salaryController.text,
                          _locationController.text,
                          _contactInfoController.text,
                          _emailController.text,
                          _companyNameController.text,
                          userId
                        );
                        CustomSnackBar.showSuccess(context, "Job Offer Added Successfully");
                        clearText();
                        Navigator.pop(context, true);
                      } catch (e) {
                        CustomSnackBar.showError(context, "Failed to add job offer: $e");
                      }
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
