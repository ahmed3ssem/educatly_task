import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:educatly_task/core/utils/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Helper{

  static String getCurrentLocal(){
    String local = AppStrings.enCountryCode;
    final currentLocal = Get.locale;
    local = currentLocal!.countryCode!;
    return local;
  }

  static setDefaultLang(String lang) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(AppStrings.local, lang);
  }

  static getDefaultLanguage() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String language = AppStrings.enCountryCode;
    if(preferences.containsKey(AppStrings.local)){
      language = preferences.getString(AppStrings.local).toString();
    }
    if(language == AppStrings.enCountryCode){
      var locale = const Locale('en', 'US');
      Get.updateLocale(locale);
    } else {
      var locale = const Locale('ar', 'AR');
      Get.updateLocale(locale);
    }
  }

}