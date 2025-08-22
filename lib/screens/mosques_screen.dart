import 'package:flutter/material.dart';
import 'package:islamic_app/components/mosques_items.dart';
import 'package:islamic_app/models/dummy_models/mosques.dart';
import 'package:islamic_app/screens/mosques_detail_screen.dart';

class MosquesScreen extends StatelessWidget {
  const MosquesScreen({super.key, required this.mosques});

  final List<Mosques> mosques;

  void selectedMosque(BuildContext context, Mosques mosque) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => MosquesDetailScreen(mosque: mosque)),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'Nothing to show here! Choose another',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: Text('খুলনার মসজিদ')),
      body: mosques.isEmpty
          ? content
          : ListView.builder(
              itemCount: mosques.length,
              itemBuilder: (ctx, index) => MosquesItems(
                mosque: mosques[index],
                onSelectMosque: (mosque) => selectedMosque(context, mosque),
              ),
            ),
    );
  }
}
