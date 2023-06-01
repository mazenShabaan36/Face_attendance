import 'package:attendance/screens/admin_reg/forget_password.dart';
import 'package:attendance/screens/tables/Calendar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class AdminLogin extends StatefulWidget {
  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  String tokend = "";
  bool _isLoading = false;
  Future<void> login(String email, String password) async {
    var uri = Uri.https(
        "face-attendance-apis-1812.onrender.com", "/api/v1/auth/login");
    var bodyt = {
      "email": email,
      "password": password,
    };
    var headers = {
      "Content-type": "application/json",
      "User-Agent": "PostmanRuntime/7.32.2",
      "Accept": "*/*",
    };
    /* requests.fields['email'] = email;
    requests.fields['password'] = password;
    //requests.headers.addAll(headers);
    var response = await http.Response.fromStream(await requests.send());
    */
    var response =
        await http.post(uri, body: jsonEncode(bodyt), headers: headers);

    print(json.decode(response.body)['token']);
    if (response.statusCode == 200) {
      // Login successful, navigate to the next screen
      setState(() {
        tokend = json.decode(response.body)['token'];
      });
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CalendarPick(token: tokend),
        ),
      );
    } else {
      // Login failed, show an error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('${json.decode(response.body)['msg']}'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1c4257),
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: Text(
            "Admin Login",
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
      body: Stack(
        children: [
          Container(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Email',
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35))),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.013889,
                              ),
                              Icon(
                                Icons.email_outlined,
                                color: Color(0xff1c4257),
                                size: 35,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.025,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: email,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Enter your Email',
                                      hintStyle: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff1c4257))),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(
                            'Password',
                            style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.09,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35))),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.013889,
                              ),
                              Icon(
                                Icons.password_outlined,
                                color: Color(0xff1c4257),
                                size: 35,
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.025,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: pass,
                                  obscureText: true,
                                  obscuringCharacter: "*",
                                  decoration: InputDecoration.collapsed(
                                      hintText: 'Enter your Password',
                                      hintStyle: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xff1c4257))),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ForgetPassword(),
                              ),
                            );
                          },
                          child: Text(
                            'Forget Password',
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationThickness: 2,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16),
                          ),
                        ),
                      ],
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
                          login(email.text, pass.text);
                          setState(() {
                            _isLoading = true;
                          });
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(
                              color: Color(0xff1c4257),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.07),
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
                          "Back",
                          style: TextStyle(
                              color: Color(0xff1c4257),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.07),
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
          _isLoading
              ? Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Please wait while connecting you to server...",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                        CircularProgressIndicator(),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
