import 'package:flutter/material.dart';

import '../../../../core/widgets/cached_avatar.dart';
import '../../domain/patient.dart';

/// Avatar widget for displaying a patient's image.
///
/// Uses [CachedAvatar] with a paw print placeholder icon.
class PatientAvatar extends StatelessWidget {
  const PatientAvatar({
    super.key,
    required this.patient,
    this.radius = 20,
    this.onTap,
  });

  final Patient patient;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CachedAvatar(
      imageUrl: patient.hasAvatar ? patient.avatar : null,
      radius: radius,
      placeholderIcon: Icons.pets,
      onTap: onTap,
    );
  }
}
