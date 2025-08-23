import 'package:flutter/material.dart';

class DataContainer extends StatelessWidget {
  const DataContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(
          context,
        ).colorScheme.primaryContainer.withAlpha((0.5 * 255).round()),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Icon(
                  Icons.people_alt,
                  size: 30,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(height: 10),
                Text(
                  '১৫+',
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'সক্রিয় দাতা',
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                Icon(
                  Icons.volunteer_activism,
                  size: 30,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(height: 10),
                Text(
                  '৬+',
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'অনুদান সম্পন্ন',
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 20),
            Column(
              children: [
                Icon(
                  Icons.attach_money,
                  size: 30,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(height: 10),
                Text(
                  '১৬০০০+',
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 22,
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'তহবিল সংগ্রহ',
                  style: TextStyle(
                    fontFamily: 'bangla',
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
