import 'package:alumni_connect/data/database/user_information.dart';
import 'package:alumni_connect/data/saved_data.dart';
import 'package:appwrite/appwrite.dart';

String databaseId = "67dd35380029a4eca560";
String tuitionId = "67e3247a000e0b95bac0";

// Add Tuition

Future<void> addTuition(
    String Class,
    String subjects,
    String salary,
    String extraInfo,
    String location,
    String contactInfo,
    String createdBy,
    ) async{
  return databases.createDocument(databaseId: databaseId,
      collectionId: tuitionId,
      documentId: ID.unique(),
      data: {
        "class" : Class,
        "subjects" : subjects,
        "salary" : salary,
        "extra_info" : extraInfo,
        "location" : location,
        "contactInfo" : contactInfo,
        "createdBy" : createdBy,
  }).then((value) => print("Tuition added"))
      .catchError((ex) => print(ex));
}

//Read Tuition
Future getAllTuition() async{
  try{
    final data = await databases.listDocuments(
        databaseId: databaseId, collectionId: tuitionId);
    return data.documents;
  } catch(ex){
    print(ex);
  }
}

//get All Tuition Created By the User
Future manageTuition() async{
  final userId = SavedData.getUserId();
  try{
    final data = await databases.listDocuments(
        databaseId: databaseId, collectionId: tuitionId,
    queries: [Query.equal("createdBy", userId)]);
    return data.documents;
  } catch(ex){
    print(ex);
  }
}

//Update the event Created by a User

Future<void> updateTuition(
    String Class,
    String subjects,
    String salary,
    String extraInfo,
    String location,
    String contactInfo,
    String createdBy,
    String docId,
    ) async{
  return databases.updateDocument(databaseId: databaseId,
      collectionId: tuitionId,
      documentId: docId,
      data: {
        "class" : Class,
        "subjects" : subjects,
        "salary" : salary,
        "extra_info" : extraInfo,
        "location" : location,
        "contactInfo" : contactInfo,
        "createdBy" : createdBy,
      }).then((value) => print("Tuition Updated"))
      .catchError((ex) => print(ex));
}

//Deleting a tuition offer
Future deleteTuition(String docId)async{
  try{
    final response = await databases.deleteDocument(
        databaseId: databaseId,
        collectionId: tuitionId, documentId: docId);
    print(response);
  }
  catch(ex){
    print(ex);
  }
}