import 'dart:ui';

import 'package:attendance/utils/register_api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class DataTableShow extends StatefulWidget {
  DateTime DateTimeT;
  String token;
  List<dynamic> attendanceData;
  DataTableShow(
      {required this.DateTimeT,
      required this.attendanceData,
      required this.token});

  @override
  _DataTableShowState createState() => _DataTableShowState();
}

class _DataTableShowState extends State<DataTableShow> {
  @override
  void initState() {
    // TODO: implement initState
    /* Register()
        .fetchAttendanceByDate(attendanceData, widget.DateTimeT, widget.token);
*/

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1c4257),
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Center(
              child: Text(
                "attendees : ${widget.attendanceData.length.toString()}",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Colors.red.shade300,
                    fontSize: 16),
              ),
            ),
          )
        ],
        elevation: 0.0,
        title: Center(
          child: Text(
            "Attendance",
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Attendace of the day : ${DateFormat('yyyy-MM-dd').format(widget.DateTimeT)} ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: StreamBuilder(
                initialData: widget.attendanceData,
                stream: Stream.value(widget.attendanceData),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: EdgeInsets.only(left: 3.0),
                      child: widget.attendanceData.length != 0
                          ? Container(
                              child: ListView.builder(
                                itemBuilder: (context, index) {
                                  final data = widget.attendanceData[index];
                                  return Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.75,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.20,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Column(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  child: Image.network(
                                                      data['recognition_face'],
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.3,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.14),
                                                ),
                                                Text(
                                                  "${index + 1}",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          Colors.red.shade300),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.04,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                // crossAxisAlignment:       CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    child: Text(
                                                      data['user']['name'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff1c4257),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.008,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    child: Text(
                                                      data['user']['empolyeeId']
                                                          .toString(),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff1c4257),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.008,
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    child: Text(
                                                      data['user']
                                                          ['department'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff1c4257),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02,
                                                  ),
                                                  Center(
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.032,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    25)),
                                                        color:
                                                            Color(0xff1c4257),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          data[
                                                              'attendance_time'],
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: widget.attendanceData.length,
                              ),
                            )
                          : Center(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    'No Data for this day',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.1,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

/*
GridView.builder(
                          itemCount: widget.attendanceData.length,
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 330,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 6,
                                  mainAxisExtent: 327,
                                  mainAxisSpacing: 8),
                          itemBuilder: (context, index) {
                            final data = widget.attendanceData[index];
                            return Container(
                              height: MediaQuery.of(context).size.height * 0.46,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),

                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),

                                      child: Image.network(
                                        data['recognition_face'],
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.46,
                                        fit: BoxFit.fill,
                                        
                                      ),
                                    ),
                                    Divider(color: Color(0xff1c4257),),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.001,
                                    ),
                                    Text(
                                      "Name : ${data['user']['name']}",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff1c4257),
                                      ),
                                    ),
                                    Divider(color: Color(0xff1c4257),),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.001,
                                    ),
                                    Text(
                                      "ID : ${data['user']['empolyeeId'].toString()}",
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff1c4257),
                                      ),
                                    ),
                                    Divider(color: Color(0xff1c4257),),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.001,
                                    ),
                                    Text(
                                      "department : ${data['user']['department']}",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff1c4257),
                                      ),
                                    ),
                                    Divider(color: Color(0xff1c4257),),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.001,
                                    ),
                                    Center(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(25)),
                                          color: Color(0xff1c4257),
                                        ),
                                        child: Center(
                                          child: Text(
                                            data['attendance_time'],
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
*/