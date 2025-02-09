import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:searchfield/searchfield.dart';

///
/// This is used for handling searchable dropdown fields
/// the `T` represents the type of the search result
/// so when you create a  you can declare it to be any type that fits your need
///
class CustomFormField<T> extends HookConsumerWidget {
  final String name;
  final bool enabled;
  final Function(T?)? onChanged;
  final Future<List<T>> Function(String?) onSearch;
  final SearchFieldListItem<T> Function(T) onChild;
  final Widget Function(T, TextEditingController) selectedBuilder;
  final String? hint;
  final Duration debounce;
  final dynamic Function(Object?)? valueTransformer;

  const CustomFormField({
    super.key,

    ///
    /// A widget for handling searchable dropdown fields.
    ///
    this.enabled = true,

    ///
    ///  when the field is submitted this value transformer will be called and
    ///  and whatever the value is returned will be the return value will be
    ///  result value this can be any type you want it does not need to be
    ///  similar to T
    ///
    this.valueTransformer,

    ///
    /// this will represent the name of the field. this will be the key when the
    /// result is created.
    ///
    required this.name,

    ///
    /// will handle the changes on the field value.
    ///
    required this.onChanged,

    ///
    /// this function will be called when the user types something in the field
    /// then it expects to return a list of the T type
    ///
    required this.onSearch,

    ///
    /// this is also a builder but this will be called when an item form the
    /// suggestions is displayed. in short this will determine what your search
    /// dropdown will look like.
    ///
    required this.onChild,

    ///
    /// this is the widget that will be shown when an item is selected
    ///
    required this.selectedBuilder,

    ///
    /// for decoration purposes. this will show as the helper text
    ///
    this.hint,

    ///
    /// added this so that the search will only work every 500 milliseconds
    ///
    this.debounce = const Duration(milliseconds: 500),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldKey = useMemoized(() => GlobalKey<FormBuilderFieldState>());
    final focus = useFocusNode();
    final searchResults = useState<List<T>>([]);
    final searchQuery = useState<String>('');
    final isEmpty = useState<bool>(true);
    final isLoading = useState<bool>(false);
    final debouncedQuery = useDebounced(searchQuery.value, debounce);
    final textCtrl = useTextEditingController();

    ///
    ///
    ///
    Future<void> search(String query) async {
      if (query.isEmpty) {
        searchResults.value = [];
        return;
      }
      isLoading.value = true;

      final result = await TaskResult.tryCatch(
        () => onSearch(query),
        Failure.presentation,
      ).run();

      result.fold((l) {}, (r) {
        isEmpty.value = r.isEmpty;
        searchResults.value = r;
      });
      isLoading.value = false;
    }

    useEffect(() {
      if (debouncedQuery != null && debouncedQuery.isNotEmpty) {
        search(debouncedQuery);
      }
      return null;
    }, [debouncedQuery]);

    return FormBuilderField(
      key: fieldKey,
      valueTransformer: valueTransformer,
      name: name,
      enabled: enabled,
      onChanged: (value) {
        if (value is T) onChanged?.call(value);
      },
      builder: (field) {
        final value = field.value;

        final suggestions = searchResults.value

            /// where type is used to filter the to match the T
            .whereType<T>()
            .map(onChild)
            .toList();

        ///
        /// search field
        ///
        return Column(
          children: [
            ///
            /// this will be the widget to show when there is a selected value
            ///
            if (value is T) selectedBuilder.call(value, textCtrl),

            ///
            /// Search Field
            ///
            Offstage(
              offstage: value != null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: SearchField<T>(
                  controller: textCtrl,
                  hint: hint,
                  focusNode: focus,
                  emptyWidget: Builder(builder: (context) {
                    ///
                    /// will display a loading indicator while searching
                    ///
                    if (isLoading.value) {
                      return const SizedBox(
                        height: 200,
                        child: CenteredProgressIndicator(),
                      );
                    }

                    ///
                    /// will display and empty widget if there are no results
                    ///
                    if (isEmpty.value) {
                      return const SizedBox(
                        height: 200,
                        child: Center(
                          child: Text('No results found'),
                        ),
                      );
                    }
                    return const SizedBox();
                  }),

                  ///
                  /// this are where the results will be displayed
                  /// if there are no results,
                  ///
                  suggestions: suggestions,
                  onSuggestionTap: (x) {
                    field.didChange(x.item);
                    focus.unfocus();
                  },
                  onSearchTextChanged: (query) {
                    searchQuery.value = query;
                    return;
                  },
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
