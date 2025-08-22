import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/donation_provider.dart';

class MakeDonationScreen extends ConsumerStatefulWidget {
  const MakeDonationScreen({super.key});

  @override
  ConsumerState<MakeDonationScreen> createState() => _MakeDonationScreenState();
}

class _MakeDonationScreenState extends ConsumerState<MakeDonationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _reasonController = TextEditingController();
  bool _showForm = false;

  @override
  void dispose() {
    _amountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _submitDonation() async {
    if (!_formKey.currentState!.validate()) return;

    final amount = double.tryParse(_amountController.text);
    if (amount == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Invalid amount")));
      return;
    }
    await ref
        .read(donationProvider.notifier)
        .donate(amount: amount, reason: _reasonController.text);
  }

  @override
  Widget build(BuildContext context) {
    final donationState = ref.watch(donationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Donation")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (!_showForm)
              ElevatedButton(
                onPressed: () => setState(() => _showForm = true),
                child: const Text("Become a Donor"),
              ),

            if (_showForm)
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(labelText: "Amount"),
                      keyboardType: TextInputType.number,
                      validator: (val) =>
                          val == null || val.isEmpty ? "Enter amount" : null,
                    ),
                    TextFormField(
                      controller: _reasonController,
                      decoration: const InputDecoration(
                        labelText: "Reason (optional)",
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Show loading or button
                    donationState.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _submitDonation,
                            child: const Text("Donate"),
                          ),

                    // Error message
                    if (donationState.error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          donationState.error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),

                    // Success message
                    if (donationState.success)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: const Text(
                          "✅ Donation successful!",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
