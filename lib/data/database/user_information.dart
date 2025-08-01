
import 'package:alumni_connect/data/saved_data.dart';
import 'package:appwrite/appwrite.dart';
import '../auth/auth.dart';
import 'package:appwrite/models.dart' as models;


String databaseId = "67dd35380029a4eca560";
String userCollectionId = "67dd3547003348744b28";


final Databases databases = Databases(client);

// A function to Store the User Data in AppWrite Database

Future <void> saveUserData(String name, String email, String userId)async{
  return await databases.createDocument(
      databaseId: databaseId,
      collectionId: userCollectionId,
      documentId: ID.unique(),
      data: {
        "name" : name,
        "email" : email,
        "userId" : userId
      }).then((value) => print('Document Created'))
        .catchError((ex)=>print(ex));
}

//Get User Data From the appWrite Database

Future getUserData()async{
  final id = SavedData.getUserId();
  try{
    final data = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: userCollectionId,

        queries: [Query.equal("userId", id)]);
      SavedData.saveUserName(data.documents[0].data['name']);
    SavedData.saveUserEmail(data.documents[0].data['email']);

    print(data);
  }catch(ex){
    print(ex);
  }
}

// Create Alumni Information
Future<void> createAlumni(
    String name,
    String dept,
    String series,
    String location,
    String workplace,
    String facebookId,
    String email,
    String images,
    String createdBy,
    )async{
  return databases.createDocument(
      databaseId: databaseId,
      collectionId: "67df20c40034e8b0a9f5",
      documentId: ID.unique(),
      data: {
        "name" : name,
        "department" : dept,
        "Series" : series,
        "location" : location,
        "workplace" : workplace,
        "facebookId" : facebookId,
        "email" : email,
        "images" : images,
        "createdBy" : createdBy,
      }).then((value) => print("event created")).catchError((ex) => print(ex));
}

//Read All profiles from Our Database

Future getAllAlumni()async{
  try{
    final data = await databases.listDocuments(
        databaseId: databaseId,
        collectionId:"67df20c40034e8b0a9f5");
      return data.documents;
  }
  catch (ex){
    print(ex);
  }
}

// // Read the profile Created By a User
// Future manageAlumni()async{
//   final userId = SavedData.getUserId();
//   try{
//     final data = await databases.listDocuments(
//         databaseId: databaseId,
//         collectionId:"67df20c40034e8b0a9f5");
//     return data.documents;
//   }
//   catch (ex){
//     print(ex);
//   }
// }

Future<bool> hasUserCreatedAlumni() async {
  final userId = SavedData.getUserId(); // Get logged-in user's ID

  try {
    final data = await databases.listDocuments(
      databaseId: databaseId,
      collectionId: "67df20c40034e8b0a9f5",
      queries: [
        Query.equal("createdBy", userId), // Filter by createdBy attribute
      ],
    );

    return data.documents.isNotEmpty; // Returns true if at least one document exists
  } catch (ex) {
    print("Error fetching alumni data: $ex");
    return false; // If there's an error, assume no entry
  }
}

// get the alumni profile created by one user
Future alumniInfo() async{
  final userId = SavedData.getUserId();
  try{
    final data = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: "67df20c40034e8b0a9f5",
    queries:[
      Query.equal("createdBy", userId),],);
    return data.documents;
  }catch(ex){
    print(ex);
  }
}

// update the edited alumni information
Future<void> updateAlumni(
    String name,
    String dept,
    String series,
    String location,
    String workplace,
    String facebookId,
    String email,
    String images,
    String createdBy,
    String docId,
    )async{
  return databases.updateDocument(
      databaseId: databaseId,
      collectionId: "67df20c40034e8b0a9f5",
      documentId: docId,
      data: {
        "name" : name,
        "department" : dept,
        "Series" : series,
        "location" : location,
        "workplace" : workplace,
        "facebookId" : facebookId,
        "email" : email,
        "images" : images,
        "createdBy" : createdBy,
      }).then((value) => print("event updated")).catchError((ex) => print(ex));
}

// function for deleting event

 Future deleteAlumniInfo(String docId)async{
  try{
    final response = await databases.deleteDocument(
        databaseId: databaseId,
        collectionId:  "67df20c40034e8b0a9f5",
        documentId: docId);
    print(response);
  }catch(ex){
    print(ex);
  }
 }


  // search by a specific attribute in the database
Future searchLocationResult(
    String location,
    )async {
  try {
    final data = await databases.listDocuments(
      databaseId: databaseId,
      collectionId: "67df20c40034e8b0a9f5",
      queries: [
        Query.contains("location", location),
      ],);
    return data.documents;
  } catch (ex) {
    print(ex);
  }
}

Future searchBySeries(
    String series,
    )async{
  try{
    final data = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: "67df20c40034e8b0a9f5",
      queries: [
        Query.contains("Series", series),
      ],);
    return data.documents;
  }catch(ex){
    print(ex);
  }
 }


Future<List<models.Document>> searchByLocationAndName({
  required String? location,
  required String? workplace,
}) async {
  try {
    List<String> queries = [];

    if (location != null && location.isNotEmpty) {
      queries.add(Query.contains("location", location));
    }
    if (workplace != null && workplace.isNotEmpty) {
      queries.add(Query.contains("workplace", workplace));
    }

    if (queries.isEmpty) {
      return [];
    }

    final data = await databases.listDocuments(
      databaseId: databaseId,
      collectionId: "67df20c40034e8b0a9f5",
      queries: queries,
    );

    return data.documents;
  } catch (e) {
    print('Database search error: $e');
    return [];
  }
}
