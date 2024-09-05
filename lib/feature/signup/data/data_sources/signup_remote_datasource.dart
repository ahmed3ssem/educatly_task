import 'package:flutter/cupertino.dart';

abstract class SignUpRemoteDatasource{

  Future<void> signup(String email , String password , BuildContext context);

  Future<void> saveUserInfo(String email , String image , userId);
}