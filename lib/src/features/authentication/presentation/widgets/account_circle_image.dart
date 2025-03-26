import 'package:flutter/material.dart';
import 'package:gym_system/src/core/extensions/string.dart';
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
      String? type,
    }) {
      if (showName == false) return image;

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double availableWidth = constraints.maxWidth;

            // Minimum width required for the name and SizedBox to fit
            double imageWidth = radius * 2;
            double requiredWidth = imageWidth + 12 + 127;

            ///
            /// i did this so that when avatar is transitioning the name wont cause error to layout
            /// so when sidemenu is not yet fully open or does not fit the content just return the image
            ///
            if (showName && availableWidth <= requiredWidth)
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: image,
              );

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: availableWidth >= requiredWidth
                    ? [
                        image,
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 110),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name.optional(placeholder: '-'),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                              if (type != null)
                                Text(
                                  type,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                )
                            ],
                          ),
                        )
                      ]
                    : [image],
              ),
            );
          },
        ),
      );
    }

    return state.when(
      data: (user) {
        if (user is AuthUser) {
          return buildName(
            Container(
              height: (radius * 1.5).toDouble(),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondary,
                  width: 4,
                ),
              ),
              child: UserCircleImage(
                  isInteractable: false, user: user.record, radius: radius),
            ),
            name: user.record.name,
            showName: showName,
            type: 'Staff',
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
                child: AdminCircleImage(
                    isInteractable: false, admin: user.record, radius: radius),
              ),
              name: user.record.name,
              showName: showName,
              type: 'Admin');
        }

        return SizedBox();
      },
      error: (error, stackTrace) => const Text('Error loading user'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
