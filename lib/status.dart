import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusBar extends StatefulWidget {

  int index;
  List pageViews;
  PageController pageController;

  StatusBar({@required this.index, @required this.pageViews, @required this.pageController});

  @override
  _StatusBarState createState() => _StatusBarState();
}

class _StatusBarState extends State<StatusBar> {

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Container(
      height: height,
      width: width * 0.1,
      alignment: Alignment.centerRight,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.pageViews.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          Color color = Colors.white;
          double _height = height * 0.015;
          if(index == widget.index){
            _height = height * 0.03;
            //color = Colors.blue[200];
          }
          return GestureDetector(
            onTap: (){
              setState(() {
                widget.pageController.animateToPage(index, duration: Duration(seconds: 1), curve: Curves.easeIn).then((_){
                  widget.index = index;
                });
              });
            },
            child: Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(top: 5, bottom: 5, right: 10),
              height: _height,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.white),
                shape: BoxShape.circle,
                color: color,
              ),
            ),
          );
        },
      ),
    );
  }
}
