import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timemanagement/Tasks/Occurence.dart';
import 'package:timemanagement/Tasks/Task.dart';
import 'package:timemanagement/Widgets/DonutPieChart.dart';
import 'package:timemanagement/main.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class DayView extends StatefulWidget {
  List<charts.Series<TaskData, int>> listOfTasks;
  int day;
  DayView(List<charts.Series<TaskData, int>> list, int day) {
    this.listOfTasks = list;
    this.day = day;
  }
  @override
  _DayViewState createState() => _DayViewState(listOfTasks, day);
}

class _DayViewState extends State<DayView> {
  List<charts.Series<TaskData, int>> listOfTasks;
  Map<int, String> days = new Map();
  int day;

  _DayViewState(List<charts.Series<TaskData, int>> list, int day) {
    this.listOfTasks = list;
    this.day = day;
  }

  setIt() {
    setState() {
      build(context);
    }
  }

  BuildContext theContext;
  @override
  Widget build(BuildContext context) {
    theContext = context;
    days[0] = 'Monday';
    days[1] = 'Tuesday';
    days[2] = 'Wednesday';
    days[3] = 'Thursday';
    days[4] = 'Friday';
    days[5] = 'Saturday';
    days[6] = 'Sunday';

    return Scaffold(
        appBar: AppBar(
          title: Text(
            days[day],
          ),
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 300,
              width: 300,
              child: DonutPieChart(listOfTasks),
            ),
            Container(
              constraints: BoxConstraints.expand(height: 260),
              child: ListView(
                children: makeTaskList(),
              ),
            )
          ],
        )));
  }

  TextStyle labelStyle = new TextStyle(
      fontFamily: 'Avenir', fontSize: 20, fontWeight: FontWeight.bold);

  List<Widget> makeTaskList() {
    List<String> taskNames = [];
    Map<String, int> hoursList = new Map();
    Map<String, DateTime> timeOfDay = new Map();
    for (Task task in MyHomePage.theUser.tasks) {
      for (Occurence occurs in task.occurences) {
        if (occurs.daysPerWeek.contains(day)) {
          if (!taskNames.contains(task.name)) {
            taskNames.add(task.name);
            int time = occurs.time[1].hour - occurs.time[0].hour;
            hoursList[task.name] = time;
            timeOfDay[task.name] = occurs.time[0];
          }
        }
      }
    }
    List<Widget> rows = [];
    for (int i = 0; i < taskNames.length; i++) {
      Container newContainer = new Container(
          height: 100,
          width: 300,
          child: GestureDetector(
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        taskNames[i],
                        style: labelStyle,
                      ),
                      Text(
                        makeTheTimeString(
                            timeOfDay[taskNames[i]], hoursList[taskNames[i]]),
                        style: labelStyle,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Total Time: ",
                        style: labelStyle,
                      ),
                      Text(
                        hoursList[taskNames[i]].toString() + "hrs",
                        style: labelStyle,
                      ),
                    ],
                  )
                ],
              ),
              elevation: 5,
            ),
            onTap: () {
              print("Pressed");
              _showDialog(taskNames[i], hoursList[taskNames[i]],
                  timeOfDay[taskNames[i]]);
            },
          ));
      rows.add(newContainer);
    }
    return rows;
  }

  void _showDialog(String taskName, int duration, DateTime startTimeOfDay) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(taskName),
          content:
              new Text('Time: ' + makeTheTimeString(startTimeOfDay, duration)),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
                key: new Key('one'),
                child: new Text("Delete"),
                onPressed: () {
                  deleteATask(taskName);
                  Navigator.of(context).pop();
                  Navigator.of(theContext).pop();
                }),
          ],
        );
      },
    );
  }

  void deleteATask(String taskName) {
    List<Task> taskList = MyHomePage.theUser.tasks;
    for (Task task in taskList) {
      if (task.name == taskName) {
        task.removeOccurrenceByDay(day);
      }
    }
    MyHomePage.theUser.tasks = taskList;
  }

  String makeTheTimeString(DateTime date, int duration) {
    if (date.minute > 10) {
      return date.hour.toString() +
          ":" +
          date.minute.toString() +
          "-" +
          (date.hour + duration).toString() +
          ":" +
          date.minute.toString();
    } else {
      return date.hour.toString() +
          ":0" +
          date.minute.toString() +
          "-" +
          (date.hour + duration).toString() +
          ":0" +
          date.minute.toString();
    }
  }
}
