import 'dart:async';

class NotificationStream {
  static StreamController<bool> pushNotificationController = StreamController<bool>.broadcast();
  static StreamController<bool> inAppNotificationController = StreamController<bool>.broadcast();
}

class LocationStream{
  static StreamController<bool> locationSwitchController = StreamController<bool>.broadcast();
}