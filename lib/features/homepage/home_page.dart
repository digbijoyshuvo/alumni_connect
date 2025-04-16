
import 'package:alumni_connect/features/homepagefeatures/alumnimanagementsection/create_alumni_account.dart';
import 'package:alumni_connect/theme/app_color.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../data/database/user_information.dart';
import '../../routes/route_names.dart';
import '../homepagefeatures/about_us.dart';
import '../homepagefeatures/alumnimanagementsection/alumni_directory.dart';
import '../homepagefeatures/alumnimanagementsection/update_alumni_page.dart';
import '../homepagefeatures/eventPage/event_page.dart';
import '../homepagefeatures/students_community.dart';
import '../homepagefeatures/tuitionpage/tution_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool hasAccount = false;

  @override
  void initState() {
    checkUserStatus();
    super.initState();
  }

  Future<void> checkUserStatus() async {
    bool result = await hasUserCreatedAlumni();
    setState(() {
      hasAccount = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // SizedBox(height: 30,),
            Container(
              height: 120.0,
              width: double.infinity,
              color: AppColor.appBarColor,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center, // Center the Row horizontally
                crossAxisAlignment: CrossAxisAlignment.center, // Center the Row vertically
                children: [
                  // Title Section
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the Column vertically
                    crossAxisAlignment: CrossAxisAlignment.center, // Center the Column horizontally
                    children: [
                      Text(
                        "Rajshahi University Of Engineering",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "and Technology, Rajshahi",
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Alumni and Students Community", // Second line
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  // Add some spacing between the title and the profile icon
                  SizedBox(width: 30), // Adjust the spacing as needed
                  // Profile Icon with PopupMenuButton
                  GestureDetector(
                    onTap: ()=> context.pushNamed(RouteNames.profile),
                      child: Icon(
                          Icons.person)),
                ],
              ),
            ),
            // Body Content
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildContainer(context, "Alumni Directory", Colors.blue, AlumniDirectory()),
                    _buildContainer(context, "  Students\nCommunity", Colors.pink, StudentsCommunity()),
                    _buildContainer(context, "Events", Colors.orange, EventsPage()),
                    _buildContainer(context, "Tuition Offers", Colors.red, TuitionPage()),
                    _buildContainer(context, "About US", Colors.cyan, AboutUs()),
                   hasAccount ? _buildContainer(context, "Update Your\nInformation", Colors.purple,
                   UpdateAlumniPage()):
                    _buildContainer(context, "  Join Our\nCommunity", Colors.purple, JoinOurCommunity(),shouldRefresh: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(BuildContext context, String title, Color color, Widget page,
  {bool shouldRefresh = false,
  }) {
    return GestureDetector(
      onTap: () async{
       await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
       if(shouldRefresh){
         checkUserStatus();
       }
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 5,
              spreadRadius: 5,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

// Replace with your actual profile page widget
