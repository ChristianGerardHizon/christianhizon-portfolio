import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';

class ExpirationStatusText extends StatelessWidget {
  final DateTime expirationDate;

  const ExpirationStatusText({
    super.key,
    required this.expirationDate,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final localExpiration = expirationDate.toLocal();

    final status = _getExpirationStatus(localExpiration, now);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _getStatusColor(status),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        _getStatusText(status, localExpiration),
        style: const TextStyle(fontSize: 12, color: Colors.black),
      ),
    );
  }

  ExpirationStatus _getExpirationStatus(DateTime expiration, DateTime now) {
    if (expiration.isBefore(now)) return ExpirationStatus.expired;
    if (expiration.difference(now).inDays <= 7)
      return ExpirationStatus.nearExpiration;
    return ExpirationStatus.notExpired;
  }

  Color _getStatusColor(ExpirationStatus status) {
    switch (status) {
      case ExpirationStatus.expired:
        return Colors.red;
      case ExpirationStatus.nearExpiration:
        return Colors.orange;
      case ExpirationStatus.notExpired:
        return Colors.green;
    }
  }

  String _getStatusText(ExpirationStatus status, DateTime expiration) {
    final formattedDate = expiration.shortReadable;
    switch (status) {
      case ExpirationStatus.expired:
        return "Expired on $formattedDate";
      case ExpirationStatus.nearExpiration:
        return "Expiring soon ($formattedDate)";
      case ExpirationStatus.notExpired:
        return "Valid until $formattedDate";
    }
  }
}

enum ExpirationStatus {
  expired,
  nearExpiration,
  notExpired,
}
