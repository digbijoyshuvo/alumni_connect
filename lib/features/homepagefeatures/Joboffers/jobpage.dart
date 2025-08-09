import 'package:alumni_connect/data/database/jobdata.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class JobPage extends StatefulWidget {
  const JobPage({super.key});

  @override
  State<JobPage> createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  List<Document> jobOffers = [];
  String userId = "";

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    getAllJobOffers().then((value) {
      jobOffers = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Column(
        children: [
          // Top Bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF2C2C54),
                  Color(0xFF3A3A80)
                ], // Darker colors here
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SafeArea(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Back Button aligned left
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          size: 26, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  // Title perfectly centered
                  const Text(
                    "Available Job's",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.1,
                      shadows: [
                        Shadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 2)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Job Cards
          Expanded(
            child: ListView.builder(
              itemCount: jobOffers.length,
              itemBuilder: (context, index) {
                final job = jobOffers[index];

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E2E),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ========== Heading ==========
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.white24, width: 1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Job No
                            Text(
                              "Job No : ${index + 1}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // Job Title
                            Text(
                              job.data['title'] ?? 'Job Title N/A',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ========== Body ==========
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Job Description
                          const Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyanAccent,
                            ),
                          ),
                          Text(
                            job.data['description'] ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Company
                          const Text(
                            "Company",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.greenAccent,
                            ),
                          ),
                          Text(
                            job.data['company'] ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Location
                          const Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.greenAccent,
                            ),
                          ),
                          Text(
                            job.data['location'] ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Salary
                          const Text(
                            "Starting Salary",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent,
                            ),
                          ),
                          Text(
                            job.data['salary'] ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      // ========== Footer ==========
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "<<<<--For any query contact us-->>>>",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Phone
                          InkWell(
                            onTap: () {
                              final phone = job.data['contactInfo'] ?? '';
                              if (phone.isNotEmpty) {
                                launchUrl(Uri.parse('tel:$phone'));
                              }
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.phone,
                                    color: Colors.orangeAccent),
                                const SizedBox(width: 8),
                                Text(
                                  job.data['contactInfo'] ?? 'No phone',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Email
                          InkWell(
                            onTap: () {
                              final email = job.data['email'] ?? '';
                              if (email.isNotEmpty) {
                                launchUrl(Uri.parse('mailto:$email'));
                              }
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.email,
                                    color: Colors.lightBlueAccent),
                                const SizedBox(width: 8),
                                Text(
                                  job.data['email'] ?? 'No email',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Drop CV
                          Center(
                            child: const Text(
                              "<<<--Drop your CV-->>>",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyanAccent,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          InkWell(
                            onTap: () {
                              final email = job.data['email'] ?? '';
                              if (email.isNotEmpty) {
                                launchUrl(Uri.parse('mailto:$email'));
                              }
                            },
                            child: Row(
                              children: [
                                const Icon(Icons.email,
                                    color: Colors.lightBlueAccent),
                                const SizedBox(width: 8),
                                Text(
                                  job.data['email'] ?? 'No email',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
