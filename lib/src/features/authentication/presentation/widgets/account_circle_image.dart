import 'package:flutter/material.dart';
import 'package:gym_system/src/features/admins/presentation/widgets/admin_circle_image.dart';
import 'package:gym_system/src/features/authentication/domain/auth_admin.dart';
import 'package:gym_system/src/features/authentication/domain/auth_user.dart';
import 'package:gym_system/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:gym_system/src/features/users/presentation/widgets/user_circle_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountCircleImage extends HookConsumerWidget {
  final int radius;
  final bool showName;
  const AccountCircleImage(
      {super.key, this.radius = 60, this.showName = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);

    Widget buildName(
      Widget image, {
      required String name,
      bool showName = false,
    }) {
      if (showName == false) return image;

      return Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Row(
          children: [
            image,
            SizedBox(width: 12),
            Text(name),
          ],
        ),
      );
    }

    return state.when(
      data: (user) {
        if (user is AuthUser) {
          return buildName(
            UserCircleImage(
                isInteractable: false, user: user.record, radius: radius),
            name: user.record.name,
            showName: showName,
          );
        }

        if (user is AuthAdmin) {
          return buildName(
            Container(
              height: (radius * 1.5).toDouble(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  width: 4,
                ),
              ),
              child: AdminCircleImage(admin: user.record, radius: radius),
            ),
            name: user.record.name,
            showName: showName,
          );
        }

        return SizedBox();
      },
      error: (error, stackTrace) => const Text('Error loading user'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
