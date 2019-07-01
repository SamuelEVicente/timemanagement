import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timemanagement/Screens/DayView.dart';
import 'package:timemanagement/Tasks/Occurence.dart';
import 'package:timemanagement/Tasks/Task.dart';
import 'package:timemanagement/User/User.dart';
import 'package:timemanagement/Widgets/DonutPieChart.dart';
import 'package:timemanagement/main.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class WeekView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyWeekView(title: 'Time Management'),
    );
  }
}

class MyWeekView extends StatefulWidget {
  MyWeekView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyWeekViewState createState() => _MyWeekViewState();
}

class _MyWeekViewState extends State<MyWeekView> {
  List<List<TaskData>> listOfAllDays = [];

  void createAllTaskData() {
    User myUser = MyHomePage.theUser;

    for (int i = 0; i < 7; i++) {
      List<TaskData> listOfDayTasks = [];
      Map<String, int> listTasks = new Map();
      Map<String, int> listEndTimes = new Map();
      List<int> startTimes = [];
      List<int> endTimes = [];
      for (Task task in myUser.tasks) {
        for (Occurence occurs in task.occurences) {
          if (occurs.daysPerWeek.contains(i)) {
            int time = occurs.time[1].hour - occurs.time[0].hour;
            listTasks[task.name] = occurs.time[0].hour;
            listEndTimes[task.name] = occurs.time[1].hour;
            startTimes.add(occurs.time[0].hour);
            endTimes.add(occurs.time[1].hour);
          }
        }
      }
      int count = 0;
      for (TaskData data in listOfDayTasks) {
        count += data.time;
      }
      int counter = 0;
      int start = 0;
      int end = 0;
      String name = "";

      for (int i = 0; i < 24; i++) {
        if (startTimes.contains(i)) {
          for (Task task in myUser.tasks) {
            for (Occurence occurs in task.occurences) {
              if (occurs.time[0].hour == i) {
                name = task.name;
              }
            }
          }
          if (i != end) {
            if (end < i) {
              listOfDayTasks.add(new TaskData('free time', i - end));
            }
          }
          end = listEndTimes[name];
          start = i;
          listOfDayTasks.add(new TaskData(name, end - start));
        }
        if (i == 23) {
          if (i != end) {
            listOfDayTasks.add(new TaskData('free time', i - end));
          }
        }
      }
      listOfAllDays.add(listOfDayTasks);
    }
    setState() {
      build(context);
    }
  }

  List<List<charts.Series<TaskData, int>>> listOfAllData = [];

  void data() {
    for (int i = 0; i < 7; i++) {
      listOfAllData.add(mondayData(i));
    }
  }

  List<charts.Series<TaskData, int>> mondayData(int day) {
    createAllTaskData();
    final data = listOfAllDays[day];

    return [
      new charts.Series<TaskData, int>(
        id: 'Sales',
        domainFn: (TaskData sales, _) => sales.time,
        measureFn: (TaskData sales, _) => sales.time,
        data: data,
      )
    ];
  }

// child: DonutPieChart(mondayData()),
  @override
  Widget build(BuildContext context) {
    data();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              Container(
                  child: Center(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text('Monday'),
                              Container(
                                height: 80,
                                width: 80,
                                child: Center(
                                  child: DonutPieChart(listOfAllData[0]),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DayView(listOfAllData[0], 0)),
                          );
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text('Tuesday'),
                              Container(
                                height: 80,
                                width: 80,
                                child: Center(
                                  child: DonutPieChart(listOfAllData[1]),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DayView(listOfAllData[1], 1)),
                          );
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text('Wednesday'),
                              Container(
                                height: 80,
                                width: 80,
                                child: Center(
                                  child: DonutPieChart(listOfAllData[2]),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DayView(listOfAllData[2], 2)),
                          );
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text('Thursday'),
                              Container(
                                height: 80,
                                width: 80,
                                child: Center(
                                  child: DonutPieChart(listOfAllData[3]),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DayView(listOfAllData[3], 3)),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )),
              Container(
                  child: Center(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text('Friday'),
                              Container(
                                height: 80,
                                width: 80,
                                child: Center(
                                  child: DonutPieChart(listOfAllData[4]),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DayView(listOfAllData[4], 4)),
                          );
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text('Saturday'),
                              Container(
                                height: 80,
                                width: 80,
                                child: Center(
                                  child: DonutPieChart(listOfAllData[5]),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DayView(listOfAllData[5], 5)),
                          );
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text('Sunday'),
                              Container(
                                height: 80,
                                width: 80,
                                child: Center(
                                  child: DonutPieChart(listOfAllData[6]),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DayView(listOfAllData[6], 6)),
                          ).then((value) {
                            setState(() {
                              createAllTaskData();
                              build(context);
                              print("HELLO" + value);
                            });
                          });
                        },
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        heroTag: "Hellooo",
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MyApp()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
