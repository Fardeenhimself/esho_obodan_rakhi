// import 'package:flutter/material.dart';
// import 'package:islamic_app/components/data_container.dart';
// import 'package:islamic_app/components/my_drawer.dart';
// import 'package:islamic_app/screens/make_donation_screen.dart';

// class DonationScreen extends StatelessWidget {
//   const DonationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('D O N A T I O N S')),
//       drawer: MyDrawer(),
//       body: Column(
//         children: [
//           // STATIC CONTAINER
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
//             child: DataContainer(),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         backgroundColor: Theme.of(context).colorScheme.primaryContainer,
//         elevation: 6,
//         splashColor: Theme.of(context).colorScheme.onTertiary,
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (ctx) => MakeDonationScreen())
//           );
//         },
//         label: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             'Become a donor',
//             style: Theme.of(context).textTheme.labelLarge!.copyWith(
//               fontWeight: FontWeight.bold,
//               color: Theme.of(context).colorScheme.tertiary,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/components/data_container.dart';
import 'package:islamic_app/components/my_drawer.dart';
import 'package:islamic_app/screens/donation_success_page.dart';
import '../providers/donation_provider.dart';

class DonationScreen extends ConsumerWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _showDonationForm() {
      final _formKey = GlobalKey<FormState>();
      final _amountController = TextEditingController();
      final _reasonController = TextEditingController();

      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: Consumer(
              builder: (context, ref, _) {
                final donationState = ref.watch(donationProvider);

                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  Text(
                                    '"দান করতে দেরি করো না, কারণ এটি বিপদ আপদকে প্রতিহত করে"',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.tertiary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    '~সুনানে তিরমিজি',
                                    textAlign: TextAlign.left,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.tertiary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            TextFormField(
                              autocorrect: false,
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: "পরিমাণ",
                                hintText: '৳',
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              validator: (val) => val == null || val.isEmpty
                                  ? "Enter amount"
                                  : null,
                            ),
                            TextFormField(
                              autocorrect: false,
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimaryContainer,
                              ),
                              maxLength: 50,
                              controller: _reasonController,
                              decoration: InputDecoration(
                                labelText: "উদ্দেশ্য",
                                hintText: 'কেনো দিচ্ছেন লিখুন',
                                focusColor: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                              ),
                            ),
                            const SizedBox(height: 20),
                            donationState.isLoading
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(
                                        context,
                                      ).colorScheme.primaryContainer,
                                      foregroundColor: Theme.of(
                                        context,
                                      ).colorScheme.tertiary,
                                    ),
                                    onPressed: () async {
                                      if (!_formKey.currentState!.validate())
                                        return;

                                      final amount = double.parse(
                                        _amountController.text,
                                      );

                                      await ref
                                          .read(donationProvider.notifier)
                                          .donate(
                                            amount: amount,
                                            reason: _reasonController.text,
                                          );

                                      // success ? navigate -> successpage
                                      if (ref.read(donationProvider).success) {
                                        Navigator.of(
                                          context,
                                        ).pop(); // close modal
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const DonationSuccessScreen(),
                                          ),
                                        );

                                        // reset form
                                        ref
                                            .read(donationProvider.notifier)
                                            .reset();
                                      }
                                    },
                                    child: Text(
                                      "অনুদান করুন",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onPrimaryContainer,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                            if (donationState.error != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  donationState.error!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                );
              },
            ),
          );
        },
      ).whenComplete(() {
        // Reset provider state and dispose controllers when sheet closes
        ref.read(donationProvider.notifier).reset();
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text("D O N A T I O N S")),
      drawer: MyDrawer(),
      body: Column(
        children: [
          // STATIC CONTAINER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            child: DataContainer(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showDonationForm,
        label: Text(
          "অনুদান করুন",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
