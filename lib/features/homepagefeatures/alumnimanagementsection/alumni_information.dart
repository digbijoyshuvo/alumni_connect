import 'package:flutter/material.dart';
import 'package:appwrite/models.dart';
import 'package:url_launcher/link.dart';

class AlumniInformation extends StatefulWidget {
  final Document data;
  const AlumniInformation({super.key, required this.data});

  @override
  State<AlumniInformation> createState() => _AlumniInformationState();
}

class _AlumniInformationState extends State<AlumniInformation> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Dark background
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Image Section (1/3 screen height)
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
            child: Container(
              height: screenHeight * 0.33, // 1/3 of the screen
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
                    top: 40,
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
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
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
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
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
                        child: const CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.transparent,
                          child: Icon(Icons.facebook, color: Colors.blueAccent, size: 50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 40),

          // Information Section (open, no cards)
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoItem(Icons.person, "Name", widget.data.data["name"], textColor: Colors.white),
                  const SizedBox(height: 18),
                  _infoItem(Icons.apartment, "Department", widget.data.data["department"], textColor: Colors.white70),
                  const SizedBox(height: 18),
                  _infoItem(Icons.numbers, "Series", widget.data.data["Series"], textColor: Colors.white70),
                  const SizedBox(height: 18),
                  _infoItem(Icons.work, "Workplace", widget.data.data["workplace"], textColor: Colors.lightGreenAccent),
                  const SizedBox(height: 18),
                  _infoItem(Icons.email, "Email", widget.data.data["email"], textColor: Colors.lightBlueAccent),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String label, String? value, {Color textColor = Colors.white}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.blueAccent, size: 26),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                value ?? '-',
                style: TextStyle(
                  fontSize: 18,
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
