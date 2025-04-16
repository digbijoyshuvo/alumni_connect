import 'package:alumni_connect/data/database/tution_data.dart';
import 'package:alumni_connect/routes/route_names.dart';
import 'package:alumni_connect/theme/app_color.dart';
import 'package:alumni_connect/widgets/custom_snackbar.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/app_string.dart';

class TuitionPage extends StatefulWidget {
  const TuitionPage({super.key});

  @override
  State<TuitionPage> createState() => _TuitionPageState();
}

class _TuitionPageState extends State<TuitionPage> {
  List<Document> tuition = [];
  @override
  void initState(){
      refresh();
    super.initState();
  }
  void refresh(){
    getAllTuition().then((value) {
      tuition = value;
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[800],
    appBar:  AppBar(
      title: Text("Available Tuition's",style: TextStyle(fontWeight: FontWeight.w600),),
    ),
    body :CustomScrollView(
      slivers: [
        SliverList(delegate: SliverChildBuilderDelegate((context,index)=>Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => CustomSnackBar.showSuccess(context, "Please Go to Profile And Delete or Update the Tuition"),
            child: Card(
              color: Color(0xff141A31),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tuition No :  ${index+1}\n",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18,color: Colors.amberAccent),),
                    Text("Subjects : ${tuition[index].data["subjects"]}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.blueAccent),),
                    Text("Location : ${tuition[index].data["location"]}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.greenAccent),),
                    Text("Salary : ${tuition[index].data["salary"]}" ,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.lightGreen),),
                    Text("${tuition[index].data["extra_info"]}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),),
                  ],
                ),
              ),
            ),
          ),
        ),
          childCount: tuition.length,
        ),)
      ],
    ),
        floatingActionButton: FloatingActionButton(onPressed: ()async{
        await context.pushNamed(RouteNames.addTuition);
        refresh();
    },
    backgroundColor: AppColor.appColor,
      child: Icon(Icons.add),
    ),
    );

  }
}
