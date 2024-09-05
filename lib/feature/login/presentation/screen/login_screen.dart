import 'package:educatly_task/config/routes/app_routes.dart';
import 'package:educatly_task/core/utils/app_colors.dart';
import 'package:educatly_task/core/utils/assets_manager.dart';
import 'package:educatly_task/core/utils/size_utils.dart';
import 'package:educatly_task/feature/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget checkState(LoginState state){
    if(state is LoginIsLoading){
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    } else if(state is LoginError){
      return loginWidget();
    } else if(state is LoginLoaded) {
      return loginWidget();
    } else {
      return loginWidget();
    }
  }

  Widget loginWidget(){
    return Padding(
      padding: EdgeInsets.all(16.0.adaptSize),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetsManager.logo,
                height: 120.h,
                width: 120.w,
              ),
              SizedBox(height: 40.h),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: "email".tr,
                        prefixIcon: const Icon(Icons.email , color: AppColors.mainColor,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: AppColors.whiteColor,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'pleaseEnterYourEmail'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "password".tr,
                        prefixIcon: const Icon(Icons.lock , color: AppColors.mainColor,),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: AppColors.whiteColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'pleaseEnterYourPassword'.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      width: double.infinity,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginCubit>().login(_emailController.value.text.toString(), _passwordController.value.text.toString() , context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: AppColors.mainColor,
                        ),
                        child: Text(
                          'login'.tr,
                          style: TextStyle(fontSize: 18.fSize , color: AppColors.whiteColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, Routes.signup),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "dontHaveAnAccount".tr,
                              style: TextStyle(
                                fontSize: 16.0.fSize,
                                fontWeight: FontWeight.w400,
                                color: AppColors.darkGrey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pushNamed(context, Routes.signup),
                              child: Text(
                                'signUp'.tr,
                                style: TextStyle(
                                  fontSize: 16.0.fSize,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor, // Use your theme's primary color
                                  decoration: TextDecoration.underline, // Underline for emphasis
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<LoginCubit , LoginState>(builder: (context , state){
      return Scaffold(
          body: checkState(state)
      );
    });
  }
}
