import 'package:alumni_connect/data/database/user_information.dart';
import 'package:alumni_connect/widgets/custom_text_form_field.dart';
import 'package:alumni_connect/widgets/elevated_button.dart';
import 'package:flutter/material.dart';

class SearchAlumni extends StatefulWidget {
  const SearchAlumni({super.key});

  @override
  State<SearchAlumni> createState() => _SearchAlumniState();
}

class _SearchAlumniState extends State<SearchAlumni> {
  final TextEditingController _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search for Alumni"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomTextFormField(
                    controller: _locationController,
                    validator: (val){
                      if(val!.isEmpty){
                        return "Please Enter Location";
                      }
                      return null;
                    },
                    obscureText: false,
                    suffix: null,
                    prefixIcon: Icon(Icons.location_on),
                    keyboardType: TextInputType.text,
                    labelText: "Enter the Location ",
                    hintText: "Enter the Location",
                ),
                SizedBox(height: 20,),
                RoundedElevatedButton(
                    buttonText: "Search Alumni",
                    onPressed: () => searchLocationResult(
                        _locationController.text
                    )
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
