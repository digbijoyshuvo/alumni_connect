import 'package:alumni_connect/features/homepagefeatures/alumnimanagementsection/edit_page.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import '../../../data/database/user_information.dart';

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
    final paddingValue = size.width * 0.05;

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : createdAlumniInfo.isEmpty
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 60, color: Colors.redAccent),
              const SizedBox(height: 20),
              const Text(
                "No alumni information found.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: Colors.redAccent),
              ),
              const SizedBox(height: 8),
              const Text(
                "Please create your profile to appear here.",
                style: TextStyle(fontSize: 16, color: Colors.lightGreen),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text("Go Back"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB71C1C),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
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
