import 'dart:io';

import 'package:alumni_connect/data/database/user_information.dart';
import 'package:alumni_connect/data/saved_data.dart';
import 'package:alumni_connect/routes/route_names.dart';
import 'package:alumni_connect/theme/app_color.dart';
import 'package:alumni_connect/utils/app_string.dart';
import 'package:alumni_connect/widgets/custom_snackbar.dart';
import 'package:alumni_connect/widgets/custom_text_form_field.dart';
import 'package:alumni_connect/widgets/elevated_button.dart';
import 'package:appwrite/appwrite.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/auth/auth.dart';
import '../../homepage/home_page.dart';

class  EditPage extends StatefulWidget {
  final String name,dept,Series,location,workplace,facebookId,email,images,docId;
  const  EditPage({super.key,
    required this.name,
    required this.dept,
    required this.Series,
    required this.location,
    required this.workplace,
    required this.facebookId,
    required this.email,
    required this.images,
    required this.docId});

  @override
  State< EditPage> createState() => _EditPageState();
}

class _EditPageState extends State< EditPage> {
  void joinPage(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  String userId = "";
  FilePickerResult? _filePickerResult;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _seriesController = TextEditingController();
  final TextEditingController _workplaceController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _facebookController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Storage storage = Storage(client);
  bool isUploading = false;
  @override
  void initState(){
    userId = SavedData.getUserId();
    _nameController.text = widget.name;
    _departmentController.text = widget.dept;
    _seriesController.text = widget.Series;
    _addressController.text = widget.location;
    _workplaceController.text = widget.workplace;
    _facebookController.text = widget.facebookId;
    _emailController.text = widget.email;
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
                  "Update Your Information",
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap:()=> _openFilePicker(),
                  child: Container(width: double.infinity,height: MediaQuery.of(context).size.height*.25,
                    decoration: BoxDecoration(
                        color:AppColor.appColor,
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: _filePickerResult !=null ?
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image(image: FileImage(
                          File(_filePickerResult!.files.first.path!)),
                        fit: BoxFit.cover,
                      ),
                    ):ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network("https://cloud.appwrite.io/v1/storage/buckets/67df2c36003a14b7edef/files/${widget.images}/view?project=67dc74870003bb181f04",
                      fit: BoxFit.cover,)
                    )
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
                    buttonText: "Update",
                    onPressed:(){
                      if(_nameController.text==""|| _departmentController.text== ""||
                          _seriesController.text==""||_addressController.text==""|| _emailController.text==""){
                        CustomSnackBar.showError(context, AppString.required);
                      }else{
                        if(_filePickerResult == null) {
                              updateAlumni(
                                  _nameController.text,
                                  _departmentController.text,
                                  _seriesController.text,
                                  _addressController.text,
                                  _workplaceController.text,
                                  _facebookController.text,
                                  _emailController.text,
                                  widget.images,
                                  userId,
                                  widget.docId).then((value) =>
                              CustomSnackBar.showSuccess(
                                  context, "Your Information is  Updated")
                          );
                          context.pushNamed(RouteNames.homepage);
                        }else {
                          uploadAlumniImage().then((value) =>
                              updateAlumni(
                                  _nameController.text,
                                  _departmentController.text,
                                  _seriesController.text,
                                  _addressController.text,
                                  _workplaceController.text,
                                  _facebookController.text,
                                  _emailController.text,
                                  value,
                                  userId,
                                  widget.docId)).then((value) =>
                              CustomSnackBar.showSuccess(
                                  context, "Your Information is  Updated")
                          );
                          context.pushNamed(RouteNames.homepage);
                        }
                        }
                    }
                ),

                SizedBox(height: 25,),

                ElevatedButton(onPressed: (){
                  showDialog(
                      context: context, builder:(context) =>
                      AlertDialog(title: Text("Are You Sure?"),
                        content: Text("You want to delete Your Profile"),
                        actions: [
                          TextButton(onPressed: (){
                            deleteAlumniInfo(widget.docId).then((value)async {
                              await storage.deleteFile(bucketId: "67df2c36003a14b7edef",
                                  fileId: widget.images);
                              CustomSnackBar.showSuccess(context, "Your Information Deleted Successfully");
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
                      "Delete Your Account",
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
