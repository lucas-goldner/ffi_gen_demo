import 'dart:ffi';
import 'dart:io';

import 'bindings/cm_headphone_motion_manager_bindings.dart';
import 'package:path/path.dart' as path;

class CMHeadPhoneManagerProvider {
  CMHeadphoneMotionManager? manager;

  CMHeadphoneMotionManager initialize() {
    final dylibPath = path.join(
        Directory.current.path, 'lib' 'headers', 'CMHeadphoneMotionManager.h');

    final instance = CMHeadphoneMotionManagerLibrary(DynamicLibrary.process());
    final cmManager = CMHeadphoneMotionManager.new1(instance);
    manager = cmManager;
    return cmManager;
  }

  CMHeadphoneMotionManager getInstance() => manager ?? initialize();

  void test() {
    if (manager?.deviceMotionAvailable ?? false) {}
  }
}
