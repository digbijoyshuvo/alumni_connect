import 'package:alumni_connect/theme/app_color.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class AlumniInformation extends StatefulWidget {
  final Document data;
  const AlumniInformation({super.key,required this.data});

  @override
  State<AlumniInformation> createState() => _AlumniInformationState();
}

class _AlumniInformationState extends State<AlumniInformation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                  height: 250,
                  width: double.infinity,
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.darken),
                    child: Image.network("https://cloud.appwrite.io/v1/storage/buckets/67df2c36003a14b7edef/files/${widget.data.data["images"]}/view?project=67dc74870003bb181f04",
                    fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 15,
                  child: IconButton(onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back,size: 30,)),
                ),
                  Positioned(
                    bottom: 45,
                    left: 5,
                    child: Text("${widget.data.data["name"]}",style: TextStyle(
                      fontSize: 25,fontWeight: FontWeight.bold
                    ),),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 5,
                    child: Text("${widget.data.data["workplace"]}",style: TextStyle(
                      fontSize: 18,
                    ),),
                  ),
                  Positioned(
                    bottom: 5,
                    left: 3,
                    child: Row(
                      children: [
                        Icon(Icons.location_on,size: 13,
                        ),
                        SizedBox(width: 3,),
                        Text("${widget.data.data["location"]}",style: TextStyle(
                          fontSize: 13
                        ),)
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                      right: 15,
                      child: Link(
                        uri: Uri.parse("${widget.data.data["facebookId"]}"),
                          builder: (context,followLink)
                           => GestureDetector(
                             onTap: followLink,
                               child: Icon(Icons.facebook,size: 35,)))
          
                  ),
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget.data.data["name"]}",style: TextStyle(
                      fontSize: 30,fontWeight: FontWeight.bold
                    ),),
                    SizedBox(height: 8,),
                    Text("Department : ${widget.data.data["department"]}",style: TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w700
                    ),),
                    SizedBox(height: 8,),
                    Text("Series : ${widget.data.data["Series"]}",style: TextStyle(
                        fontSize: 23, fontWeight: FontWeight.w700
                    ),),
                    SizedBox(height: 8,),
                    Text("${widget.data.data["workplace"]}",style: TextStyle(
                        fontSize: 23, fontWeight: FontWeight.w700,color: Colors.lightGreen,
                    ),),
                    SizedBox(height: 8,),
                    Text("Current Location : ${widget.data.data["location"]}",style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400
                    ),),
                    SizedBox(height: 8,),
                    Text("Email : ${widget.data.data["email"]}",style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w300,color: Colors.blueAccent
                    ),),
                    SizedBox(height: 8,),
          
          
                  ],
                ),
              )
            ],
          ),
        ),
    );
  }
}
