import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key, required this.title});
  static const route = '/notification_page';
  final String title;

  @override
  Widget build(BuildContext context) {
    print('Notification title :$title');
    return const Scaffold(
      body: Center(
        child: Text('Notification page'),
      ),
    );
  }
}
