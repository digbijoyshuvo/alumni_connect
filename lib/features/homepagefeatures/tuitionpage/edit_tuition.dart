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

  List<Document> editTuition =[];
  bool isLoading =true;

  @override
  void initState(){
    refresh();
    super.initState();
  }
  void refresh(){
    manageTuition().then((value) {
      editTuition = value;
      isLoading =false;
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       title: Text("Edit Your Tuition Offers"),
     ),
      body: ListView.builder(
        itemCount: editTuition.length,
          itemBuilder: (context,index) =>
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title:Text("Class : ${editTuition[index].data["class"]}\nSubjects : ${editTuition[index].data["subjects"]}",) ,
                    subtitle: Text("Location : ${editTuition[index].data["location"]}\nSalary : ${editTuition[index].data["salary"]}"),
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>
                                UpdateTuition(
                                  Class: editTuition[index].data["class"],
                                  subjects: editTuition[index].data["subjects"],
                                  location: editTuition[index].data["location"],
                                  salary: editTuition[index].data["salary"],
                                  extraInfo: editTuition[index]
                                      .data["extra_info"],
                                  docId: editTuition[index].$id,
                                )));
                        refresh();
                      },
                      icon:Icon(
                      Icons.edit,
                      color: AppColor.appColor,
                      size: 30,),),
                  ),
                ),
              ),
        
      ),
    );
  }
}
