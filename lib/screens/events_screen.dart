import 'package:flutter/material.dart';
import 'package:islamic_app/components/my_drawer.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('A L L  E V E N T S')),
      drawer: MyDrawer(),
      body: Center(child: Text('EVENTS SCREEN')),
    );
  }
}
