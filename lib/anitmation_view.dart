import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimationView extends StatefulWidget {
  @override
  _AnimationViewState createState() => _AnimationViewState();
}

class _AnimationViewState extends State<AnimationView> {
  bool isAnimatedAlign = false;
  Timer timer;
  int _start = 10;
  double width = 0;

  void startTime() {
    final oneSec = Duration(seconds: 1);
    final deviceWidth = MediaQuery.of(context).size.width;
    final onePeriod = deviceWidth / 10;
    timer = Timer.periodic(oneSec, (timer) {
      if (_start < 1) {
        timer.cancel();
        showDialog(
            context: context,
            builder: (val) => Dialog(
                  child: Text("Download done"),
                ));
      } else {
        setState(() {
          width += onePeriod;
        });
        _start -= 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: AnimatedAlign(
              alignment: isAnimatedAlign
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              duration: Duration(milliseconds: 100),
              child: Container(
                width: 100,
                height: 100,
                child: RaisedButton(onPressed: () {
                  setState(() {
                    startTime();
                    isAnimatedAlign = !isAnimatedAlign;
                  });
                }),
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: isAnimatedAlign ? 0.2 : 0.7,
            duration: Duration(milliseconds: 200),
            child: FlutterLogo(
              size: 300,
            ),
          ),
          AnimatedContainer(
            duration: Duration(seconds: 1),
            width: width,
            height: 100,
            color: Colors.red,
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
