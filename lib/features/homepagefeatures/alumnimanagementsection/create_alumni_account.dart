import 'dart:io';

import 'package:alumni_connect/data/database/user_information.dart';
import 'package:alumni_connect/data/saved_data.dart';
import 'package:alumni_connect/routes/route_names.dart';
import 'package:alumni_connect/utils/app_string.dart';
import 'package:alumni_connect/widgets/custom_snackbar.dart';
import 'package:alumni_connect/widgets/custom_text_form_field.dart';
import 'package:alumni_connect/widgets/elevated_button.dart';
import 'package:appwrite/appwrite.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/auth/auth.dart';

class  JoinOurCommunity extends StatefulWidget {
  const JoinOurCommunity({super.key});

  @override
  State<JoinOurCommunity> createState() => _JoinOurCommunityState();
}

class _JoinOurCommunityState extends State<JoinOurCommunity> {

  String userId = "";
  FilePickerResult? _filePickerResult;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _seriesController = TextEditingController();
  final TextEditingController _workplaceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Storage storage = Storage(client);
  bool isUploading = false;
  @override
  void initState(){
    userId = SavedData.getUserId();
    super.initState();
  }

  void _openFilePicker()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    setState(() {
      _filePickerResult =result;
    });
  }

  // Upload event images to Storage Bucket
  Future uploadAlumniImage()async{
    setState(() {
      isUploading = true;
    });
    try{
      if(_filePickerResult!= null){
        PlatformFile file = _filePickerResult!.files.first;
        const int maxSizeInBytes = 50*1024;
        if(file.size > maxSizeInBytes){
          CustomSnackBar.showError(context, "File is too large. Max size is 50KB");
          return null;
        }
        final fileBytes = await File(file.path!).readAsBytes();
        final inputFile = InputFile.fromBytes(bytes: fileBytes, filename: file.name);

        final response = await storage.createFile(
            bucketId: "67df2c36003a14b7edef",
            fileId: ID.unique(),
            file: inputFile);
        print(response.$id);
        return response.$id;
      }
      else{
        print("Something Went Wrong");
      }
    }catch(ex){
      print(ex);
    }finally{
      setState(() {
        isUploading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  "Please Provide the following Information to Join Our Alumni Community",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap:()=> _openFilePicker(),
                  child: Container(width: double.infinity,height: MediaQuery.of(context).size.height*.25,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF3D348B), // Deep violet (like AppColor.appColor)
                          Color(0xFF845EC2), // Soft purple for blend
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),

                    child: _filePickerResult !=null ?
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(image: FileImage(
                          File(_filePickerResult!.files.first.path!)),
                        fit: BoxFit.cover,
                      ),
                    ): Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo_outlined,size: 35,
                          color:Colors.black,
                        ),
                        SizedBox(height: 8,),
                        Text('Add Your Image',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),

                      ],
                    ),

                  ),
                ),
                SizedBox(height: 10,),
                CustomTextFormField(
                    controller: _nameController,
                    validator: (val){
                      if(val!.isEmpty){
                        return AppString.required;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    hintText: "Enter Your Name",
                    suffix: null,
                    prefixIcon: Icon(Icons.person)),
                SizedBox(height: 10),
                CustomTextFormField(
                    controller: _departmentController,
                    validator: (val){
                      if(val!.isEmpty){
                        return AppString.required;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    hintText: "Enter Your Department",
                    suffix: null,
                    prefixIcon: Icon(Icons.school)),
                SizedBox(height: 10),
                CustomTextFormField(
                    controller: _seriesController,
                    validator: (val){
                      if(val!.isEmpty){
                        return AppString.required;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    hintText: "Enter Your Series",
                    suffix: null,
                    prefixIcon: Icon(Icons.info)),
                SizedBox(height: 10),
                CustomTextFormField(
                    controller: _addressController,
                    validator: (val){
                      if(val!.isEmpty){
                        return AppString.required;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    hintText: "Your Current Location",
                    suffix: null,
                    prefixIcon: Icon(Icons.location_on)),
                SizedBox(height: 10),
                CustomTextFormField(
                    maxLine: 2,
                    controller: _workplaceController,
                    validator: (val){
                      if(val!.isEmpty){
                        return AppString.required;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    hintText: "Your Current University/\nYour Current Company",
                    suffix: null,
                    prefixIcon: Icon(Icons.info)),
                SizedBox(height: 10),
                CustomTextFormField(
                    controller: _facebookController,
                    validator: (val){
                      if(val!.isEmpty){
                        return AppString.required;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    hintText: " Your Facebook ID",
                    suffix: null,
                    prefixIcon: Icon(Icons.facebook)),
                SizedBox(height: 10),
                CustomTextFormField(
                    controller: _emailController,
                    validator: (val){
                      if(val!.isEmpty){
                        return AppString.required;
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    hintText: "Your Email ID",
                    suffix: null,
                    prefixIcon: Icon(Icons.email)),
                SizedBox(height: 50),
                RoundedElevatedButton(
                    buttonText: "Submit",
                    onPressed:(){
                      if(_nameController.text==""|| _departmentController.text== ""||
                          _seriesController.text==""||_addressController.text==""|| _emailController.text==""){
                        CustomSnackBar.showError(context, AppString.required);
                      }else{
                        uploadAlumniImage().then((value) => createAlumni(
                            _nameController.text, _departmentController.text,
                            _seriesController.text, _addressController.text,
                            _workplaceController.text,  _facebookController.text,
                            _emailController.text,value,userId)).then((value) =>
                            CustomSnackBar.showSuccess(context, "Event Created")
                        );
                        context.pushNamed(RouteNames.homepage);
                      }

                    }
                ),
                // Expanded(
                //   child: ListView(
                //     children: [
                //       // _buildInputField("Name"),
                //       // _buildInputField("Department"),
                //       // _buildInputField("Series"),
                //       // _buildInputField("Current University/\nCurrent Company"),
                //       // _buildInputField("Present Address"),
                //       // _buildInputField("Facebook ID"),
                //       // _buildInputField("LinkedIn"),
                //       // _buildInputField("Email"),
                //       SizedBox(height: 20),
                //       ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor: Colors.red,
                //           padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(10),
                //           ),
                //         ),
                //         onPressed: () => joinPage(context),
                //         child: Text(
                //           "Submit",
                //           style: TextStyle(color: Colors.black, fontSize: 18),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
