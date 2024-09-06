import 'dart:async';

import 'package:educatly_task/config/PrefHelper/prefs.dart';
import 'package:educatly_task/config/arguments/routes_arguments.dart';
import 'package:educatly_task/config/routes/app_routes.dart';
import 'package:educatly_task/core/utils/app_colors.dart';
import 'package:educatly_task/core/utils/size_utils.dart';
import 'package:educatly_task/feature/home/data/models/home_model.dart';
import 'package:educatly_task/feature/home/presentation/cubit/home_cubit.dart';
import 'package:educatly_task/feature/home/presentation/widgets/user_widget.dart';
import 'package:educatly_task/widgets/empty_data_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData()=>context.read<HomeCubit>().getAllUsers();

  Widget checkState(HomeState state){
    if(state is HomeIsLoading){
      return const Center(child: CircularProgressIndicator(color: AppColors.mainColor,),);
    } else if(state is HomeError){
      return const EmptyDataWidget();
    } else if(state is HomeLoaded) {
      return homeWidget(state.homeModel);
    } else {
      return const SizedBox();
    }
  }

  Future<void> logout() async{
    await FirebaseAuth.instance.signOut();
    Prefs.clear();
    Navigator.of(context).pushNamedAndRemoveUntil(Routes.login, (Route<dynamic> route) => false);
  }

  Widget homeWidget(List<HomeModel> model){
    return ListView.builder(
      itemCount: model.length ,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: ()=>Navigator.pushNamed(context , Routes.chat , arguments: ChatArguments(receiverId: model[index].uid , email: model[index].email) ),
          child: UserListItem(image: '',email: model[index].email,),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeCubit , HomeState>(builder: (context , state){
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            InkWell(
              onTap: logout,
              child: Container(
                margin: EdgeInsets.only(right: 10.w),
                child: Icon(Icons.logout , color: AppColors.whiteColor, size: 25.fSize,),
              ),
            )
          ],
        ),
          body: checkState(state)
      );
    });
  }
}
