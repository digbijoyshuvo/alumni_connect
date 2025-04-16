import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children:[ Container(
                 height: size.height *0.3,
                  width: double.infinity,
                  child:  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.darken),
                    child: Image.asset("assets/images/About_US.jpg",
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
                  top: 15,
                    left: size.width*0.35,
                    child: Text("About US",style: TextStyle(fontSize: size.height*0.04,fontWeight: FontWeight.w600,color: Colors.red.shade300),),
                  )
                ]
              ),
              SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text("Welcome to Campus Connect — your bridge between the present and the past of your campus community!",
                   style: TextStyle(fontWeight: FontWeight.w400,fontSize: size.height*0.02,color: Colors.lightGreen),),
                SizedBox(height: 10,),

                Text("Our mission is to help students and alumni stay connected, share opportunities, and build a stronger network beyond graduation.",
                  style: TextStyle(fontWeight: FontWeight.w400,fontSize: size.height*0.02),),
                SizedBox(height: 30,),

                Text("What We Offer",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20,color: Colors.blueAccent),),
                SizedBox(height: 10,),
                    ListTile(
                      title: Text("Alumni Account Management",style: TextStyle(color: Colors.orangeAccent),),
                      subtitle: Text("Alumni can easily create, update, and manage their profiles to stay connected with their campus family."),
                    ),
                    SizedBox(height: 8,),
                    ListTile(
                      title: Text("Student-Alumni Search",style: TextStyle(color: Colors.orangeAccent),),
                      subtitle: Text("Students can search for alumni based on department, location, or profession and reach out for guidance, mentorship, or career advice."),
                    ),
                    SizedBox(height: 8,),
                    ListTile(
                      title: Text("Tuition Offers Section",style: TextStyle(color: Colors.orangeAccent),),
                      subtitle: Text("Students can post tuition offers and find tutoring opportunities shared by others within the community."),
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}