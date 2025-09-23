import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reconstructitapp/presentation/all_print_contracts/all_print_contracts_screen.dart';
import 'package:reconstructitapp/presentation/community/community_screen.dart';
import 'package:reconstructitapp/presentation/your_requests/your_requests_screen.dart';

import '../../utils/dependencies.dart';
import '../authentication/authentication_screen.dart';
import '../user/account_screen.dart';
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
    return BlocProvider(
      create: (_) => ic<HomeBloc>()..add(CheckIfProfileExists()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeIdle || state is HomeLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          } else if (state is HomeLoaded) {
            return Scaffold(
              bottomNavigationBar: NavigationBar(
                surfaceTintColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                selectedIndex: state.selectedPage,
                onDestinationSelected:
                    (index) => _onPageChanged(context, index),
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

                    label: "Vorgänge",
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
                      AllPrintContractsScreen(),
                      AccountScreen(),
                    ][state.selectedPage],
              ),
            );
          } else if (state is UserDoesNotExists) {
            return Scaffold(body: AccountScreen());
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _onPageChanged(BuildContext context, int index) {
    context.read<HomeBloc>().add(HomePageChanged(index));
  }
}
