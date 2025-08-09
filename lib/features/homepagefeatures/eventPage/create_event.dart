import 'dart:io';

import 'package:alumni_connect/data/database/event_database.dart';
import 'package:alumni_connect/widgets/custom_input_form.dart';
import 'package:alumni_connect/widgets/custom_snackbar.dart';
import 'package:alumni_connect/widgets/custom_text_form_field.dart';
import 'package:alumni_connect/widgets/elevated_button.dart';
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
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _sponsorController.dispose();
    _guestController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  // Function to PickUp date and time

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      if (pickedTime != null) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Create an Event",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.lightGreen,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 2),
                ],
              ),
            ),

            // Main Form Section (Scrollable)
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    CustomTextFormField(
                      controller: _nameController,
                      validator: (val) =>
                          val!.isEmpty ? "Please fill the event name" : null,
                      obscureText: false,
                      hintText: "Enter Event Name",
                      suffix: null,
                      prefixIcon: Icon(Icons.event_outlined),
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      controller: _descriptionController,
                      validator: (val) =>
                          val!.isEmpty ? "Please fill the description" : null,
                      maxLine: 4,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      suffix: null,
                      labelText: "Enter Event Description",
                      prefixIcon: Icon(Icons.description_outlined),
                    ),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      controller: _locationController,
                      validator: (val) =>
                          val!.isEmpty ? "Please fill the location" : null,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      suffix: null,
                      hintText: "Enter Event Location",
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    SizedBox(height: 15),
                    CustomInputForm(
                      controller: _dateController,
                      icon: Icons.date_range_outlined,
                      hint: "Pickup Date and Time",
                      readOnly: true,
                      onTap: () => _selectDateTime(context),
                    ),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      controller: _guestController,
                      validator: (val) =>
                          val!.isEmpty ? "Please fill the guests name" : null,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      suffix: null,
                      hintText: "Special Guests",
                      prefixIcon: Icon(Icons.people),
                    ),
                    SizedBox(height: 15),
                    CustomTextFormField(
                      controller: _sponsorController,
                      validator: (val) =>
                          val!.isEmpty ? "Please fill the sponsor list" : null,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      suffix: null,
                      hintText: "Sponsors",
                      prefixIcon: Icon(Icons.attach_money_outlined),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Footer Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: RoundedElevatedButton(
                buttonText: "Create Event",
                onPressed: () {
                  if (_nameController.text == "" ||
                      _descriptionController.text == "" ||
                      _locationController.text == "" ||
                      _dateController.text == "" ||
                      _guestController.text == "" ||
                      _sponsorController.text == "") {
                    CustomSnackBar.showError(
                        context, "Please Fill The Required Informations");
                  } else {
                    createEvent(
                      _nameController.text,
                      _descriptionController.text,
                      _locationController.text,
                      _guestController.text,
                      _sponsorController.text,
                      _dateController.text,
                    ).then((value) =>
                        CustomSnackBar.showSuccess(context, "Event Created"));
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
