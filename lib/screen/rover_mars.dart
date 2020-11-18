import 'package:flutter/material.dart';
import 'package:nasa_app/model/rover_mars_model.dart';
import 'package:nasa_app/repository/rover_mars_repository.dart';
import 'package:nasa_app/screen/rover_mars_detail.dart';

class RoverMars extends StatefulWidget {
  RoverMars({Key key}) : super(key: key);

  @override
  _RoverMarsState createState() => _RoverMarsState();
}

class _RoverMarsState extends State<RoverMars> {
  int columnCount = 4;
  String fetchedDate = '2020-01-10';

  @override
  void initState() {
    super.initState();
  }

  changeGridCounter(bool suma) {
    suma ? columnCount++ : columnCount--;
    setState(() {
      columnCount = columnCount;
    });
  }

  void parsearFecha(DateTime currentDay) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
            child: FutureBuilder<List<RoverMarsModel>>(
          future: fetchPhotoRovers(fetchedDate),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var roverItems = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 600,
                    width: 450,
                    child: GridView.count(
                      crossAxisCount: columnCount,
                      children: List.generate(roverItems.length, (index) {
                        return Center(
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RoverMarsDetail(
                                        roverItemDetailed: roverItems[index]))),
                            child: Image.network(
                              roverItems[index].imgSrc,
                              height: 120,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      gridCounterButtons(false),
                      gridCounterButtons(true)
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          },
        )),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xFF17161b),
            child: Icon(Icons.calendar_today_outlined,
                size: 32, color: Color(0xFFf2c902)),
            onPressed: () {
              showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2013),
                      lastDate: DateTime.now())
                  .then((date) {
                int anoActual = date.year;
                int mesActual = date.month;
                int diaActual = date.day;
                setState(() {
                  fetchedDate = '$anoActual-$mesActual-$diaActual';
                });
              });
            }));
  }

  Widget gridCounterButtons(bool operation) {
    return GestureDetector(
        onTap: () => changeGridCounter(operation),
        child: Container(
            alignment:
                operation ? Alignment(0.5, -0.05) : Alignment(-0.5, -0.05),
            width: 40,
            height: 80,
            decoration: BoxDecoration(
              color: Color(0xFF17161b),
              borderRadius: operation
                  ? BorderRadius.only(
                      topLeft: Radius.circular(100),
                      bottomLeft: Radius.circular(100),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),
            ),
            child: Text(
              operation ? '+' : '-',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFFf2c902),
              ),
            )));
  }
}
