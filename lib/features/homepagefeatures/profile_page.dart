import 'package:alumni_connect/data/saved_data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/auth/auth.dart';
import '../../routes/route_names.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "Sarah Page";
  String userEmail = "xxx@gmail.com";

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          title: const Text("Confirm Logout", style: TextStyle(color: Colors.white)),
          content: const Text("Are you sure you want to log out?", style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel", style: TextStyle(color: Colors.greenAccent)),
            ),
            TextButton(
              onPressed: () {
                logoutUser();
                Navigator.of(context).pop();
                context.pushNamed(RouteNames.login);
              },
              child: const Text("Logout", style: TextStyle(color: Colors.redAccent)),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    userName = SavedData.getUserName();
    userEmail = SavedData.getUserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            SizedBox(height: 15,),
            // Back and Settings
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Text("Profile",
                  style:TextStyle(fontSize: 25,
                      fontWeight: FontWeight.bold,color: Colors.lightGreen),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Profile Image with Edit Button
            // Simple Demo Profile Icon
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1F1F1F),
              ),
              child: const Icon(
                Icons.person,
                size: 60,
                color: Colors.white70,
              ),
            ),

            const SizedBox(height: 10),

            // Name and Role
            Text(
              userName,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              userEmail,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 40),

            // Profile Details Form
            _buildInfoField(Icons.person, "Name",userName),
            const SizedBox(height: 12),
            _buildInfoField(Icons.email_outlined, "Your Email", userEmail),
            const SizedBox(height: 30),

            // Action Buttons
            _buildGradientButton("Edit Your Alumni Profile", () => context.pushNamed(RouteNames.updateAlumni)),
            const SizedBox(height: 12),
            _buildGradientButton("Update or Delete Tuition Offers", () => context.pushNamed(RouteNames.editTuition)),
            const SizedBox(height: 12),
            _buildLogoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(IconData icon, String label, String value, {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: value,
          readOnly: true,
          obscureText: isPassword,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.white70),
            filled: true,
            fillColor: const Color(0xFF1F1F1F),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF56AB2F)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGradientButton(String text, VoidCallback onPressed) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFA8E063), Color(0xFF56AB2F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFB31217), Color(0xFFE52D27)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.4),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _logout(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
