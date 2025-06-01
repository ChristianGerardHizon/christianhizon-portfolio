import 'package:hooks_riverpod/hooks_riverpod.dart';

class RiverpodLogger extends ProviderObserver {
  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    print('''
{ 
  "action": "added",
  "provider": "${provider.runtimeType} ${provider.argument}",
  "value": "$value"
}''');
  }

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    print('''
{
  "action": "updated",
  "provider": "${provider.runtimeType}",
  "newValue": "$newValue"
}''');
  }

  /// A provider was disposed
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    print('''
{
  "action: "disposed",
  "provider": "${provider.runtimeType}"
}''');
  }
}
