import 'package:alumni_connect/data/saved_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/auth/auth.dart';
import '../../routes/route_names.dart';
import '../../widgets/elevated_button.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Logout"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close dialog
              child: Text("Cancel", style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {
                logoutUser();
                Navigator.of(context).pop();
                context.pushNamed(RouteNames.login);
              },
              child: Text("Logout", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
  String userName = "User";
  String userEmail = "Email";


  @override
  void initState(){
  userName = SavedData.getUserName();
  userEmail = SavedData.getUserEmail();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:
      Text("Profile",style: TextStyle(fontSize: 25),),
        // backgroundColor: Colors.orangeAccent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                child: Icon(Icons.person, size: 50),
              ),
              SizedBox(height: 10),
              Text(
               "${userName}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "${userEmail}",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 100),

              // RoundedElevatedButton(
              //     buttonText: "Update Profile",
              //     onPressed: () => context.pushNamed(RouteNames.updateAlumni),
              // ),
              SizedBox(height: 10,),
              RoundedElevatedButton(
                buttonText: "Update Or Delete Tuition Offers ",
                onPressed: () => context.pushNamed(RouteNames.editTuition),
              ),
              SizedBox(height: 10,),
              // RoundedElevatedButton(
              //     buttonText: "Logout",
              //     onPressed: () =>_logout(context),
              // ),
              ElevatedButton(
                  onPressed:() => _logout(context),
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
                  child:Text("Logout",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),),
              ),

              // TextField(
              //   controller: nameController,
              //   decoration: InputDecoration(
              //     labelText: "Name",
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 10),
              // TextField(
              //   controller: emailController,
              //   decoration: InputDecoration(
              //     labelText: "Email",
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 10),
              // TextField(
              //   controller: dobController,
              //   decoration: InputDecoration(
              //     labelText: "Date of Birth",
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 10),
              // TextField(
              //   controller: genderController,
              //   decoration: InputDecoration(
              //     labelText: "Gender",
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              // SizedBox(height: 10),
              // TextField(
              //   controller: numberController,
              //   decoration: InputDecoration(
              //     labelText: "Phone Number",
              //     border: OutlineInputBorder(),
              //   ),
              //   keyboardType: TextInputType.phone,
              // ),
              // SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () {
              //     setState(() {});
              //   },
              //   child: Text("Update Profile"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
