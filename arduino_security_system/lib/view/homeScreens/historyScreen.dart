import 'package:flutter/material.dart';
import 'package:arduino_security_system/model/User.dart';

class HistoryScreen extends StatefulWidget {
  final User user;
  const HistoryScreen({Key? key, required this.user}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<AlarmHistory> alarmHistoryList = [
    AlarmHistory(DateTime(2023, 6, 25, 20, 25), 'artur'),
    AlarmHistory(DateTime(2023, 6, 25, 20,25), 'tomas'),
    AlarmHistory(DateTime(2023, 6, 25, 20,27), 'admin'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: alarmHistoryList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(alarmHistoryList[index].dateTime.toString()),
            subtitle: Text('Solved By: ${alarmHistoryList[index].solvedBy}'),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            alarmHistoryList[index].dateTime.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Solved By: ${alarmHistoryList[index].solvedBy}',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Close'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class AlarmHistory {
  final DateTime dateTime;
  final String solvedBy;

  AlarmHistory(this.dateTime, this.solvedBy);
}
