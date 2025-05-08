import 'package:background_downloader/background_downloader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'file_downloader.g.dart';

@Riverpod(keepAlive: true)
FileDownloader fileDownloader (Ref ref) {
  return FileDownloader();
}