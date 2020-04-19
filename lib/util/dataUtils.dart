

import 'package:shared_preferences/shared_preferences.dart';

class DataUtils {
  static final String SP_phoneNumber = "sp_phonenumber";
  static final String SP_password = "sp_password";

  static savePhoneNumber(String number) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(SP_phoneNumber, number);
  }

  static getPhoneNumber() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString(SP_phoneNumber);
  }

  static savePassword(String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(SP_password, password);
  }

  static getPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.getString(SP_password);
  }

}