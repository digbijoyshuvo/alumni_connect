import 'dart:io';

import 'package:alumni_connect/data/database/event_database.dart';
import 'package:alumni_connect/widgets/custom_input_form.dart';
import 'package:alumni_connect/widgets/custom_snackbar.dart';
import 'package:alumni_connect/widgets/custom_text_form_field.dart';
import 'package:alumni_connect/widgets/elevated_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _guestController = TextEditingController();
  final TextEditingController _sponsorController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  // FilePickerResult? _filePickResult;

  @override
  void dispose(){
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _sponsorController.dispose();
    _guestController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // Function to PickUp date and time

  Future<void> _selectDateTime(BuildContext context)async{
    final DateTime? pickedDateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),);

    if(pickedDateTime !=null){
      final TimeOfDay? pickedTime =
      await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now());

      if(pickedTime !=null){
        final DateTime selectedDateTime = DateTime(
            pickedDateTime.year,
            pickedDateTime.month,
            pickedDateTime.day,
            pickedTime.hour,
            pickedTime.minute);
        setState(() {
          _dateController.text = selectedDateTime.toString();
        });
      }
    }
  }


  // // Function to pick photos
  // void _openFilePicker()async{
  //   FilePickerResult? res = await FilePicker.platform.pickFiles();
  //   setState(() {
  //     _filePickResult =res;
  //   });
  //
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("Create an Event",
                    style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.lightGreen)),
                SizedBox(height: 25,),
                // GestureDetector(
                //   onTap: ()=> _openFilePicker(),
                //   child: Container(
                //     width: double.infinity,
                //     height: MediaQuery.of(context).size.height*.25,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(8),
                //       color: Colors.lightGreenAccent,
                //     ),
                //     child: _filePickResult !=null
                //         ? ClipRRect(
                //       borderRadius: BorderRadius.circular(8),
                //       child: Image(
                //           image: FileImage(
                //             File(_filePickResult!.files.first.path!)),
                //       fit: BoxFit.cover,),
                //     ):
                //     Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(Icons.add_a_photo_outlined,size: 40,color: Colors.black,),
                //         SizedBox(height: 8,),
                //         Text("Add Event Image",
                //         style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(height: 15,),
                CustomInputForm(
                    icon: Icons.event,
                    hint: "Enter Event Name",
                  controller: _nameController,
                  keyboardType: TextInputType.text,

                ),
                SizedBox(height: 15,),
                CustomTextFormField(
                  controller: _descriptionController,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Please fill the description";
                    }
                    return null;
                  },
                  maxLine: 4,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  suffix: null,
                  labelText: "Enter Event Description",
                  prefixIcon: Icon(Icons.description_outlined),
                ),
                SizedBox(height: 15,),
                CustomTextFormField(
                  controller: _locationController,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Please fill the location";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  suffix: null,
                  hintText: "Enter Event Location",
                  prefixIcon: Icon(Icons.location_on),
                ),

                SizedBox(height: 15,),
                CustomInputForm(
                  controller: _dateController,
                    icon: Icons.date_range_outlined,
                    hint:"Pickup Date and Time",
                  readOnly: true,
                  onTap: ()=>_selectDateTime(context),
                ),

                SizedBox(height: 15,),
                CustomTextFormField(
                  controller: _guestController,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Please fill the guests name";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  suffix: null,
                  hintText: "Special Guests ",
                  prefixIcon: Icon(Icons.people),
                ),

                SizedBox(height: 15,),
                CustomTextFormField(
                  controller: _sponsorController,
                  validator: (val){
                    if(val!.isEmpty){
                      return "Please fill the sponsor list";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  suffix: null,
                  hintText: "Sponsors",
                  prefixIcon: Icon(Icons.attach_money_outlined),
                ),
                SizedBox(height: 50,),
                RoundedElevatedButton(
                    buttonText: "Create Event",
                    onPressed: (){
                      if(_nameController.text=="" || _descriptionController.text== ""||
                      _locationController.text==""|| _dateController.text=="" ||
                      _guestController.text==""||_sponsorController.text==""){
                        CustomSnackBar.showError(context, "Please Fill The Required Informations");
                      }else{
                        createEvent(
                            _nameController.text,
                            _descriptionController.text,
                            _locationController.text,
                            _guestController.text,
                            _sponsorController.text,
                            _dateController.text).then((value) =>
                        CustomSnackBar.showSuccess(context, "Event Created"));
                        Navigator.pop(context);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
