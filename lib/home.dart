import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fullpage/status.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController _pageController;
  List<Widget> _pageViews;
  int _index;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _index = 0;
    _pageController = PageController(
      initialPage: _index,
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    _pageViews = [
      Container(
        height: height,
        color: Colors.blueAccent,
      ),
      Container(
        height: height,
        color: Colors.amberAccent,
      ),
      Container(
        height: height,
        color: Colors.pinkAccent,
      ),
      Container(
        height: height,
        color: Colors.deepPurpleAccent,
      ),
    ];
    Duration duration = Duration(seconds: 1);
    return Listener(
      onPointerSignal: (_){
        if(_ is PointerScrollEvent){
          final delta = _.scrollDelta.dy; /// -100 ScrollDown OR 100 ScrollUP
          print(delta);
          if(delta == 100){
            if(_pageViews.length -1 != _index){
              _pageController.nextPage(duration: duration, curve: Curves.easeIn);
            }
          }else{
            if(_index != 0){
              _pageController.animateToPage(_index -1, duration: duration, curve: Curves.easeIn);
            }else{
              _pageController.animateToPage(0, duration: duration, curve: Curves.easeIn);
            }
          }
        }
      },
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          PageView(
            scrollDirection: Axis.vertical,
            children: _pageViews,
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (_){
              setState(() {
                _index = _;
              });
            }
          ),
          StatusBar(index: _index, pageViews: _pageViews, pageController: _pageController)
        ],
      ),
    );
  }
}
