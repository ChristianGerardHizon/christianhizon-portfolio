import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/packages/pocketbase.dart';
import 'package:gym_system/src/core/widgets/app_snackbar.dart';
import 'package:gym_system/src/core/widgets/modals/confirm_modal.dart';
import 'package:gym_system/src/features/settings/data/setting_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DomainPage extends HookConsumerWidget {
  const DomainPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(settingRepositoryProvider);

    final textCtrl = useTextEditingController();

    useEffect(() {
      repo.get().run().then((result) {
        final settings = result.fold((l) => null, (r) => r);
        if (settings == null) return;
        final pb = ref.read(pocketbaseProvider);
        if (context.mounted) textCtrl.text = pb.baseURL;
      });
      return null;
    }, []);

    onSave() async {
      final isConfirmed = await ConfirmModal.show(context);
      if (isConfirmed != true) return;

      final text = textCtrl.text;
      // final

      final domain = Uri.tryParse(text);

      if (domain == null) {
        AppSnackBar.rootError(message: 'Not a valid url');
        return;
      }

      final result = await repo.update(domain: domain.toString()).run();
      result.fold(
        (l) => AppSnackBar.rootError(message: 'Failed to update url'),
        (r) => AppSnackBar.root(message: 'success'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Server'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          /// domain inputs
          TextField(
            controller: textCtrl,
            decoration: const InputDecoration(),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 50,
            child: FilledButton(onPressed: onSave, child: const Text('Save')),
          ),
        ],
      ),
    );
  }
}
