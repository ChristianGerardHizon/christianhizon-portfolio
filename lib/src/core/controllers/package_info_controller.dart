import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'package_info_controller.g.dart';

@Riverpod(keepAlive: true)
class PackageInfoController extends _$PackageInfoController {
  @override
  Future<PackageInfo> build() async {
    return await PackageInfo.fromPlatform();
  }
}
