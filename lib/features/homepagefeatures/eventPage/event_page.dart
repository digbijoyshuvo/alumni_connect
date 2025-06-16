import 'package:alumni_connect/data/database/event_database.dart';
import 'package:alumni_connect/features/homepagefeatures/eventPage/event_container.dart';
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
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF003300), Color(0xFF00A152)],
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
              "Upcoming Events",
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
      body:CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildBuilderDelegate((context,index)
          =>EventContainer(data: events[index]),
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
        backgroundColor: Colors.greenAccent,
        child: Icon(Icons.add,color:Colors.black,),
      ) ,
    );
  }
}