import 'package:flutter/foundation.dart';
import 'package:version_comparator/version_comparator.dart';

/// This mixin decides which platform runs app.
mixin PlatformDeciderMixin {
  /// Determines the platform on which the app is running.
  ///
  /// If the app is running on the web, it returns [AppPlatform.web].
  /// Otherwise, it returns [AppPlatform.invalid].
  ///
  /// Returns a [Future] that completes with the determined [AppPlatform].
  Future<AppPlatform> getPlatform() async {
    if (kIsWeb) {
      return AppPlatform.web;
    }

    return AppPlatform.invalid;
  }
}
