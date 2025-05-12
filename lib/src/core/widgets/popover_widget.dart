import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

/// A simple data class representing an item in the popover or bottom-sheet menu.
class PopoverMenuItemData {
  /// The display name of the menu item.
  final String name;

  /// Optional icon to display alongside the name.
  final Widget? icon;

  /// The callback to invoke when this item is selected.
  final VoidCallback onTap;

  const PopoverMenuItemData({
    required this.name,
    this.icon,
    required this.onTap,
  });
}

/// A reusable widget for showing menu options either as a popover (desktop) or bottom-sheet (mobile).
/// Can be triggered by any widget, and includes convenience constructors.
class PopoverWidget extends StatelessWidget {
  /// The list of items to show in the menu.
  final List<PopoverMenuItemData> items;

  /// Optional header widget for the bottom sheet (mobile only).
  final Widget? bottomSheetHeader;

  /// The widget used to trigger the menu.
  final Widget trigger;

  /// Optional offset for positioning the popover relative to the trigger (desktop).
  final Offset offset;

  /// Whether to show a bottom-sheet instead of a popover.
  final bool? isMobile;

  /// Creates a menu widget with a custom trigger.
  const PopoverWidget({
    Key? key,
    required this.items,
    this.bottomSheetHeader,
    this.trigger = const Icon(Icons.more_vert),
    this.offset = const Offset(0, 40),
    this.isMobile,
  }) : super(key: key);

  /// Icon-triggered popover/bottom-sheet.
  static PopoverWidget icon({
    required List<PopoverMenuItemData> items,
    Widget icon = const Icon(Icons.more_vert),
    Offset offset = const Offset(0, 40),
    bool? isMobile,
    Widget? bottomSheetHeader,
  }) =>
      PopoverWidget(
        items: items,
        trigger: icon,
        offset: offset,
        isMobile: isMobile,
        bottomSheetHeader: bottomSheetHeader,
      );

  /// Styled button-triggered popover/bottom-sheet, using theme's primary color.
  static PopoverWidget button({
    required List<PopoverMenuItemData> items,
    required String label,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    BoxDecoration? decoration,
    Offset offset = const Offset(0, 40),
    bool? isMobile,
    Widget? bottomSheetHeader,
  }) =>
      PopoverWidget(
        items: items,
        offset: offset,
        isMobile: isMobile,
        bottomSheetHeader: bottomSheetHeader,
        trigger: Builder(
          builder: (context) {
            final primary = Theme.of(context).primaryColor;
            return Container(
              padding: padding ??
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              decoration: decoration ??
                  BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(4.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
              child: Text(
                label,
                style: textStyle ??
                    TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            );
          },
        ),
      );

  @override
  Widget build(BuildContext context) {
    final _isMobile = isMobile == null
        ? getValueForScreenType<bool>(
            context: context,
            mobile: true,
            tablet: false,
          )
        : isMobile as bool;
    if (_isMobile) {
      // On mobile, open a bottom sheet with optional header and options
      return GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            builder: (ctx) {
              return SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (bottomSheetHeader != null)
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 8),
                          child: bottomSheetHeader!),
                    ...items.map((item) {
                      return ListTile(
                        leading: item.icon,
                        title: Text(item.name),
                        onTap: () {
                          Navigator.of(ctx).pop();
                          item.onTap();
                        },
                      );
                    }).toList(),
                  ],
                ),
              );
            },
          );
        },
        child: trigger,
      );
    }
    // On desktop/web, use a popover menu with optional icons
    return PopupMenuButton<int>(
      offset: offset,
      onSelected: (index) => items[index].onTap(),
      itemBuilder: (context) => items
          .asMap()
          .entries
          .map((entry) => PopupMenuItem<int>(
                value: entry.key,
                child: Row(
                  children: [
                    if (entry.value.icon != null) ...[
                      entry.value.icon!,
                      const SizedBox(width: 8),
                    ],
                    Text(entry.value.name),
                  ],
                ),
              ))
          .toList(),
      child: trigger,
    );
  }
}
