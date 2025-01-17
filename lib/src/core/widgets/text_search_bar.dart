import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TextSearchBar extends HookWidget {
  final TextEditingController controller;

  final Function()? onSubmit;
  final Function()? onSearch;
  final Function()? onClear;

  const TextSearchBar({
    super.key,
    required this.controller,
    this.onSubmit,
    this.onSearch,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final isEmpty = useState<bool>(controller.text.isEmpty);

    useEffect(() {
      controller.addListener(() {
        isEmpty.value = controller.text.isEmpty;
      });
      return null;
    });

    return Padding(
      padding: EdgeInsets.all(8),
      child: TextField(
        onSubmitted: (x) {
          controller.clear();
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
          fillColor: Theme.of(context).primaryColor.withValues(alpha: .1),
          filled: true,
        ),
      ),
    );
  }
}
