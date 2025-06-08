import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reconstructitapp/presentation/community/community_body.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Communityanfragen"), centerTitle: true,), body: CommunityBody());
  }
}
