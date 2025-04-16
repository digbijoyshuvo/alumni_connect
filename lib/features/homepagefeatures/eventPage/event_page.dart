import 'package:alumni_connect/data/database/event_database.dart';
import 'package:alumni_connect/routes/route_names.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  
  List<Document> events = [];


  @override
  void initState(){
    refresh();
    super.initState();
  }

  void refresh(){
    getAllEvents().then((value) {
      events = value;
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // backgroundColor: Colors.greenAccent,
          title: Text("Upcoming Events",style: TextStyle(fontWeight: FontWeight.w600),)),
      body:CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildBuilderDelegate((context,index) => Padding(
        padding: const EdgeInsets.all(8),
            child: ListTile(

              title: Text(events[index].data["name"],
                style:TextStyle(color: Colors.lightGreenAccent,fontSize: 20) ,),
              subtitle: Text(events[index].data["location"],
                style:TextStyle(color: Colors.greenAccent,fontSize: 15) ,),
            ),

          ),
            childCount: events.length,
          ),)
        ],
      ),
      floatingActionButton:FloatingActionButton(
          onPressed:()async{
            await
            context.pushNamed(RouteNames.checkPermission);
            refresh();
          },
        child: Icon(Icons.add,color:Colors.black,),
        backgroundColor: Colors.lightGreen,
      ) ,
    );
  }
}