import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sannjosevet/src/core/assets/assets.gen.dart';
import 'package:sannjosevet/src/core/packages/pocketbase.dart';

class Logo extends ConsumerWidget {
  final EdgeInsets padding;
  final double? width;
  final double? height;

  const Logo({
    super.key,
    this.padding = const EdgeInsets.all(10),
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: padding,
      child: DecoratedBox(
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.black),
            ),
        child: Builder(
          builder: (context) => SizedBox(
            width: width,
            height: height,
            child: Builder(builder: (context) {
              if (ref.watch(pbDebugControllerProvider).value ?? false)
                // if (false)
                // ignore: dead_code
                return Placeholder(
                  fallbackHeight: height ?? 400,
                  fallbackWidth: width ?? 400,
                  child: Center(
                    child: Text(
                      'Developer Mode',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                  ),
                );

              return Assets.icons.appIconTransparent.image(
                fit: BoxFit.fill,
              );
            }),
          ),
        ),
      ),
    );
  }
}
