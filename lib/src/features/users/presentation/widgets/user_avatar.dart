import 'package:flutter/material.dart';

import '../../../../core/widgets/cached_avatar.dart';
import '../../domain/user.dart';

/// Avatar widget for displaying a user's image.
///
/// Uses [CachedAvatar] with a person placeholder icon.
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.user,
    this.radius = 20,
    this.onTap,
  });

  final User user;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CachedAvatar(
      imageUrl: user.hasAvatar ? user.avatar : null,
      radius: radius,
      placeholderIcon: Icons.person,
      onTap: onTap,
    );
  }
}
