import 'package:alumni_connect/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/database/user_information.dart';

class AlumniDirectory extends StatefulWidget {
  const AlumniDirectory({super.key});

  @override
  State<AlumniDirectory> createState() => _AlumniDirectoryState();
}

class _AlumniDirectoryState extends State<AlumniDirectory> {
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
      body: Column(
        children: [
          // Gradient AppBar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 36),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3D348B), Color(0xFF845EC2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 6,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox( width: 8,),
                IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon:Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                     "Alumni Directory",
                     style: TextStyle(
                       fontSize: 24,
                       fontWeight: FontWeight.bold,
                       color: Colors.white,
                       letterSpacing: 1.2,
                     ),
                    ),
                  ),
                ),
                const SizedBox(width: 45,),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Buttons section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  hasAccount?
                  _GradientButton(
                    title: "Update Your Information",
                    gradientColors: [
                      Color(0xFF6A11CB), // Deep purple
                      Color(0xFF2575FC), // Cool blue
                    ],
                    onTap: () {
                      context.pushNamed(RouteNames.updateAlumni);
                    },
                  ):_GradientButton(
                    title: "Join Our Community",
                    gradientColors: [Color(0xFFBA5370), Color(0xFFF4E2D8)],
                    onTap: () {
                      context.pushNamed(RouteNames.createAlumni);
                    },
                  ),
                  _GradientButton(
                    title: "Your Batch mates",
                    gradientColors: [Color(0xFF56ab2f), Color(0xFFa8e063)],
                    onTap: () {
                      context.pushNamed(RouteNames.searchBySeries);
                    },
                  ),
                  _GradientButton(
                    title: "People Closer You",
                    gradientColors: [Color(0xFF74ebd5), Color(0xFFACB6E5)],
                    onTap: () {
                     context.pushNamed(RouteNames.searchAlumni);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientButton extends StatelessWidget {
  final String title;
  final List<Color> gradientColors;
  final VoidCallback onTap;

  const _GradientButton({
    required this.title,
    required this.gradientColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
