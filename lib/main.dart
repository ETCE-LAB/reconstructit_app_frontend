import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/camera/camera_screen.dart';
import 'package:reconstructitapp/presentation/home/bloc/home_bloc.dart';
import 'package:reconstructitapp/presentation/start/initial_start_screen.dart';
import 'package:reconstructitapp/utils/dependencies.dart';
import 'package:reconstructitapp/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ic<HomeBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: lightTheme,
        darkTheme: darkTheme,
        home: InitialStartScreen(),
      ),
    );
  }
}
