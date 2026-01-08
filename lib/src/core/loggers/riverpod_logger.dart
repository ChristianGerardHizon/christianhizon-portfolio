import 'package:hooks_riverpod/hooks_riverpod.dart';

final class RiverpodLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderObserverContext context,
    Object? value,
  ) {
    print('''
{
  "action": "added",
  "provider": "${context.provider.runtimeType}",
  "value": "$value"
}''');
  }

  @override
  void didUpdateProvider(
    ProviderObserverContext context,
    Object? previousValue,
    Object? newValue,
  ) {
    print('''
{
  "action": "updated",
  "provider": "${context.provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }

  @override
  void didDisposeProvider(
    ProviderObserverContext context,
  ) {
    print('''
{
  "action": "disposed",
  "provider": "${context.provider.runtimeType}"
}''');
  }
}
