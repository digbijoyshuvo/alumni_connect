import 'package:alumni_connect/data/database/user_information.dart';
import 'package:alumni_connect/features/homepagefeatures/alumnimanagementsection/alumni_container.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AlumniDirectory extends StatefulWidget {
  const AlumniDirectory({super.key});

  @override
  State<AlumniDirectory> createState() => _AlumniDirectoryState();
}

class _AlumniDirectoryState extends State<AlumniDirectory> {
  List<Document> alumni_info = [];
  @override
  void initState() {
    getAllAlumni().then((value) {
      alumni_info=value;
      setState(() {

      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Alumni Directory",style: TextStyle(fontWeight: FontWeight.w600),),
        // backgroundColor: Colors.cyan.shade300,
      ),
      body:
      CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildBuilderDelegate((context,index) =>AlumniContainer(
              data: alumni_info[index]),
              childCount: alumni_info.length
        //   ListTile(
        //     onTap: () => Navigator.push(
        // context,MaterialPageRoute(builder:
        //         (context) => AlumniInformation(
        //             data: alumni_info[index])
        //     )),
        //     title: Text(alumni_info[index].data["name"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        //     subtitle: Text(alumni_info[index].data["department"]),
        //   ),

          ),)
        ],
      )
    );
  }
}