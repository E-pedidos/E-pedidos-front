import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  
  NotificationService(){
    initNotification().then((value) {});
  }

  Future<void> initNotification() async {
     const android = AndroidInitializationSettings('logo_flutter');

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

  /* late FlutterLocalNotificationsPlugin localNotificationPlugin;
  late AndroidNotificationDetails androidDetails; */
  

 /*  NotificationService(){
    localNotificationPlugin = FlutterLocalNotificationsPlugin();

    localNotificationPlugin.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

    _setupNotification();
  }
  
  _setupNotification() async{
    await _initializeNotification();
  }

  _initializeNotification() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher.png');

    await localNotificationPlugin.initialize(
      const InitializationSettings(
        android: android,
      ), 
      onDidReceiveNotificationResponse: _onSelectNotification,
    );
  } */