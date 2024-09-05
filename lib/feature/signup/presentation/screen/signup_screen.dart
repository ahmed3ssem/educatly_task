import 'package:educatly_task/core/utils/app_colors.dart';
import 'package:educatly_task/core/utils/assets_manager.dart';
import 'package:educatly_task/core/utils/size_utils.dart';
import 'package:educatly_task/feature/signup/presentation/cubit/signup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget checkState(SignupState state){
    if(state is SignUpIsLoading){
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    } else if(state is SignUpError){
      return signUpWidget();
    } else if(state is SignUpLoaded) {
      return signUpWidget();
    } else {
      return signUpWidget();
    }
  }

  Widget signUpWidget(){
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.adaptSize),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                AssetsManager.logo,
                height: 120.h,
              ),
              SizedBox(height: 40.h),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'email'.tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.email , color: AppColors.mainColor,),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'pleaseEnterYourEmail'.tr;
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'pleaseEnterAValidEmailAddress'.tr;
                  }
                  return null;
                },
              ), 
              SizedBox(height: 20.h),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'password'.tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const Icon(Icons.lock , color: AppColors.mainColor,),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,color: AppColors.mainColor,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'pleaseEnterYourPassword'.tr;
                  } else if (value.length < 6) {
                    return 'passwordMustBeAtLeastCharactersLong'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'confirmPassword'.tr,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: const  Icon(Icons.lock , color: AppColors.mainColor,),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off, color: AppColors.mainColor,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'passwordsDoNotMatch'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.h),
              ElevatedButton(
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    context.read<SignupCubit>().signup(_emailController.value.text.toString(), _passwordController.value.text.toString() , context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: AppColors.mainColor,
                ),
                child: Text('signUp'.tr , style: const TextStyle(color: AppColors.whiteColor),),
              ), 
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<SignupCubit , SignupState>(builder: (context , state){
      return Scaffold(
          body: checkState(state)
      );
    });
  }
}
