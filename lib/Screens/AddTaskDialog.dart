import 'package:flutter/material.dart';
import 'package:timemanagement/Screens/WeekView.dart';
import 'package:timemanagement/main.dart';

class AddTaskDialog extends StatefulWidget {
  String name;
  AddTaskDialog(String name) {
    this.name = name;
  }
  @override
  AddTaskDialogState createState() => AddTaskDialogState(name);
}

class AddTaskDialogState extends State<AddTaskDialog> {
  String taskName;
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;
  bool sunday = false;
  List<int> days = [];
  Future<TimeOfDay> timeFrom;
  Future<TimeOfDay> timeTo;
  bool repeats = false;
  AddTaskDialogState(String name) {
    this.taskName = name;
  }

  TextStyle weekdayStyle = TextStyle(
      fontFamily: 'Avenir', fontSize: 10, fontWeight: FontWeight.bold);
  TextStyle titles = TextStyle(
      fontFamily: 'Avenir', fontSize: 20, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Center(
            child: Container(
          margin: EdgeInsets.only(top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'Repeats: ',
                style: titles,
              ),
              Container(
                margin: EdgeInsets.only(top: 0, bottom: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Monday',
                              style: weekdayStyle,
                            ),
                            Checkbox(
                              value: monday,
                              onChanged: (value) {
                                if (!this.days.contains(0)) {
                                  this.days.add(0);
                                } else {
                                  this.days.remove(0);
                                }
                                setState(() {
                                  monday = value;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Tuesday',
                              style: weekdayStyle,
                            ),
                            Checkbox(
                              value: tuesday,
                              onChanged: (value) {
                                if (!this.days.contains(1)) {
                                  this.days.add(1);
                                } else {
                                  this.days.remove(1);
                                }
                                setState(() {
                                  tuesday = value;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Wednesday',
                              style: weekdayStyle,
                            ),
                            Checkbox(
                              value: wednesday,
                              onChanged: (value) {
                                if (!this.days.contains(2)) {
                                  this.days.add(2);
                                } else {
                                  this.days.remove(2);
                                }
                                setState(() {
                                  wednesday = value;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Thursday',
                              style: weekdayStyle,
                            ),
                            Checkbox(
                              value: thursday,
                              onChanged: (value) {
                                if (!this.days.contains(3)) {
                                  this.days.add(3);
                                } else {
                                  this.days.remove(3);
                                }
                                setState(() {
                                  thursday = value;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Friday',
                              style: weekdayStyle,
                            ),
                            Checkbox(
                              value: friday,
                              onChanged: (value) {
                                if (!this.days.contains(4)) {
                                  this.days.add(4);
                                } else {
                                  this.days.remove(4);
                                }
                                setState(() {
                                  friday = value;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Saturday',
                              style: weekdayStyle,
                            ),
                            Checkbox(
                              value: saturday,
                              onChanged: (value) {
                                if (!this.days.contains(5)) {
                                  this.days.add(5);
                                } else {
                                  this.days.remove(5);
                                }
                                setState(() {
                                  saturday = value;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Sunday',
                              style: weekdayStyle,
                            ),
                            Checkbox(
                              value: sunday,
                              onChanged: (value) {
                                if (!this.days.contains(6)) {
                                  this.days.add(6);
                                } else {
                                  this.days.remove(6);
                                }
                                setState(() {
                                  sunday = value;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.blueGrey),
                child: Builder(
                  builder: (context) => FlatButton(
                        onPressed: () {
                          timeFrom = showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                        },
                        child: Text(
                          "Set Start time",
                          style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Colors.blueGrey),
                child: Builder(
                  builder: (context) => FlatButton(
                        onPressed: () {
                          timeTo = showTimePicker(
                              context: context, initialTime: TimeOfDay.now());
                        },
                        child: Text(
                          "Set End time",
                          style: TextStyle(
                              fontFamily: 'Avenir',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                ),
              ),
              RaisedButton(
                color: Colors.blueGrey,
                onPressed: () {
                  if (this.days.length > 0 &&
                      this.timeFrom != null &&
                      this.timeTo != null) {
                    createTask();
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  'Create Task',
                  style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }

  void createTask() async {
    for (int day in days) {
      print(day);
    }
    DateTime rightNow = new DateTime.now();
    DateTime timeStart;
    DateTime timeEnd;

    await timeFrom.then((value) => timeStart = new DateTime(
        rightNow.year, rightNow.month, rightNow.day, value.hour, value.minute));
    print(timeStart.toString());
    await timeTo.then((value) => timeEnd = new DateTime(
        rightNow.year, rightNow.month, rightNow.day, value.hour, value.minute));
    print(timeEnd.toString());
    List<DateTime> times = [];
    times.add(timeStart);
    times.add(timeEnd);
    MyHomePage.theUser
        .createTask(this.taskName, this.days, times, this.repeats);
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WeekView()),
    );
  }
}