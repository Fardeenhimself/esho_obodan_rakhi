import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('N O T I F I C A T I O N S')),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Notification from ${index + 1}'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {},
          );
        },
      ),
    );
  }
}
