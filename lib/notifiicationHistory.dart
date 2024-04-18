import 'package:flutter/material.dart';

class NotificationHistory extends StatefulWidget {
  const NotificationHistory({super.key});

  @override
  State<NotificationHistory> createState() => _NotificationHistoryState();
}

class _NotificationHistoryState extends State<NotificationHistory> {
  final List<String> _notifications = [
    'Notification 1',
    'Notification 2',
    'Notification 3',
    'Notification 4',
    'Notification 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(11, 0, 35, 10),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _notifications.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_notifications[index]),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _notifications.removeAt(index);
                        });
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}