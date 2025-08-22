import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:islamic_app/providers/login_provider.dart';
import 'package:islamic_app/providers/profilerepository_provider.dart';
import 'package:islamic_app/services/auth/delete_repository.dart';

final deleteRepositoryProvider = Provider<DeleteRepository>((ref) {
  return DeleteRepository();
});

class DeleteService {
  final Ref ref;
  DeleteService(this.ref);

  Future<void> deleteUser(String id) async {
    final success = await ref.read(deleteRepositoryProvider).deleteUser(id);

    if (success) {
      await ref.read(loginProvider.notifier).clearLocalToken();

      // clear data
      ref.invalidate(profileProvider);
      ref.invalidate(loginProvider);
    } else {
      throw Exception('Failed to delete user');
    }
  }
}

final deleteProvider = Provider<DeleteService>((ref) {
  return DeleteService(ref);
});
