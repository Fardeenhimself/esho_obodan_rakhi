import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/components/data_container.dart';
import 'package:islamic_app/components/donation_campaign.dart';
import 'package:islamic_app/components/my_drawer.dart';
import 'package:islamic_app/providers/donation_category_provider.dart';
import 'package:islamic_app/screens/donation_success_page.dart';
import '../providers/donation_provider.dart';

class DonationScreen extends ConsumerWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(donationCategoryProvider);

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
                                    style: TextStyle(
                                      fontFamily: 'bangla',
                                      fontSize: 18,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.tertiary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '~সুনানে তিরমিজি',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'bangla',
                                      fontSize: 16,
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
                                labelStyle: TextStyle(
                                  fontFamily: 'bangla',
                                  fontSize: 16,
                                ),
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
                                labelStyle: TextStyle(
                                  fontFamily: 'bangla',
                                  fontSize: 16,
                                ),
                                hintText: 'কেনো দিচ্ছেন লিখুন',
                                hintStyle: TextStyle(
                                  fontFamily: 'bangla',
                                  fontSize: 14,
                                ),
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
                                      // refresh the ui for new donation
                                      ref.refresh(userDonationProvider);
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
                                      style: TextStyle(
                                        fontFamily: 'bangla',
                                        fontSize: 18,
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
          const Divider(indent: 50, endIndent: 50),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'আমাদের কেম্পেইন',
              style: TextStyle(
                fontFamily: 'bangla',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),

          // campaigns
          Expanded(
            child: categoriesAsync.when(
              data: (categories) {
                if (categories.isEmpty) {
                  return const Center(child: Text('No campaign availabel'));
                }
                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (ctx, index) {
                    return DonationCampaign(category: categories[index]);
                  },
                );
              },
              loading: () => const Center(child: CupertinoActivityIndicator()),
              error: (e, text) => Center(child: Text('Failed to fetch: $e')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showDonationForm,
        label: Text(
          "অনুদান করুন",
          style: TextStyle(
            fontFamily: 'bangla',
            fontSize: 18,
            color: Theme.of(context).colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
