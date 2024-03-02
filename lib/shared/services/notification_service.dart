import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  late FlutterLocalNotificationsPlugin notificationsPlugin; 
      
  NotificationService(){
    notificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotification();
  }

  Future<void> _initNotification() async {
    const android = AndroidInitializationSettings('ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
        (int id, String? title, String? body, String? payload) async {}
      );

    var initializationSettings = InitializationSettings(
        android: android , 
        iOS: initializationSettingsIOS,
      );

    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
      (NotificationResponse notificationResponse) async {}
    );
  }

  _setupNotification() async{
    await _initNotification();
  }

  notificationDetails() {
    return const NotificationDetails(
              android: AndroidNotificationDetails(
                'channelId', 
                'channelName',
                importance: Importance.max
              ),
              iOS: DarwinNotificationDetails()
            );
  }

  Future showNotification({
    int id = 0, 
    String? title, 
    String? body, 
    String? payLoad
  }) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}