import 'dart:async';
import 'dart:io';

import 'package:attendance/screens/homeScreen.dart';
import 'package:attendance/utils/register_api.dart';
import 'package:flutter/material.dart';

class Confirm extends StatefulWidget {
  final String name;
  final String id;
  final String department;
  final String position;
  final String imageUrl;

  Confirm(
      {required this.name,
      required this.id,
      required this.department,
      required this.position,
      required this.imageUrl});

  @override
  State<Confirm> createState() => _ConfirmState();
}

class _ConfirmState extends State<Confirm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1c4257),
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: Text(
            "Confrim",
            style: TextStyle(color: Color(0xff1c4257), letterSpacing: 1.2),
          ),
        ),
        backgroundColor: Color(0xff1c4257),
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40)),
            // color: Colors.cyan,
            gradient: LinearGradient(
                colors: [Colors.white, Colors.white54],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
        ),
      ),
      body: Container(
        child: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Please review your data before confirmation',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    wordSpacing: 1.0),
              ),
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.89,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Name: ",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1c4257)),
                            ),
                            Text(
                              widget.name,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1c4257)),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xff1c4257),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Id: ",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1c4257)),
                            ),
                            Text(
                              widget.id,
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1c4257)),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xff1c4257),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Department: ",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1c4257)),
                            ),
                            Text(
                              widget.department,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1c4257)),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xff1c4257),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Postion: ",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1c4257)),
                            ),
                            Text(
                              widget.position,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1c4257)),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Color(0xff1c4257),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Face Image: ",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff1c4257)),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.29,
                              height: MediaQuery.of(context).size.height * 0.15,
                              decoration: BoxDecoration(
                                  color: Color(0xff1c4257),
                                  border: Border(
                                    top: BorderSide(
                                        color: Colors.black45, width: 5),
                                    left: BorderSide(
                                        color: Colors.black45, width: 5),
                                    bottom: BorderSide(
                                        color: Colors.black45, width: 5),
                                    right: BorderSide(
                                        color: Colors.black45, width: 5),
                                  )),
                              child: Center(
                                child: Image.file(
                                  File(widget.imageUrl),
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.30,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  //padding:
                  //  const EdgeInsets.only(left: 100.0, top: 40.0),
                  // ignore: deprecated_member_use
                  child: new ElevatedButton(
                    onPressed: () {
                      Register().register(widget.name, widget.id,
                          widget.department, widget.position, widget.imageUrl);
                      Timer(Duration(seconds: 2), () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      });
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          color: Color(0xff1c4257),
                          fontSize: MediaQuery.of(context).size.width * 0.07),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Container(
                  //padding:
                  //  const EdgeInsets.only(left: 100.0, top: 40.0),
                  // ignore: deprecated_member_use
                  child: new ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Edit",
                      style: TextStyle(
                          color: Color(0xff1c4257),
                          fontSize: MediaQuery.of(context).size.width * 0.07),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
