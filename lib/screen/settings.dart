import 'package:flutter/material.dart';
import 'package:nasa_app/constant/colors.dart';
import 'package:nasa_app/utils/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          // onTap: getSharedPreferences() == true ?() => initSharedPreferences(true),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              color: Colors.white,
              child: Text(
                'Light Mode',
                style: TextStyle(color: PRIMARY_COLOR),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
