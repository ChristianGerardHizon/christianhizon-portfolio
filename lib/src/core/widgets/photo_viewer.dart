import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewer extends HookConsumerWidget {
  const PhotoViewer(this.url, {super.key});

  final String url;

  static show(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) => PhotoViewer(url),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog.fullscreen(
      child: Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
        ),
        body: PhotoView(
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Text('Error loading image'));
          },
          imageProvider: CachedNetworkImageProvider(
            url,
          ),
        ),
      ),
    );
  }
}
