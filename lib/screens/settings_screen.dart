import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('About Tickme'),
            trailing: Icon(Icons.info),
            onTap: () {
              // Implement your about screen logic here
              print('About Tickme');
            },
          ),
          ListTile(
            title: Text('Reset Data'),
            trailing: Icon(Icons.delete_forever),
            onTap: () {
              // Implement your data reset logic here
              showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('Confirm Reset'),
                  content: Text('Are you sure you want to reset all data?'),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(foregroundColor: Colors.blue),
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      style: TextButton.styleFrom(foregroundColor: Colors.blue),
                      child: Text('Reset'),
                      onPressed: () {
                        // Implement your data reset logic here
                        print('Resetting data');
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          // Add other settings options here
        ],
      ),
    );
  }
}
