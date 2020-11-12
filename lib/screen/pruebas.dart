import 'package:flutter/material.dart';

class ShopHome extends StatefulWidget {
  @override
  _ShopHomeState createState() => _ShopHomeState();
}

class _ShopHomeState extends State<ShopHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopeame'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SafeArea(
        child: Column(
          children: [
            ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  height: 120,
                  width: double.infinity,
                  color: Colors.brown,
                ),
                Container(
                  height: 120,
                  width: double.infinity,
                  color: Colors.brown,
                ),
                Container(
                  height: 120,
                  width: double.infinity,
                  color: Colors.brown,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
