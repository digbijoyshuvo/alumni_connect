import 'package:alumni_connect/data/database/tution_data.dart';
import 'package:alumni_connect/features/homepagefeatures/tuitionpage/update_tuition.dart';
import 'package:alumni_connect/theme/app_color.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

class EditTuition extends StatefulWidget {
  const EditTuition({super.key});

  @override
  State<EditTuition> createState() => _EditTuitionState();
}

class _EditTuitionState extends State<EditTuition> {
  List<Document> editTuition = [];
  bool isLoading = true;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    manageTuition().then((value) {
      editTuition = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Custom AppBar Style
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "Edit Your Tuition Offers",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),

          // Tuition Edit List
          Expanded(
            child: ListView.builder(
              itemCount: editTuition.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF1C1C1E), Color(0xFF2E2E2E)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      "Class : ${editTuition[index].data["class"]}\nSubjects : ${editTuition[index].data["subjects"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        "Location : ${editTuition[index].data["location"]}\nSalary : ${editTuition[index].data["salary"]}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateTuition(
                              Class: editTuition[index].data["class"],
                              subjects: editTuition[index].data["subjects"],
                              location: editTuition[index].data["location"],
                              salary: editTuition[index].data["salary"],
                              extraInfo: editTuition[index].data["extra_info"],
                              docId: editTuition[index].$id,
                            ),
                          ),
                        );
                        refresh();
                      },
                      icon: Icon(
                        Icons.edit,
                        color: AppColor.appColor,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
