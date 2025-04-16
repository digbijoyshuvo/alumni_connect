

import 'package:alumni_connect/data/database/user_information.dart';
import 'package:appwrite/appwrite.dart';

String databaseId = "67dd35380029a4eca560";
String eventCollectionID = "67faa877001f1066e150";


//Create New Event
Future<void> createEvent(
    String name,
    String description,
    String location,
    String guests,
    String sponsors,
    String datetime,
    )async{

  return databases.createDocument(
      databaseId: databaseId,
      collectionId: eventCollectionID,
      documentId: ID.unique(),
      data:{
        "name" : name,
        "description" : description,
        "location" : location,
        "special_guests" : guests,
        "sponsors" : sponsors,
        "date_time" : datetime,
      }).then((value) => print("Event Created"))
      .catchError((ex)=> print(ex));
}

//Read all created events

Future getAllEvents()async{
  try{
    final event = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: eventCollectionID);
    return event.documents;
  }catch(ex){
    print(ex);
  }
}