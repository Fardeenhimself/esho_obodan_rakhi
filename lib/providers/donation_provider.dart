import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/services/core/donation_repository.dart';

class DonationState {
  final bool isLoading;
  final String? error;
  final bool success;

  DonationState({this.isLoading = false, this.error, this.success = false});

  DonationState copyWith({bool? isLoading, String? error, bool? success}) {
    return DonationState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success ?? this.success,
    );
  }
}

class DonationNotifier extends StateNotifier<DonationState> {
  final DonationRepository _repo;
  DonationNotifier(this._repo) : super(DonationState());

  Future<void> donate({required double amount, String? reason}) async {
    state = state.copyWith(isLoading: true, error: null, success: false);

    try {
      await _repo.makeDonation(amount: amount, reason: reason);
      state = state.copyWith(isLoading: false, success: true);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Reset the provider state to default
  void reset() {
    state = DonationState();
  }
}

final donationRepositoryProvider = Provider((ref) => DonationRepository());
final donationProvider = StateNotifierProvider<DonationNotifier, DonationState>(
  (ref) {
    return DonationNotifier((ref.read(donationRepositoryProvider)));
  },
);

final userDonationProvider = FutureProvider<List<Map<String, dynamic>>>((
  ref,
) async {
  final repo = ref.read(donationRepositoryProvider);
  return repo.getUserDonation();
});
