

import 'package:alumni_connect/data/database/user_information.dart';

String databaseId = "67dd35380029a4eca560";
String resourceCollectionID = "6872c6bf00269e552b7a";

Future getAllResources() async{
  try{
    final resource = await databases.listDocuments(
        databaseId: databaseId,
        collectionId: resourceCollectionID);
    return resource.documents;
  }
  catch(ex){
    print(ex);
  }
}