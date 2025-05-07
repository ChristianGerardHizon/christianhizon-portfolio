// universal_downloader_io.dart

import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// 🔥 NEW: import file_picker
import 'package:file_picker/file_picker.dart';

class FileDownloader {
  /// Initialize flutter_downloader (no‐op on desktop)
  static Future<void> init() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      await FlutterDownloader.initialize(debug: true);
    }
  }

  /// Downloads [url] as [fileName]:
  /// - Android/iOS: flutter_downloader
  /// - Windows/macOS/Linux: dart:io + file_picker save dialog
  static Future<void> downloadFile(
    String url,
    String fileName, {
    void Function(int received, int total)? onProgress,
  }) async {
    if (kIsWeb) {
      throw UnsupportedError('Web handled by the web implementation.');
    }

    // Mobile first
    if (Platform.isAndroid || Platform.isIOS) {
      await init();

      if (Platform.isAndroid) {
        final status = await Permission.storage.request();
        if (!status.isGranted) {
          throw Exception('Storage permission denied');
        }
      }

      final baseDir = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();

      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: baseDir!.path,
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: true,
      );
      print('Download task enqueued: $taskId');
      return;
    }

    // ---------- Desktop ----------
    if (Platform.isWindows || Platform.isMacOS || Platform.isLinux) {
      // 1) ask user where to save
      final savePath = await FilePicker.platform.saveFile(
        dialogTitle: 'Save file as…',
        fileName: fileName,
        type: FileType.any,
      );
      if (savePath == null) {
        // user cancelled
        print('Save dialog cancelled');
        return;
      }

      final file = File(savePath);
      final client = HttpClient();
      final request = await client.getUrl(Uri.parse(url));
      final response = await request.close();

      final totalBytes = response.contentLength;
      var receivedBytes = 0;

      // write to file with optional progress callback
      final raf = file.openSync(mode: FileMode.write);
      try {
        await for (final chunk in response) {
          raf.writeFromSync(chunk);
          receivedBytes += chunk.length;
          if (onProgress != null && totalBytes > 0) {
            onProgress(receivedBytes, totalBytes);
          }
        }
      } finally {
        await raf.close();
        client.close();
      }

      print('Download complete: $savePath');
      return;
    }

    throw UnsupportedError('Platform not supported for download');
  }
}
