import 'dart:ffi';

import 'bindings/cm_headphone_motion_manager_bindings.dart';

class CMHeadPhoneManagerProvider {
  CMHeadphoneMotionManagerLibrary? _library;
  CMHeadphoneMotionManager? manager;

  CMHeadphoneMotionManager initialize() {
    final instance = CMHeadphoneMotionManagerLibrary(DynamicLibrary.process());
    _library = instance;
    final cmManager = CMHeadphoneMotionManager.new1(instance);
    manager = cmManager;
    return cmManager;
  }

  CMHeadphoneMotionManager getInstance() => manager ?? initialize();

  void startDeviceMotionUpdates() {
    if (manager?.deviceMotionAvailable ?? false) {
      manager?.startDeviceMotionUpdates();
    }
  }

  Stream<double> getAttitudeY() async* {
    while (true) {
      yield manager?.deviceMotion?.attitude?.quaternion.y ?? 0.0;
      await Future.delayed(const Duration(milliseconds: 10));
    }
  }
}
