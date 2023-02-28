import 'package:fitnees_app/home_screen.dart';
import 'package:fitnees_app/model_class.dart';
import 'package:fitnees_app/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SeconScreen extends StatefulWidget {
  const SeconScreen({super.key, this.exercise});
  final Exercise? exercise;
  @override
  State<SeconScreen> createState() => _SeconScreenState();
}

class _SeconScreenState extends State<SeconScreen> {
  int second = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'HULK',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(children: [
        Image.network(
          "${widget.exercise!.thumbnail}",
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Column(
              children: [
                SleekCircularSlider(
            //        appearance: CircularSliderAppearance(
            // customWidths: CustomSliderWidths(progressBarWidth: 20)),
                  max: 20,
                  min: 0,
                  onChange: (double value) {
                    setState(() {
                      second = value.toInt();
                    });
                  },
                  innerWidget: (double value) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${second.toStringAsFixed(0)}',
                            style: myStyle(35, Colors.orange, FontWeight.w700),
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ThirdScreen(
                                          exercise: widget.exercise,
                                          second: second,
                                        )));
                              },
                              child: Column(
                                children: [
                                  Text(
                                    'Start',
                                    style: myStyle(20, Colors.white),
                                  ),
                                  Text(
                                    'Workout',
                                    style: myStyle(20, Colors.white),
                                  )
                                ],
                              ))
                        ],
                      ),
                    );
                  },
                  initialValue: second.toDouble(),
                )
              ],
            )),
        Center(
          child: Positioned(
            child: Text(
              '${widget.exercise!.title}',
              style: myStyle(25, Colors.white, FontWeight.w700),
            ),
          ),
        )
      ]),
    );
  }
}
