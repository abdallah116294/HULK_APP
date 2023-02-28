import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitnees_app/home_screen.dart';
import 'package:fitnees_app/model_class.dart';
import 'package:fitnees_app/widget.dart';
import 'package:flutter/material.dart';

class ThirdScreen extends StatefulWidget {
  ThirdScreen({super.key, this.exercise, this.second});
  final Exercise? exercise;
  int? second;
  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late Timer timer;
  int startSecond = 0;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == widget.second) {
        timer.cancel();
        setState(() {
          showToast('WorkOut Successfully completed');
          Future.delayed(Duration(seconds: 3), () {
            Navigator.of(context).pop();
          });
        });
      }
      setState(() {
        startSecond = timer.tick;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0A0C23).withOpacity(0.7),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(
          'HULK',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(children: [
        // CachedNetworkImage(
        //   imageUrl: '${widget.exercise!.gif}',
        //   width: double.infinity,
        //   height: double.infinity,
        //   placeholder: (context, url) => spinkit,
        //   errorWidget: (context, url, error) => Icon(Icons.error),
        // ),
        Image(image: NetworkImage("${widget.exercise!.gif}"),height: double.infinity,width:double.infinity,),
        Positioned(
          top: 60,
          left: 20,
          right: 20,
          child: Center(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.orange,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset.fromDirection(2.0, 4.0),
                            blurRadius: 3,
                            color: Colors.black.withOpacity(.6))
                      ]),
                      child: Text("${startSecond}",style: myStyle(40, Colors.white,FontWeight.w600),),
                      
                ),
                 Text("Timer On", style: myStyle(25, Colors.white, FontWeight.w600)),
              ],
            ),
          ),
          
        ),
       
        Positioned(left: 0,right: 0,bottom: 100,child: Center(child: Text('${widget.exercise!.title}',style: myStyle(25, Colors.white,FontWeight.w700),),))
      ]),
    );
  }
}
