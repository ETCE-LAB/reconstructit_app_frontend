import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/account/account_screen.dart';
import 'package:reconstructitapp/presentation/chat/chat_screen.dart';
import 'package:reconstructitapp/presentation/community/community_screen.dart';
import 'package:reconstructitapp/presentation/your_requests/your_requests_screen.dart';

import '../authentication/authentication_screen.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

class AuthenticationHomeScreen extends StatelessWidget {
  const AuthenticationHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthenticationScreen(
      onAuthenticated: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeIdle) {
          return Scaffold(
            bottomNavigationBar: NavigationBar(
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              selectedIndex: state.selectedPage,
              onDestinationSelected: _onPageChanged,
              destinations: [
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.handyman_outlined,
                    // color: context.primary,
                  ),
                  icon: Icon(
                    Icons.handyman_outlined,
                    // color: context.lightPrimary,
                  ),
                  label: "Helfen",
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.groups_outlined,
                    // color: context.primary,
                  ),
                  icon: Icon(
                    Icons.groups_outlined,
                    //  color: context.lightPrimary,
                  ),
                  label: "Reparatur",
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.chat_outlined,
                    //  color: context.primary
                  ),

                  icon: Icon(
                    Icons.chat_outlined,
                    //color: context.lightPrimary
                  ),

                  label: "Profil",
                ),
                NavigationDestination(
                  selectedIcon: Icon(
                    Icons.account_circle_outlined,
                    //  color: context.primary
                  ),
                  icon: Icon(
                    Icons.account_circle_outlined,
                    //  color: context.lightPrimary
                  ),
                  label: "Profil",
                ),
              ],
            ),
            body: SafeArea(
              child:
                  const [
                    YourRequestsScreen(),
                    CommunityScreen(),
                    ChatScreen(),
                    AccountScreen(),
                  ][state.selectedPage],
            ),
          );
        } else {
          // TODO: add splashscreen here
          return Container();
        }
      },
    );
  }

  void _onPageChanged(int index) {
    context.read<HomeBloc>().add(HomePageChanged(index));
  }
}
