import 'package:alumni_connect/features/homepagefeatures/alumnimanagementsection/alumni_directory.dart';
import 'package:alumni_connect/features/homepagefeatures/alumnimanagementsection/alumni_info.dart';
import 'package:alumni_connect/utils/app_image_url.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../data/database/user_information.dart';
import '../../routes/route_names.dart';
import '../homepagefeatures/about_us.dart';
import '../homepagefeatures/eventPage/event_page.dart';
import '../homepagefeatures/studentCommunity/students_community.dart';

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
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // 🔥 Custom Title Section
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF3E1E68), Color(0xFF222222)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                    offset: Offset(0, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(AppImageUrl.logo, height: 50, width: 50),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Rajshahi University of",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Engineering & Technology",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Alumni & Students Community",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => context.pushNamed(RouteNames.profile),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 🟦 Updated Grid Section with Find Alumni double size
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: _buildContainer(
                        context,
                        "Alumni Directory",
                        Colors.deepPurpleAccent,
                        AlumniDirectory(),
                        icon: Icons.school,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: _buildContainer(
                        context,
                        "Students\nCommunity",
                        Colors.teal,
                        StudentsCommunity(),
                        icon: Icons.group,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: _buildContainer(
                        context,
                        "Upcoming Events",
                        Colors.orangeAccent,
                        EventsPage(),
                        icon: Icons.event,
                      ),
                    ),
                    StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: _buildContainer(
                        context,
                        "About Us",
                        Colors.blueGrey,
                        AboutUs(),
                        icon: Icons.info_outline,
                      ),
                    ),
                    // ✅ Find Alumni (takes 2 columns)
                    StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 1,
                      child: _buildContainer(
                        context,
                        "See All Alumni List",
                        Colors.pinkAccent,
                        AlumniInfo(),
                        icon: Icons.search,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(
      BuildContext context,
      String title,
      Color color,
      Widget page, {
        bool shouldRefresh = false,
        IconData? icon,
      }) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
        if (shouldRefresh) {
          checkUserStatus();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: title == "See All Alumni List"
              ? const LinearGradient(
            colors: [Color(0xFFff6a00), Color(0xFFee0979)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )
              : null,
          color: title == "See All Alumni List" ? null : color.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon ?? Icons.star,
              color: Colors.white,
              size: 38,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
