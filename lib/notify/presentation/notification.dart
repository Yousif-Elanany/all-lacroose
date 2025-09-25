import 'package:flutter/material.dart';

import '../widgets/buildNotify.dart';



class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'الإشعارات',
            style: TextStyle(fontSize: 24),
          ),
          bottom: TabBar(

            indicatorColor:  Color(0xffEF600D),
            labelColor: Colors.black,
            unselectedLabelColor: Color(0xff6C6C89),
            dividerHeight: 0,
            labelStyle: TextStyle( fontSize: 16),
            tabs: [
              Tab(text: 'الكل'),
              Tab(text: 'غير مقروءة'),
              Tab(text: 'مقروءة'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NotificationsList(),
            NotificationsList(), // يمكن تعديلها لإظهار الإشعارات غير المقروءة
            NotificationsList(), // يمكن تعديلها لإظهار الإشعارات المقروءة
          ],
        ),
      ),
    );
  }
}

class NotificationsList extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'شحن مجاني لأول طلبك!',
      'time': '2h',
      'message': 'طلبك الأول معنا مميز! استفد من الشحن المجاني اليوم. شكراً لاختيارك [اسم التطبيق].',
    },
    {
      'title': 'تم استلام طلبك بنجاح تركت طلبك بعد! ',
      'time': '2h',
      'message': 'تم تجهيز طلبك رقم [12345]. شكراً لاختيارك [اسم التطبيق].',
    },
    {
      'title': 'منتجاتك تنتظرك في السلة!',
      'time': '2h',
      'message': 'لقد تركت طلبك بعد! أكمل عملية الشراء قبل انتهاء الكمية. شكراً لثقتك بنا.',
    },
    {
      'title': 'تم استلام طلبك بنجاح!',
      'time': '2h',
      'message': 'تم تجهيز طلبك رقم [12345]. شكراً لاختيارك [اسم التطبيق].',
    },
    {
      'title': 'منتجاتك تنتظرك في السلة!',
      'time': '2h',
      'message': 'لقد تركت طلبك بعد! أكمل عملية الشراء قبل انتهاء الكمية. شكراً لثقتك بنا.',
    },

  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationItem(
          title: notification['title']!,
          time: notification['time']!,
          message: notification['message']!,
        );
      },
    );
  }
}

