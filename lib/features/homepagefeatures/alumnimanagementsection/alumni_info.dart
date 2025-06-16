import 'package:alumni_connect/data/database/user_information.dart';
import 'package:alumni_connect/features/homepagefeatures/alumnimanagementsection/alumni_container.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

class AlumniInfo extends StatefulWidget {
  const AlumniInfo({super.key});

  @override
  State<AlumniInfo> createState() => _AlumniInfoState();
}

class _AlumniInfoState extends State<AlumniInfo> {
  List<Document> alumniInfo = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getAllAlumni().then((value) {
      alumniInfo = value;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3E1E68), Color(0xFF222222)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            title: const Text(
              "Alumni Details",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.purpleAccent))
          : Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10
        ),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return AnimatedOpacity(
                    opacity: 1,
                    duration: Duration(milliseconds: 300 + index * 100),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: AlumniContainer(data: alumniInfo[index]),
                    ),
                  );
                },
                childCount: alumniInfo.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
