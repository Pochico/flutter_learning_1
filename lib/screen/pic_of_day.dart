import 'package:flutter/material.dart';
import 'package:nasa_app/repository/pic_of_day_repository.dart';
import 'package:nasa_app/model/pic_of_day_model.dart';

class PicOfDay extends StatefulWidget {
  PicOfDay({Key key}) : super(key: key);

  @override
  _PicOfDayState createState() => _PicOfDayState();
}

class _PicOfDayState extends State<PicOfDay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<PicOfDayModel>(
                future: fetchAlbum('2020-11-10'),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 350,
                          child: Text(snapshot.data.title,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 12),
                        Container(
                            child: Text(
                          snapshot.data.date,
                          textAlign: TextAlign.left,
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[400]),
                        )),
                        SizedBox(height: 12),
                        Image.network(snapshot.data.hdurl),
                        SizedBox(height: 12),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                },
              )),
        ),
      ),
    );
  }
}
