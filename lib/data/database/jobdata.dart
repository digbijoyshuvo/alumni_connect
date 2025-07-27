

import 'package:alumni_connect/data/database/user_information.dart';
import 'package:appwrite/appwrite.dart';

String databaseId = "67dd35380029a4eca560";
String jobOfferId = "68869b9400061e4f30dc";

Future<void> addJobOffer(
    String jobTitle,
    String jobDescription,
    String salary,
    String location,
    String contactInfo,
    String email,
    String companyName,
    String createdBy,
) async {
  return databases.createDocument(
      databaseId: databaseId,
      collectionId: jobOfferId,
      documentId: ID.unique(),
      data: {
        "title": jobTitle,
        "description": jobDescription,
        "salary": salary,
        "location": location,
        "contactInfo": contactInfo,
        "email": email,
        "company": companyName,
        "createdBy": createdBy,
      }).then((value) => print("Job Offer added"))
      .catchError((ex) => print(ex));
}