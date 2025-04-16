import 'package:shared_preferences/shared_preferences.dart';

class SavedData{
  static SharedPreferences? preferences;
  static Future<void> init()async{
    preferences = await SharedPreferences.getInstance();
  }
  // save user ID on device
  static Future<void> saveUserId(String id)async{
    await preferences!.setString("userId", id);
  }

//   get User ID
  static String getUserId(){
    return preferences!.getString("userId")??"";
  }

//   save User Name
  static Future<void> saveUserName(String name)async{
    await preferences!.setString("name", name);
  }

//  get User Name
  static String getUserName(){
    return preferences!.getString("name")??"";
  }


//   save User Email
  static Future<void> saveUserEmail(String email)async{
    await preferences!.setString("email", email);
  }

//  get User Email
  static String getUserEmail(){
    return preferences!.getString("email")??"";
  }

}