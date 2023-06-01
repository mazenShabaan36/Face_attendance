import 'package:attendance/screens/registration/confirm.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Registeration extends StatefulWidget {
  @override
  State<Registeration> createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  String dropDownvalue = "Employee";
  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  Widget imageProfile() {
    return Center(
      child: Stack(children: <Widget>[
        CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.3,
          backgroundImage: _imageFile == null
              ? AssetImage("assets/no_prof.png") as ImageProvider
              : FileImage(File(_imageFile!.path)),
        ),
        Positioned(
          // bottom: MediaQuery.of(context).size.height * 0.00009,
          right: _imageFile == null
              ? MediaQuery.of(context).size.height * 0.11
              : MediaQuery.of(context).size.height * 0.22,
          top: _imageFile == null
              ? MediaQuery.of(context).size.height * 0.05
              : MediaQuery.of(context).size.height * 0.1,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  // <-- SEE HERE
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(35.0),
                  ),
                ),
                context: context,
                builder: ((builder) => bottomSheet()),
              );
            },
            child: Icon(
              Icons.camera_alt,
              color: Color(0xff1c4257),
              size: MediaQuery.of(context).size.height * 0.057,
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.2,
        vertical: MediaQuery.of(context).size.height * 0.02,
      ),
      child: Column(
        children: <Widget>[
           SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
            "Choose Profile Photo",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.058,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Text(
            "Kindly take a photo with high quality view of face",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.027,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            // ignore: deprecated_member_use
            TextButton.icon(
              icon: Icon(
                Icons.camera,
                color: Color(0xff1c4257),
              ),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text(
                "Camera",
                style: TextStyle(
                  color: Color(0xff1c4257),
                ),
              ),
            ),
            // ignore: deprecated_member_use
            TextButton.icon(
              icon: Icon(
                Icons.image,
                color: Color(0xff1c4257),
              ),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text(
                "Gallery",
                style: TextStyle(
                  color: Color(0xff1c4257),
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    // ignore: deprecated_member_use
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }

  TextEditingController _name = TextEditingController();
  TextEditingController _Id = TextEditingController();
  TextEditingController _dep = TextEditingController();
  TextEditingController _image = TextEditingController();
  bool validate1 = false;
  bool validate2 = false;
  bool validate3 = false;

  @override
  void dispose() {
    // TODO: implement dispose
    _name.dispose();
    _Id.dispose();
    _dep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1c4257),
      appBar: AppBar(
        elevation: 0.0,
        title: Center(
          child: Text(
            "Registration page",
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
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: EdgeInsets.all(9.0),
              child: Text(
                'Please fill your own data to join system',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    wordSpacing: 1.0),
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
                        'Name',
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
                          borderRadius: BorderRadius.all(Radius.circular(35))),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.013889,
                          ),
                          Icon(
                            Icons.contact_page_outlined,
                            color: Color(0xff1c4257),
                            size: 35,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _name,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Enter your Name',
                                  hintStyle: TextStyle(
                                      fontSize: 18, color: Color(0xff1c4257))),
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
                        'ID',
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
                          borderRadius: BorderRadius.all(Radius.circular(35))),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.013889,
                          ),
                          Icon(
                            Icons.perm_identity,
                            color: Color(0xff1c4257),
                            size: 35,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _Id,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Enter your ID',
                                  hintStyle: TextStyle(
                                      fontSize: 18, color: Color(0xff1c4257))),
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
                        'Department',
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
                          borderRadius: BorderRadius.all(Radius.circular(35))),
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.013889,
                          ),
                          Icon(
                            Icons.local_fire_department_outlined,
                            color: Color(0xff1c4257),
                            size: 35,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.025,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _dep,
                              //  keyboardType: TextInputType.number,
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Enter your department',
                                  hintStyle: TextStyle(
                                      fontSize: 18, color: Color(0xff1c4257))),
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
                        'Position',
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
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.95,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              elevation: 0,
                              iconSize: 40,
                              iconEnabledColor: Color(0xff1c4257),
                              items: [
                                "Employee",
                                "Team Leader",
                                "Project Team Leader",
                                "Department Head"
                              ].map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w300,
                                          color: Color(0xff1c4257)),
                                    ),
                                  );
                                },
                              ).toList(),
                              value: dropDownvalue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropDownvalue = newValue!;
                                });
                              },
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Profile Photo',
                      style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 12),
                    child: Text(
                      'Kindly take a photo with high quality view of face',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  imageProfile(),
                ],
              ),
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
                      _name.text.isNotEmpty &&
                              _dep.text.isNotEmpty &&
                              _Id.text.isNotEmpty &&
                              _imageFile !=null 
                          ? Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Confirm(
                                  name: _name.text,
                                  id: _Id.text,
                                  department: _dep.text,
                                  position: dropDownvalue,
                                  imageUrl: _imageFile!.path,
                                ),
                              ),
                            )
                          : showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Data Not completed'),
                                  content:
                                      Text('Please enter All Data required'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                    },
                    child: Text(
                      "Next",
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
