// universal_downloader_web.dart

import 'dart:js_interop';

@JS()
@staticInterop
class Document {}

extension DocumentExtension on Document {
  external HTMLAnchorElement createElement(String tagName);
  external Element get body;
}

@JS()
@staticInterop
class HTMLAnchorElement {}

extension HTMLAnchorElementExtension on HTMLAnchorElement {
  external set href(String href);
  external set download(String download);
  external void click();
}

@JS()
@staticInterop
class Element {}

extension ElementExtension on Element {
  external Element appendChild(Object child);
  external void removeChild(Object child);
}

@JS('document')
external Document get document;

class FileDownloader {
  /// Triggers a browser “Save as…” download using only js_interop.
  static void downloadFile(String url, String fileName) {
    final anchor = document.createElement('a');
    anchor.href = url;
    anchor.download = fileName;
    final body = document.body;
    body.appendChild(anchor);
    anchor.click();
    body.removeChild(anchor);
  }
}
