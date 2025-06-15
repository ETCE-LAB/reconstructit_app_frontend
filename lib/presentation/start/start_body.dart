import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/home/home_screen.dart';
import 'package:reconstructitapp/presentation/start/start_body_widget.dart';

import 'bloc/initial_bloc.dart';
import 'bloc/initial_event.dart';

class StartBody extends StatefulWidget {
  const StartBody({super.key});

  @override
  State<StartBody> createState() => _StartBodyState();
}

class _StartBodyState extends State<StartBody> with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Herzlich Willkommen!"), centerTitle: true),
      body: PageView(
        controller: _pageViewController,
        children: [
          StartBodyWidget(
            index: 0,
            imagePath: "assets/start_1.png",
            description: "Erhalte Konstruktionsdateien für fehlende Bauteile",
            onPressed: _startApp,
            updateIndex: _updateCurrentPageIndex,
          ),
          StartBodyWidget(
            index: 1,
            imagePath: "assets/start_2.png",
            description:
                "Keinen 3D Drucker? Frage die Community dein Ersatzteil zu drucken!",
            onPressed: _startApp,
            updateIndex: _updateCurrentPageIndex,
          ),
          StartBodyWidget(
            index: 2,
            imagePath: "assets/start_3.png",
            description:
                "Du hast einen 3D Drucker? Helfe anderen ihre Gegenstände zu reparieren indem du Druckanfragen animmst!",
            onPressed: _startApp,
            updateIndex: _updateCurrentPageIndex,
          ),
          StartBodyWidget(
            index: 3,
            imagePath: "assets/start_4.png",
            description:
                "Chattet miteinander und einigt euch auf einen Preis und Versandart!",
            onPressed: _startApp,
            updateIndex: _updateCurrentPageIndex,
          ),
        ],
      ),
    );
  }

  void _startApp(){
    context.read<InitialBloc>().add(
      FinishedIntroduction(),
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthenticationHomeScreen(),
      ),
    );
  }

  void _updateCurrentPageIndex(int index) {
    setState(() {
      _tabController.index = index;
    });

    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
