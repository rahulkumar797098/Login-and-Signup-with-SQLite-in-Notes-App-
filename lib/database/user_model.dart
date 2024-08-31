import 'package:notes/database/app_data_base.dart';

class UserModel {
  int uId ;
  String uName ;
  String uEmail ;
  String uNumber ;
  String uPassword ;


  UserModel(
  {
    required this.uId ,
    required this.uEmail ,
    required this.uNumber ,
    required this.uName ,
    required this.uPassword ,});


  /// From map

factory UserModel.fromMap(Map<String , dynamic> map) {
  return UserModel(
      uId: map[AppDataBase.COLUMN_USER_ID],
      uEmail: map[AppDataBase.COLUMN_USER_EMAIL],
      uNumber: map[AppDataBase.COLUMN_USER_NUMBER],
      uName: map[AppDataBase.COLUMN_USER_NAME],
      uPassword: map[AppDataBase.COLUMN_USER_PASSWORD] ,) ;
}

Map<String , dynamic> toMap(){
  return {
    AppDataBase.COLUMN_USER_NAME : uName ,
    AppDataBase.COLUMN_USER_EMAIL : uEmail ,
    AppDataBase.COLUMN_USER_NUMBER : uNumber ,
    AppDataBase.COLUMN_USER_PASSWORD : uPassword ,
  } ;
}


}