import 'package:flutter/material.dart';

class BloodBankScreen extends StatelessWidget {
  const BloodBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ব্লাড ব্যাঙ্ক (খুলনা)',
          style: TextStyle(
            fontFamily: 'bangla',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  fillColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withAlpha(76),
                  filled: true,
                  hintText: 'ব্লাড গ্রুপ খুঁজুন',
                  prefixIcon: Icon(Icons.search),
                  hintStyle: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) => ListTile(
                leading: Icon(Icons.person_rounded),
                title: Text(
                  'তামজিদুল ইসলাম',
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'ফোনঃ 01700000001',
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.bloodtype, color: Colors.red),
                    const SizedBox(width: 5),
                    Text(
                      'B+',
                      style: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
