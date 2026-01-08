// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_downloader.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fileDownloader)
final fileDownloaderProvider = FileDownloaderProvider._();

final class FileDownloaderProvider
    extends $FunctionalProvider<FileDownloader, FileDownloader, FileDownloader>
    with $Provider<FileDownloader> {
  FileDownloaderProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'fileDownloaderProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$fileDownloaderHash();

  @$internal
  @override
  $ProviderElement<FileDownloader> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FileDownloader create(Ref ref) {
    return fileDownloader(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileDownloader value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileDownloader>(value),
    );
  }
}

String _$fileDownloaderHash() => r'34f2dec140468c2daa262d83fdebeefb48d17798';
