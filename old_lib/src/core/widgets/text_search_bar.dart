import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:responsive_builder/responsive_builder.dart';

class TextSearchBar extends HookWidget {
  final TextEditingController controller;

  final Function()? onSubmit;
  final Function()? onSearch;
  final Function()? onClear;
  final Function()? onCreate;

  const TextSearchBar({
    super.key,
    required this.controller,
    this.onSubmit,
    this.onSearch,
    this.onClear,
    this.onCreate,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = useState<bool>(controller.text.isEmpty);

    useEffect(() {
      controller.addListener(() {
        if (context.mounted) isEmpty.value = controller.text.isEmpty;
      });
      return null;
    });

    return Padding(
      padding: EdgeInsets.all(8),
      child: ResponsiveBuilder(builder: (context, si) {
        return Row(
          children: [
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextField(
                  onSubmitted: (x) {
                    onSearch?.call();
                  },
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: (!isEmpty.value)
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              FilledButton(
                                child: Text('Search'),
                                onPressed: onSearch,
                              ),
                              SizedBox(width: 8),
                              TextButton(
                                child: Text('Clear'),
                                onPressed: onClear,
                              ),
                              SizedBox(width: 8),
                            ],
                          )
                        : null,
                    hintText: 'Search term here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Theme.of(context)
                        .dividerTheme
                        .color
                        ?.withValues(alpha: .8),
                    filled: true,
                  ),
                ),
              ),
            ),
            if (onCreate != null) ...[
              if (!si.isMobile)
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 300, minWidth: 100),
                  child: SizedBox(
                    height: 45,
                    child: FilledButton.tonalIcon(
                      onPressed: onCreate,
                      icon: Icon(MIcons.plus),
                      label: Text('New Record'),
                    ),
                  ),
                ),
              if (si.isMobile)
                SizedBox(
                  height: 45,
                  width: 45,
                  child: IconButton.filledTonal(
                    onPressed: onCreate,
                    icon: Icon(MIcons.plus),
                    // label: Text('Create'),
                  ),
                ),
            ]
          ],
        );
      }),
    );
  }
}
