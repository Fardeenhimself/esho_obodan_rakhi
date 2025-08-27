import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/components/data_container.dart';
import 'package:islamic_app/components/donation_campaign.dart';
import 'package:islamic_app/components/my_drawer.dart';
import 'package:islamic_app/providers/donation_category_provider.dart';
import 'package:islamic_app/providers/login_provider.dart';
import 'package:islamic_app/screens/donation_success_page.dart';
import '../providers/donation_provider.dart';

class DonationScreen extends ConsumerWidget {
  const DonationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(donationCategoryProvider);
    final user = ref.watch(loginProvider);

    // form for admin
    void _showAdminAddCampaignDialog(BuildContext context, WidgetRef ref) {
      final _formKey = GlobalKey<FormState>();
      final _nameController = TextEditingController();
      final _targetController = TextEditingController();

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text(
            "ক্যাম্পেইন এ্যাড করুন",
            style: TextStyle(fontFamily: 'bangla'),
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "ক্যাম্পেইন নাম",
                    labelStyle: TextStyle(fontFamily: 'bangla', fontSize: 16),
                  ),
                  validator: (val) =>
                      val == null || val.isEmpty ? "নাম লিখুন" : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _targetController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "টার্গেট পরিমাণ",
                    labelStyle: TextStyle(fontFamily: 'bangla', fontSize: 16),
                  ),
                  validator: (val) =>
                      val == null || val.isEmpty ? "টার্গেট লিখুন" : null,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text(
                "বাতিল",
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (!_formKey.currentState!.validate()) return;
                final name = _nameController.text;
                final target = double.parse(_targetController.text);

                try {
                  await ref
                      .read(donationCategoryRepositoryProvider)
                      .addCategoryTarget(name: name, target: target.toString());

                  ref.refresh(donationCategoryProvider);
                  Navigator.of(ctx).pop();
                } catch (e) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Failed: $e")));
                }
              },
              child: const Text(
                "সাবমিট",
                style: TextStyle(
                  fontFamily: 'bangla',
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // form for user
    void _showDonationForm() {
      final _formKey = GlobalKey<FormState>();
      final _amountController = TextEditingController();
      String? selectedCampaignId;

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
                final categoriesAsync = ref.watch(donationCategoryProvider);

                return categoriesAsync.when(
                  data: (categories) {
                    // Filter campaigns that have remaining > 0
                    final availableCampaigns = categories
                        .where((c) => c.remaining > 0)
                        .toList();

                    if (availableCampaigns.isEmpty) {
                      return Center(
                        child: Text(
                          "দুঃখিত, এখন কোন ক্যাম্পেইন উপলব্ধ নেই।",
                          style: TextStyle(fontFamily: 'bangla', fontSize: 16),
                        ),
                      );
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                Text(
                                  '"দান করতে দেরি করো না, কারণ এটি বিপদ আপদকে প্রতিহত করে"',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'bangla',
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.tertiary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '~সুনানে তিরমিজি',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'bangla',
                                    fontSize: 16,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.tertiary,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  child: DropdownButtonFormField<String>(
                                    borderRadius: BorderRadius.circular(12),
                                    value: selectedCampaignId,
                                    isExpanded: true,
                                    decoration: const InputDecoration(
                                      labelText: "ক্যাম্পেইন নির্বাচন করুন",
                                      labelStyle: TextStyle(
                                        fontFamily: 'bangla',
                                      ),
                                    ),
                                    items: availableCampaigns.map((c) {
                                      return DropdownMenuItem<String>(
                                        value: c.id,
                                        child: Text(
                                          c.name,
                                          style: TextStyle(
                                            fontFamily: 'bangla',
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (val) =>
                                        selectedCampaignId = val,
                                    validator: (val) => val == null
                                        ? "একটি ক্যাম্পেইন সিলেক্ট করুন"
                                        : null,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                TextFormField(
                                  controller: _amountController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    labelText: "পরিমাণ",
                                    hintText: "৳",
                                    labelStyle: TextStyle(fontFamily: 'bangla'),
                                  ),
                                  validator: (val) => val == null || val.isEmpty
                                      ? "পরিমাণ লিখুন"
                                      : null,
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
                                          ).colorScheme.onPrimaryContainer,
                                        ),
                                        onPressed: () async {
                                          if (!_formKey.currentState!
                                              .validate())
                                            return;

                                          final amount = double.parse(
                                            _amountController.text,
                                          );
                                          try {
                                            await ref
                                                .read(donationProvider.notifier)
                                                .donate(
                                                  catId: selectedCampaignId!,
                                                  amount: amount,
                                                );

                                            final state = ref.read(
                                              donationProvider,
                                            );

                                            if (state.success) {
                                              Navigator.of(context).pop();
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      const DonationSuccessScreen(),
                                                ),
                                              );
                                            } else if (state.error != null) {
                                              showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                  title: const Text(
                                                    "দ্রষ্টব্য",
                                                  ),
                                                  content: Text(state.error!),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(
                                                            context,
                                                          ).pop(),
                                                      child: const Text(
                                                        "ঠিক আছে",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          } catch (e) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text("Error: $e"),
                                              ),
                                            );
                                          }

                                          ref
                                              .read(donationProvider.notifier)
                                              .reset();
                                        },
                                        child: const Text(
                                          "অনুদান করুন",
                                          style: TextStyle(
                                            fontFamily: 'bangla',
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  error: (e, _) => Center(child: Text("Error: $e")),
                );
              },
            ),
          );
        },
      ).whenComplete(() {
        ref.read(donationProvider.notifier).reset();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "অনুদান সমুহ",
          style: TextStyle(
            fontFamily: 'bangla',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: user.role == 'admin'
            ? [
                IconButton(
                  onPressed: () => _showAdminAddCampaignDialog(context, ref),
                  icon: Icon(Icons.add, size: 30),
                ),
              ]
            : null,
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
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
            categoriesAsync.when(
              data: (categories) {
                if (categories.isEmpty) {
                  return const Center(child: Text('No campaign availabel'));
                }
                return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (ctx, index) {
                    return DonationCampaign(category: categories[index]);
                  },
                );
              },
              loading: () => const Center(child: CupertinoActivityIndicator()),
              error: (e, text) => Center(child: Text('Failed to fetch: $e')),
            ),
          ],
        ),
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
