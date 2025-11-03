import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart';

/// 🟢 الهاندلر الخاص بالرسائل في الخلفية (لازم يكون top-level)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
  debugPrint("📩 رسالة في الخلفية: ${message.notification?.title}");
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;
  bool _isBackgroundHandlerSet = false; // عشان ما يتسجلش مرتين

  /// 🧩 التهيئة الأساسية
  Future<String> initialize() async {
    try {
      // ✅ تسجيل الهاندلر لمرة واحدة فقط
      if (!_isBackgroundHandlerSet) {
        FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
        _isBackgroundHandlerSet = true;
      }

      // طلب الإذن من المستخدم
      await _requestPermission();

      // تهيئة الإشعارات المحلية
      await setupFlutterNotifications();

      // تهيئة الهاندلرز الخاصة بالـ FCM
      await _setupMessageHandlers();

      // الحصول على الـ Token
      final token = await _messaging.getToken();
      debugPrint('✅ FCM Token: $token');
      return token ?? "";
    } catch (e, s) {
      debugPrint('❌ Error initializing notifications: $e');
      debugPrintStack(stackTrace: s);
      return "";
    }
  }

  /// طلب الإذن من المستخدم
  Future<void> _requestPermission() async {
    try {
      await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    } catch (e) {
      debugPrint('⚠️ Error requesting permission: $e');
    }
  }

  /// تهيئة إعدادات Flutter Local Notifications
  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) return;

    try {
      const channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );

      await _localNotifications
          .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

      final initializationSettingsDarwin = DarwinInitializationSettings();

      final initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
      );

      await _localNotifications.initialize(initializationSettings);

      _isFlutterLocalNotificationsInitialized = true;
    } catch (e) {
      debugPrint('⚠️ Error setting up flutter notifications: $e');
    }
  }

  /// عرض الإشعار
  Future<void> showNotification(RemoteMessage message) async {
    try {
      final notification = message.notification;
      final android = message.notification?.android;

      if (notification != null && android != null) {
        await _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          const NotificationDetails(
            android: AndroidNotificationDetails(
              'high_importance_channel',
              'High Importance Notifications',
              channelDescription: 'Used for important notifications.',
              importance: Importance.high,
              priority: Priority.high,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
            ),
          ),
          payload: message.data.toString(),
        );
      }
    } catch (e) {
      debugPrint('⚠️ Error showing notification: $e');
    }
  }

  /// تهيئة الاستماع للرسائل
  Future<void> _setupMessageHandlers() async {
    FirebaseMessaging.onMessage.listen(showNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);

    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) _handleBackgroundMessage(initialMessage);
  }

  /// عند فتح التطبيق من إشعار
  void _handleBackgroundMessage(RemoteMessage message) {
    debugPrint('📩 Notification opened with data: ${message.data}');
  }
}
