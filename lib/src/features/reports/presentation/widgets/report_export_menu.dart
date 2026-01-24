import 'package:flutter/material.dart';

/// A popup menu button for exporting reports.
class ReportExportMenu extends StatelessWidget {
  const ReportExportMenu({
    super.key,
    required this.onPrint,
    required this.onShare,
    required this.onSave,
  });

  final VoidCallback onPrint;
  final VoidCallback onShare;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.download),
      tooltip: 'Export Report',
      onSelected: (value) {
        switch (value) {
          case 'print':
            onPrint();
            break;
          case 'share':
            onShare();
            break;
          case 'save':
            onSave();
            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'print',
          child: ListTile(
            leading: Icon(Icons.print),
            title: Text('Print'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem(
          value: 'share',
          child: ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
        const PopupMenuItem(
          value: 'save',
          child: ListTile(
            leading: Icon(Icons.save),
            title: Text('Save as PDF'),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
