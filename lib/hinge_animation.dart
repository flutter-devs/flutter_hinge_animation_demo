import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';



class HingeAnimation extends StatefulWidget {
  @override
  _HingeAnimationState createState() => _HingeAnimationState();

}

class _HingeAnimationState extends State<HingeAnimation> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  Animation _rotationAnimation;
  Animation<double> _slideAnimation;
  Animation<double> _opacityAnimation;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );

    _rotationAnimation = Tween(end: 0.15, begin: 0.0)
        .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
            0.0,
            0.5,
            curve: Curves.bounceInOut
        ),
      ),
    );

    _slideAnimation = Tween(begin: 100.0, end: 600.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
            0.5,
            1.0,
            curve: Curves.fastOutSlowIn)
        ,
      ),
    );

    _opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
            0.5,
            1.0,
            curve: Curves.fastOutSlowIn),
      ),
    );

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          automaticallyImplyLeading: false,
          title: Text("Flutter Hinge Animation Demo"),
          centerTitle: true,
        ),

        body: AnimatedBuilder(
          animation: _slideAnimation,
          builder: (BuildContext context, Widget child) => Container(
            width: 200,
            height: 150,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.only(
              left: 100,
              top: _slideAnimation.value,
            ),
            child: RotationTransition(
              turns: _rotationAnimation,
              child: Center(
                child:
                Text('Flutter Devs', style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(
                        300,
                        150,
                        500,
                        _opacityAnimation.value)
                ),),
              ),
            ),
          ),
        ),

        floatingActionButtonLocation:
        FloatingActionButtonLocation.miniCenterFloat,

        floatingActionButton:
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          backgroundColor: Colors.green[300],
          onPressed: (){
            _controller.forward();
          },
        ),
    );
  }
}