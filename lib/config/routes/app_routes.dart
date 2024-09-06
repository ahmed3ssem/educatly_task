import 'package:educatly_task/feature/chat/presentation/screen/chat_screen.dart';
import 'package:educatly_task/feature/home/presentation/screen/home_Screen.dart';
import 'package:educatly_task/feature/login/presentation/screen/login_screen.dart';
import 'package:educatly_task/feature/signup/presentation/screen/signup_screen.dart';
import 'package:educatly_task/feature/splash/presentation/screen/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes{

  static const String initialRoutes = '/';

  static const String login = 'Login';

  static const String signup = 'SignUp';

  static const String chat = 'Chat';

  static const String home = 'Home';

}

class AppRoutes{

  static Route? onGenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case Routes.initialRoutes:
        return MaterialPageRoute(builder: (context) {
          return const SplashScreen();
        });
      case Routes.login:
        return MaterialPageRoute(builder: (context) {
          return const LoginScreen();
        });
      case Routes.signup:
        return MaterialPageRoute(builder: (context) {
          return const SignUpScreen();
        });
      case Routes.chat:
        return MaterialPageRoute(builder: (context) {
          return const ChatScreen();
        });
      case Routes.home:
        return MaterialPageRoute(builder: (context) {
          return const HomeScreen();
        });
      default:
        return null;
    }
  }
}