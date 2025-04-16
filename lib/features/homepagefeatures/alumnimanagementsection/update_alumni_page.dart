import 'package:alumni_connect/features/homepagefeatures/alumnimanagementsection/edit_page.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import '../../../data/database/user_information.dart';
import 'alumni_container.dart';

class UpdateAlumniPage extends StatefulWidget {
  const UpdateAlumniPage({super.key});

  @override
  State<UpdateAlumniPage> createState() => _UpdateAlumniPageState();
}

class _UpdateAlumniPageState extends State<UpdateAlumniPage> {
  List<Document> createdAlumniInfo = [];
  bool isLoading = true;

  @override
  void initState() {
    refresh();
    super.initState();
  }

  void refresh() {
    alumniInfo().then((value) {
      createdAlumniInfo = value;
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final paddingValue = size.width * 0.05; // Responsive padding

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: paddingValue,
                  vertical: size.height * 0.4,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditPage(
                            name: createdAlumniInfo[index].data["name"],
                            dept: createdAlumniInfo[index].data["department"],
                            Series: createdAlumniInfo[index].data["Series"],
                            location: createdAlumniInfo[index].data["location"],
                            workplace: createdAlumniInfo[index].data["workplace"],
                            facebookId: createdAlumniInfo[index].data["facebookId"],
                            email: createdAlumniInfo[index].data["email"],
                            images: createdAlumniInfo[index].data["images"],
                            docId: createdAlumniInfo[index].$id,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Dear,",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${createdAlumniInfo[index].data["name"]},",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightGreen,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "If you are sure to update your information then tap here.",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              childCount: createdAlumniInfo.length,
            ),
          ),
        ],
      ),
    );
  }
}
