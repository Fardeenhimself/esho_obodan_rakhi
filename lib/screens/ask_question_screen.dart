import 'package:flutter/material.dart';

class AskQuestionScreen extends StatelessWidget {
  const AskQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ASK A QUESTIOn')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(title: Text('Question ${index + 1}'), onTap: () {});
        },
      ),
    );
  }
}
