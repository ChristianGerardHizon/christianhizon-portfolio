import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pending_redirect_provider.g.dart';

/// Stores the URL user intended to visit before auth resolved.
///
/// Used to redirect back after successful authentication on web,
/// where users can directly access deep links.
@Riverpod(keepAlive: true)
class PendingRedirect extends _$PendingRedirect {
  @override
  String? build() => null;

  /// Set the pending redirect URL.
  void set(String url) => state = url;

  /// Clear the pending redirect URL.
  void clear() => state = null;

  /// Clear and return the pending redirect URL.
  String? consume() {
    final url = state;
    state = null;
    return url;
  }
}
