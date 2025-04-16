import 'package:alumni_connect/data/database/user_information.dart';
import 'package:alumni_connect/data/saved_data.dart';
import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('https://cloud.appwrite.io/v1')
    .setProject('67dc74870003bb181f04')
    .setSelfSigned(status: true);
Account account = Account(client);

// Register User
Future<String> createUser(String name,String email,String password)async {

  try {
    final user = await account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name
    );
    saveUserData(name, email, user.$id);
    return "success";
  }on AppwriteException catch(ex){
    return ex.message.toString();
  }
}

// Login User

Future loginUser(String email, String password)async{
  try{
    final user = await account.createEmailPasswordSession(
        email: email,
        password: password);
      getUserData();
     SavedData.saveUserId(user.userId);
        return true;
  }on AppwriteException catch (ex){
    return false;
  }
}

//Logout Logic
Future logoutUser()async{
  await account.deleteSession(sessionId: "current");
}

// check if user has active session or not
Future ckeckSessions()async{
  try{
    await account.getSession(sessionId: "current");
    return true;
  }catch(ex){
    return false;
  }
}