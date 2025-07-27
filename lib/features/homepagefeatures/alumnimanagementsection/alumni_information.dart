import 'package:flutter/material.dart';
import 'package:appwrite/models.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class AlumniInformation extends StatefulWidget {
  final Document data;
  const AlumniInformation({super.key, required this.data});

  @override
  State<AlumniInformation> createState() => _AlumniInformationState();
}

class _AlumniInformationState extends State<AlumniInformation> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Image Section
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Container(
              height: screenHeight * 0.33,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://cloud.appwrite.io/v1/storage/buckets/67df2c36003a14b7edef/files/${widget.data.data["images"]}/view?project=67dc74870003bb181f04",
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.4),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: Stack(
                children: [
                  // Back Button
                  Positioned(
                    top: screenHeight * 0.04,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.7),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  // Name & Location
                  Positioned(
                    bottom: 20,
                    left: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.data.data["name"] ?? '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.07,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.location_on, color: Colors.white70, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              widget.data.data["location"] ?? '',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: screenWidth * 0.04,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Facebook Icon
                  Positioned(
                    bottom: 10,
                    right: 15,
                    child: Link(
                      uri: Uri.parse(widget.data.data["facebookId"] ?? ''),
                      builder: (context, followLink) => GestureDetector(
                        onTap: followLink,
                        child: CircleAvatar(
                          radius: screenWidth * 0.07,
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.facebook, color: Colors.blueAccent, size: screenWidth * 0.12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.04),

          // Information Section
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoItem(Icons.person, "Name", widget.data.data["name"], textColor: Colors.white, fontSize: screenWidth * 0.045),
                  SizedBox(height: screenHeight * 0.02),
                  _infoItem(Icons.apartment, "Department", widget.data.data["department"], textColor: Colors.white70, fontSize: screenWidth * 0.043),
                  SizedBox(height: screenHeight * 0.02),
                  _infoItem(Icons.numbers, "Series", widget.data.data["Series"], textColor: Colors.white70, fontSize: screenWidth * 0.043),
                  SizedBox(height: screenHeight * 0.02),
                  _infoItem(Icons.work, "Workplace", widget.data.data["workplace"], textColor: Colors.lightGreenAccent, fontSize: screenWidth * 0.043),
                  SizedBox(height: screenHeight * 0.02),
                  _infoItem(Icons.email, "Email", widget.data.data["email"], textColor: Colors.lightBlueAccent, fontSize: screenWidth * 0.043),

                  SizedBox(height: screenHeight * 0.07),

                  // Connect Button
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                          vertical: screenHeight * 0.015,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () {
                        final email = widget.data.data["email"];
                        if (email != null && email.isNotEmpty) {
                          final Uri emailUri = Uri(
                            scheme: 'mailto',
                            path: email,
                            query: Uri.encodeFull('subject=Hello from Alumni App'),
                          );
                          launchUrl(emailUri);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Email address not available")),
                          );
                        }
                      },
                      icon: const Icon(Icons.email_outlined, color: Colors.white),
                      label: Text(
                        "Connect",
                        style: TextStyle(color: Colors.white, fontSize: screenWidth * 0.045),
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.04),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String label, String? value, {Color textColor = Colors.white, double fontSize = 16}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blueAccent, size: fontSize + 6),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: fontSize - 2,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value ?? '-',
                style: TextStyle(
                  fontSize: fontSize,
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
