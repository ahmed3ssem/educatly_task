import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'bloc_observer.dart';
import 'config/PrefHelper/prefs.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAtCmyW6yiLmFB0PqAM-04P4Z5m00oE9R4',
        appId: 'id',
        messagingSenderId: 'sendid',
        projectId: 'educatly-47487',
        storageBucket: 'myapp-b9yt18.appspot.com',
      )
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  await Prefs.init();
  await di.init();
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

