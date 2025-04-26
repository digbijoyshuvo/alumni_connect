import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Banner with Image and Overlay
            Stack(
              children: [
                Container(
                  height: size.height * 0.35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4),
                        BlendMode.darken,
                      ),
                      child: Image.asset(
                        "assets/images/About_US.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios, size: 25, color: Colors.white),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: size.width * 0.28,
                  child: Text(
                    "About Us",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: size.height * 0.045,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          blurRadius: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),

            // Description and Highlights
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to Campus Connect",
                    style: GoogleFonts.montserrat(
                      fontSize: size.height * 0.025,
                      color: Colors.tealAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Your bridge between the present and the past of your campus community!",
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.018,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Our Mission",
                    style: GoogleFonts.poppins(
                      fontSize: size.height * 0.022,
                      color: Colors.lightGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "We aim to help students and alumni stay connected, share opportunities, and build a thriving professional network beyond graduation.",
                    style: GoogleFonts.roboto(
                      fontSize: size.height * 0.018,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "What We Offer",
                    style: GoogleFonts.poppins(
                      fontSize: size.height * 0.022,
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  _customFeatureTile(
                    icon: Icons.manage_accounts_rounded,
                    title: "Alumni Account Management",
                    description:
                    "Create, update, and manage your alumni profile to stay engaged with your campus family.",
                    color: Colors.deepPurpleAccent,
                  ),
                  const SizedBox(height: 14),

                  _customFeatureTile(
                    icon: Icons.search,
                    title: "Alumni Searching facility",
                    description:
                    "Students can find alumni by department, location, or job field for mentorship and advice.",
                    color: Colors.cyanAccent,
                  ),
                  const SizedBox(height: 14),

                  _customFeatureTile(
                    icon: Icons.school_outlined,
                    title: "Tuition Offers Section",
                    description:
                    "Post or explore tuition offers and tutoring opportunities shared by the community.",
                    color: Colors.orangeAccent,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customFeatureTile({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.grey[300],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
