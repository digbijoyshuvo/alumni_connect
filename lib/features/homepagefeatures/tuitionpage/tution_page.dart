import 'package:alumni_connect/data/database/tution_data.dart';
import 'package:alumni_connect/routes/route_names.dart';
import 'package:alumni_connect/theme/app_color.dart';
import 'package:alumni_connect/widgets/custom_snackbar.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class TuitionPage extends StatefulWidget {
  const TuitionPage({super.key});

  @override
  State<TuitionPage> createState() => _TuitionPageState();
}

class _TuitionPageState extends State<TuitionPage> {
  List<Document> tuition = [];
  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    getAllTuition().then((value) {
      tuition = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Column(
        children: [
          // Custom AppBar Style
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3A1C71), Color(0xFFD76D77), Color(0xFFFFAF7B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 8,),
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      "Available Tuition's",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 30),
              ],
            ),

          ),
          SizedBox(height: 20,),
          // Tuition List
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: () {
                          final phoneNumber = tuition[index].data["contactInfo"];
                          final contactEmail = tuition[index].data["contactEmail"] ?? ""; // Optional field

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: const Color(0xff1F2B44),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                title: const Text(
                                  "Contact to get the Tuition?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: Text(
                                  "Call or mail the person directly.",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),
                                actions: [
                                  // Left Side Icons
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Phone and Mail
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.phone, color: Colors.greenAccent),
                                            tooltip: 'Call',
                                            onPressed: () async {
                                              final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
                                              if (await canLaunchUrl(phoneUri)) {
                                                await launchUrl(phoneUri);
                                              } else {
                                                CustomSnackBar.showError(context, "Can't Open the Phone");
                                              }
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.email, color: Colors.lightBlueAccent),
                                            tooltip: 'Email',
                                            onPressed: () async {
                                              if (contactEmail.isNotEmpty) {
                                                final Uri emailUri = Uri(
                                                  scheme: 'mailto',
                                                  path: contactEmail,
                                                  query: Uri.encodeFull("subject=Tuition Inquiry"),
                                                );
                                                if (await canLaunchUrl(emailUri)) {
                                                  await launchUrl(emailUri);
                                                } else {
                                                 CustomSnackBar.showError(context, "Can't Open the email");
                                                }
                                              } else {
                                               CustomSnackBar.showInfo(context, "No Email address Provided");
                                              }
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),

                                      // Right Side Close
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor: AppColor.errorColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text(
                                          "Close",
                                          style: TextStyle(
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff141A31), Color(0xff1F2B44)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 6,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Tuition No :  ${index + 1}\n",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.amberAccent,
                                  ),
                                ),
                                Text(
                                  "Class : ${tuition[index].data["class"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                Text(
                                  "Subjects : ${tuition[index].data["subjects"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                                Text(
                                  "Location : ${tuition[index].data["location"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.greenAccent,
                                  ),
                                ),
                                Text(
                                  "Salary : ${tuition[index].data["salary"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                                Text(
                                  "Phone No : ${tuition[index].data["contactInfo"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.orangeAccent,
                                  ),
                                ),
                                Text(
                                  "Email Address : ${tuition[index].data["contactEmail"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.limeAccent,
                                  ),
                                ),
                                Text(
                                  "${tuition[index].data["extra_info"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    childCount: tuition.length,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await context.pushNamed(RouteNames.addTuition);
          if (result == true) {
            refresh();
          }
        },
        backgroundColor: AppColor.appColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
