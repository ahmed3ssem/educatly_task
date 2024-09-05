import 'package:get/get.dart';

class LocalStrings extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar_AR': {
      "noData":"لا يوجد بيانات",

    },
    'en_US': {
      "noData":"There is no data",
      "accountCreatedSuccessfully":"Account Created Successfully",
      "email":"E-Mail",
      "password":"Password",
      "pleaseEnterYourEmail":"Please enter your email",
      "pleaseEnterYourPassword":"Please enter your password",
      "login":"Login",
      "dontHaveAnAccount":"Don't have an account? ",
      "signUp":"Sign Up",
      "pleaseEnterAValidEmailAddress":"Please enter a valid email address",
      "passwordMustBeAtLeastCharactersLong":"Password must be at least 6 characters long",
      "confirmPassword":"Confirm Password",
      "passwordsDoNotMatch":"Passwords do not match"

    },
  };
}