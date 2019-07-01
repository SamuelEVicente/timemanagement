import 'package:flutter/material.dart';
import 'package:timemanagement/Screens/AddTaskDialog.dart';
import 'package:timemanagement/User/User.dart';
import 'package:timemanagement/Widgets/Popup/Popup.dart';
import 'package:timemanagement/Widgets/Popup/PopupContent.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Time Management'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static User theUser = new User();
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController taskNameController = new TextEditingController();
    String taskName = "";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Container(
            alignment: Alignment.topCenter,
            width: 300.0,
            child: new TextField(
              decoration: new InputDecoration(
                  hintText: "Enter name of Task",
                  labelText: "Add Task",
                  labelStyle: new TextStyle(color: Colors.black),
                  enabledBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black38)),
                  border: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black38))),
              textAlign: TextAlign.center,
              controller: taskNameController,
              onChanged: (text) {
                taskName = text;
              },
              onEditingComplete: () {
                taskNameController.text = taskName;
              },
              //textAlign: TextAlign.center,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (taskNameController.text.length > 1) {
            showPopup(context, _popupBody(taskName), 'Add Task');
            taskName = "";
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Colors.blueGrey,
      ),
    );
  }

  showPopup(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: 30,
        left: 30,
        right: 30,
        bottom: 50,
        child: PopupContent(
          content: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey,
              title: Text(title),
              leading: new Builder(builder: (context) {
                return IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    try {
                      Navigator.pop(context); //close the popup
                    } catch (e) {}
                  },
                );
              }),
              brightness: Brightness.light,
            ),
            resizeToAvoidBottomPadding: false,
            body: widget,
          ),
        ),
      ),
    );
  }

  Widget _popupBody(name) {
    return AddTaskDialog(name);
  }
}
