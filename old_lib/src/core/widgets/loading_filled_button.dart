import 'package:flutter/material.dart';

class LoadingFilledButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  final bool isLoading;
  final bool showText;

  const LoadingFilledButton({
    super.key,
    this.onPressed,
    required this.isLoading,
    this.child,
    this.showText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: FilledButton(
        style: ButtonStyle(backgroundColor: WidgetStateProperty.all(null)),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    (child != null && showText)
                        ? Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: child,
                          )
                        : const SizedBox(),
                  ],
                ),
              )
            : child,
      ),
    );
  }
}
