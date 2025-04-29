import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'side_menu_controller.g.dart';

@riverpod
SideMenuController sideMenuController(Ref ref) {
  return SideMenuController();
}
