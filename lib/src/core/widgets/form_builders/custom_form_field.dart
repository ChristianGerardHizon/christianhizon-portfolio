import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/loaders/loading_details_tiles.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:searchfield/searchfield.dart'
    show
        SearchField,
        SearchFieldListItem,
        SearchInputDecoration,
        SuggestionDecoration;

class CustomSearchFormField<T> extends HookConsumerWidget {
  final String name;
  final bool enabled;
  final Function(T?)? onChanged;
  final Future<List<T>> Function(String?) onSearch;
  final String? hint;
  final Duration debounce;
  final dynamic Function(T?)? valueTransformer;
  final (String, Widget) Function(T) onChild;
  final Widget Function(T, TextEditingController, FormField) selectedBuilder;
  final InputDecoration decoration;
  final bool showAll;
  final List<T>? initialList;
  final String? Function(T?)? validator;
  final bool? filled;

  const CustomSearchFormField({
    super.key,
    this.validator,
    this.initialList,
    this.decoration = const InputDecoration(),
    this.enabled = true,
    this.valueTransformer,
    required this.selectedBuilder,
    required this.name,
    this.filled,
    this.onChanged,
    this.showAll = false,
    required this.onSearch,
    required this.onChild,
    this.hint,
    this.debounce = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focus = useFocusNode();

    final results = useState<List<T>?>(initialList);
    final isLoading = useState<bool>(false);
    final debounceValue = useRef<Timer?>(null);
    final textCtrl = useTextEditingController();

    final suggestionDecoration = SuggestionDecoration(
      elevation: 1,
      color: Theme.of(context).cardColor,
      shadowColor: Theme.of(context).shadowColor,
      borderRadius: BorderRadius.circular(8),
      padding: const EdgeInsets.all(8),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).shadowColor,
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    );

    ///
    ///
    ///
    Future<void> startSearch(String query) async {
      if (!showAll && query.isEmpty) {
        results.value = null;
        return;
      }
      isLoading.value = true;

      final result = await TaskResult.tryCatch(
        () => onSearch(query),
        Failure.presentation,
      ).run();

      result.fold((l) {}, (r) {
        results.value = r;
      });
      isLoading.value = false;
    }

    void onSearchChanged(String query) {
      // Cancel the previous timer if it's active.
      if (debounceValue.value?.isActive ?? false) {
        debounceValue.value!.cancel();
      }
      // Start a new timer that triggers the search after 500ms.
      debounceValue.value = Timer(debounce, () {
        startSearch(query);
      });
    }

    // Clean up the timer when the widget is disposed.
    useEffect(() {
      return () {
        debounceValue.value?.cancel();
      };
    }, []);

    return FormBuilderField(
      name: name,
      valueTransformer: valueTransformer,
      validator: validator,
      onChanged: (value) {
        if (value is T) {
          onChanged?.call(value);
        }
        if (value == '' || value == null) {
          onSearchChanged('');
        }
      },
      builder: (field) {
        final list = results.value;
        final value = field.value;
        final widget = field.widget;
        final errorText = field.errorText;
        final theme = Theme.of(context);

        final errorColor = theme.colorScheme.error;
        final border = field.hasError == true
            ? Border.all(color: theme.colorScheme.error)
            : Border.all(color: theme.dividerColor);
        return Column(
          children: [
            if (value is T) selectedBuilder.call(value, textCtrl, widget),
            Offstage(
              offstage: value != null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SearchField<T>(
                    controller: textCtrl,
                    hint: hint,
                    focusNode: focus,
                    onTapOutside: (p0) {
                      focus.unfocus();
                    },
                    searchInputDecoration: SearchInputDecoration(
                      border: OutlineInputBorder(),
                      filled: filled,
                      errorText: field.errorText,
                      fillColor:
                          Theme.of(context).colorScheme.surfaceContainerLow,
                    ),
                    suggestions: (list ?? []).whereType<T>().map((item) {
                      final result = onChild.call(item);
                      return SearchFieldListItem<T>(
                        result.$1,
                        child: result.$2,
                        item: item,
                      );
                    }).toList(),
                    onTap: () {
                      // if (focus.hasFocus) focus.unfocus();
                    },
                    onSuggestionTap: (x) {
                      field.didChange(x.item);
                      focus.unfocus();
                    },
                    emptyWidget: Builder(
                      builder: (context) {
                        /// loading
                        if (isLoading.value) {
                          return Card(
                            elevation: 0,
                            child: LoadingDetailsTiles(),
                          );
                        }

                        if (list == null) return SizedBox();

                        if (list.isEmpty) {
                          return const SizedBox(
                              height: 200,
                              child: Stack(
                                children: [
                                  Positioned(
                                    height: 0,
                                    right: 0,
                                    child: Text('button'),
                                  ),
                                  Center(
                                    child: Text('No results found'),
                                  ),
                                ],
                              ));
                        }
                        return SizedBox();
                      },
                    ),
                    suggestionsDecoration: suggestionDecoration,
                    onSearchTextChanged: (query) {
                      if (showAll) {
                        onSearchChanged(query);
                        return;
                      }
                      final trimmed = query.trim();
                      onSearchChanged(trimmed);
                      return;
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
