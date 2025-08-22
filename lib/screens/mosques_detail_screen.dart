import 'package:flutter/material.dart';
import 'package:islamic_app/models/dummy_models/mosques.dart';

class MosquesDetailScreen extends StatelessWidget {
  const MosquesDetailScreen({super.key, required this.mosque});

  final Mosques mosque;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(mosque.name)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                Image.asset(
                  mosque.imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mosque.name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(mosque.address),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(mosque.starIcon),
                          const SizedBox(width: 6),
                          Text(mosque.rating),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
