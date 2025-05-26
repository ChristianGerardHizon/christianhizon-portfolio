import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/widgets/pb_image_circle.dart';
import 'package:sannjosevet/src/features/authentication/presentation/controllers/auth_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccountCircleImage extends HookConsumerWidget {
  final int radius;
  final bool showName;
  const AccountCircleImage({
    super.key,
    this.radius = 60,
    this.showName = false,
  });

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
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: image,
                        ),
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
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
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
      data: (auth) {
        final avatar = auth.map<String?>(
          (u) => u.record.avatar,
          (a) => a.record.avatar,
        );

        final name = auth.map<String?>(
          (u) => u.record.name,
          (a) => a.record.name,
        );

        final id = auth.map<String>(
          (u) => u.record.id,
          (a) => a.record.id,
        );

        final collection = auth.map<String>(
          (u) => u.collectionId,
          (a) => a.collectionId,
        );

        final type = auth.map<String>(
          (u) => 'Staff',
          (a) => 'Admin',
        );

        return buildName(
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Theme.of(context).colorScheme.primary,
              ),
              shape: BoxShape.circle,
            ),
            child: PbImageCircle(
              file: avatar,
              recordId: id,
              collection: collection,
              radius: 40,
              viewable: false,
            ),
          ),
          name: name.optional(),
          showName: showName,
          type: type,
        );
      },
      error: (error, stackTrace) => const Text('Error loading user'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
