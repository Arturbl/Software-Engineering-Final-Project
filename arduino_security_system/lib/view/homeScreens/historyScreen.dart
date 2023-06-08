import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<DropdownDetails> items = [
    DropdownDetails('Item 1', 'Details 1'),
    DropdownDetails('Item 2', 'Details 2'),
    DropdownDetails('Item 3', 'Details 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(items[index].itemName),
            subtitle: Text(items[index].itemDetails),
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
                            items[index].itemName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            items[index].itemDetails,
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

class DropdownDetails {
  final String itemName;
  final String itemDetails;

  DropdownDetails(this.itemName, this.itemDetails);
}
