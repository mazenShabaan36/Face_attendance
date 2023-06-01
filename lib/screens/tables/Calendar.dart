import 'dart:async';

import 'package:attendance/screens/tables/tableDate.dart';
import 'package:attendance/utils/register_api.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPick extends StatefulWidget {
  String token;
  CalendarPick({required this.token});
  @override
  State<CalendarPick> createState() => _CalendarPickState();
}

class _CalendarPickState extends State<CalendarPick> {
  List<dynamic> attendanceData = [];
  List<dynamic> attendanceDataD = [];
  void handleDateSelection(DateTime date) async {
    attendanceData = await Register()
        .fetchAttendanceByDate(attendanceData, date, widget.token);
    print(attendanceData);
  }

  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  late CalendarController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
    handleDateSelection(_controller.selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1c4257),
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: Text(
            "Pick a date",
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
      body: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Selected Day : ' + today.toString().split(" ")[0],
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: TableCalendar(

                  rowHeight: MediaQuery.of(context).size.height * 0.1,
                  initialCalendarFormat: CalendarFormat.month,
                  calendarStyle: CalendarStyle(
                    todayColor: Colors.blue,
                  weekdayStyle: TextStyle(
                    color: Colors.white
                  ),
                  outsideStyle: TextStyle(
                    color: Colors.white
                  ),
                  eventDayStyle: TextStyle(
                    color: Colors.white
                  ),
                    selectedColor: Color(0xff1c4257),
                    todayStyle: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: Colors.white),
                    
                  ),
                  headerStyle: HeaderStyle(
                      centerHeaderTitle: true,
                      formatButtonDecoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      titleTextStyle: TextStyle(
                    color: Colors.white
                  ),
                      formatButtonTextStyle: TextStyle(color: Colors.white),
                      formatButtonShowsNext: false),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  builders: CalendarBuilders(

                    selectedDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(25.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                    todayDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade300,
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  onDaySelected: (day, events, holidays) {
                    setState(() {
                      today = day;
                    });
                  },
                  calendarController: _controller,
                  // headerStyle:
                  //   HeaderStyle(formatButtonVisible: false, titleCentered: true),
                  //availableGestures: AvailableGestures.all,
                  //focusedDay: today,
                  //selectedDayPredicate: (day) => isSameDay(day, today),
                  //firstDay: DateTime.utc(2015, 10, 10),
                  //lastDay: DateTime(2035, 10, 10),
                  //onDaySelected: _onDaySelected,
                  locale: 'en_US',
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      //padding:
                      //  const EdgeInsets.only(left: 100.0, top: 40.0),
                      // ignore: deprecated_member_use
                      child: new ElevatedButton(
                        onPressed: () {
                          setState(() {
                            attendanceData = [];
                            handleDateSelection(DateTime.now());
                          });
                          print(widget.token);
                          Timer(Duration(seconds: 3), () {
                            Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DataTableShow(
                                DateTimeT: DateTime.now(),
                                attendanceData: attendanceData,
                                token: widget.token,
                              ),
                            ),
                          );
                          });
                        },
                        child: Text(
                          "Show today attendance",
                          style: TextStyle(
                              color: Color(0xff1c4257),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035),
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
                          setState(() {
                            attendanceData = [];
                            handleDateSelection(
                                DateTime.now().subtract(Duration(days: 1)));
                          });
                          print(widget.token);
                          Timer(Duration(seconds: 3), () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DataTableShow(
                                  DateTimeT: DateTime.now()
                                      .subtract(Duration(days: 1)),
                                  attendanceData: attendanceData,
                                  token: widget.token,
                                ),
                              ),
                            );
                          });
                        },
                        child: Text(
                          "Show yesterday attendance",
                          style: TextStyle(
                              color: Color(0xff1c4257),
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035),
                        ),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.brown.shade300,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    //padding:
                    //  const EdgeInsets.only(left: 100.0, top: 40.0),
                    // ignore: deprecated_member_use
                    child: new ElevatedButton(
                      onPressed: () {
                        setState(() {
                          attendanceData = [];
                          handleDateSelection(_controller.selectedDay);
                        });
                        print(widget.token);
                        Timer(Duration(seconds: 3), () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DataTableShow(
                                DateTimeT: _controller.selectedDay,
                                attendanceData: attendanceData,
                                token: widget.token,
                              ),
                            ),
                          );
                        });
                      },
                      child: Text(
                        "Show day attendance",
                        style: TextStyle(
                            color: Color(0xff1c4257),
                            fontSize: MediaQuery.of(context).size.width * 0.04),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade300,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
