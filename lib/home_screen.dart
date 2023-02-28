import 'dart:convert';

import 'package:fitnees_app/model_class.dart';
import 'package:fitnees_app/second_scree.dart';
import 'package:fitnees_app/widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String link =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR2gsu4SRvRRFkHK8JPTWHZXmaNP0dtpOG6h7ep4zQp7WaamX5S1UaSrc3A";
  List<Exercise> allData = [];
  late Exercise exercise;
  bool isLoading = false;

  fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var responce = await http.get(Uri.parse(link));
      //print('Status code is{$responce.statusCode}');
      if (responce.statusCode == 200) {
        var data = jsonDecode(responce.body);
        for (var i in data['exercises']) {
          exercise = Exercise(
              id: i['id'],
              title: i['title'],
              thumbnail: i['thumbnail'],
              gif: i['gif'],
              seconds: i['seconds']);
          setState(() {
            allData.add(exercise);
          });
        }
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('the problem is $e');
      showToast('somthing is wrong');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading == true,
      blur: .5,
      opacity: .5,
      progressIndicator: spinkit,
      child: Scaffold(
        backgroundColor: Color(0xff0A0C23).withOpacity(0.5),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.orange,
          title: const Text(
            'HULK',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: allData.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: Offset.fromDirection(2.0, 4.0),
                              blurRadius: 3,
                              color: Colors.black.withOpacity(.6)),
                        ],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xff0A0C23), width: 2),
                        image: DecorationImage(
                            image: NetworkImage("${allData[index].thumbnail}"),
                            fit: BoxFit.cover)),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    height: 200,
                    width: double.infinity,
                  ),
                  Positioned(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: const Color(0xff0A0C23), width: 0.5),
                          color: Colors.white.withOpacity(.3),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset.fromDirection(2.0, 4.0),
                                blurRadius: 3,
                                color: Colors.black.withOpacity(.6))
                          ]),
                      height: 40,
                      width: double.infinity,
                      child: Text(
                        "${allData[index].title}",
                        style: myStyle(18, Colors.white60, FontWeight.w600),
                      ),
                    ),
                    bottom: 20,
                    left: 10,
                    right: 10,
                  ),
                  Positioned(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SeconScreen(exercise: allData[index],)));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 55,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xff0A0C23), width: 1),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.orange,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Go',
                              style: myStyle(
                                18,
                                Colors.black,
                                FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                    bottom: 25,
                    right: 25,
                  )
                ],
              );
            }),
      ),
    );
  }
}

myStyle(double fs, Color clr, [FontWeight? fw]) {
  return TextStyle(fontSize: fs, color: clr, fontWeight: fw);
}

showToast(String title) {
  return Fluttertoast.showToast(
      msg: "$title",
      gravity: ToastGravity.CENTER_LEFT,
      timeInSecForIosWeb: 3,
      textColor: Colors.blue,
      fontSize: 16);
}
