import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

setDataToLocalStorage({
  @required String? dataType,
  @required String? storageKey,
  bool? boolData,
  double? doubleData,
  int? integerData,
  String? stringData,
  List<String>? listOfStringData,
}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  switch (dataType) {
    case "BOOL":
      return sharedPreferences.setBool(storageKey!, boolData!);
    case "DOUBLE":
      return sharedPreferences.setDouble(storageKey!, doubleData!);
    case "INTEGER":
      return sharedPreferences.setInt(storageKey!, integerData!);
    case "STRING":
      return stringData != null ? sharedPreferences.setString(storageKey!, stringData) : "";
    case "LIST-OF-STRING":
      return sharedPreferences.setStringList(storageKey!, listOfStringData!);
    default:
      return null;
  }
}

getDataFromLocalStorage({
  @required String? dataType,
  @required String? storageKey,
}) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  switch (dataType) {
    case "BOOL":
      return sharedPreferences.getBool(storageKey!);
    case "DOUBLE":
      return sharedPreferences.getDouble(storageKey!);
    case "INTEGER":
      return sharedPreferences.getInt(storageKey!);
    case "STRING":
      return sharedPreferences.getString(storageKey!);
    case "LIST-OF-STRING":
      return sharedPreferences.getStringList(storageKey!);
    default:
      return null;
  }
}

Future clearLocalStorage() async {

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.clear();
  return true;
}
