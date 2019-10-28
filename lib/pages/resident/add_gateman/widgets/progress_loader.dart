import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/utils/helpers.dart';
import 'package:xgateapp/widgets/CustomInputField/custom_input_field.dart';

class ProgressLoader extends StatefulWidget {
  double width;
  double height;

  ProgressLoader({this.width, this.height});

  @override
  _ProgressLoaderState createState() => _ProgressLoaderState();
}

class _ProgressLoaderState extends State<ProgressLoader>
    with SingleTickerProviderStateMixin {
  AnimationController loadingAnimationController;
  Animation<double> tweenAnimation;

  @override
  void dispose() {
    loadingAnimationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadingAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));
    tweenAnimation =
        Tween(begin: 0.0, end: 360.0).animate(loadingAnimationController)
          ..addListener(() {
            // print(tweenAnimation.value);
            setState(() {});
          });

    tweenAnimation.addStatusListener((status) {
      //print(status);
      setState(() {
        if (status == AnimationStatus.completed) {
          loadingAnimationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          loadingAnimationController.forward();
        }
      });
    });

    loadingAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    //print(tweenAnimation.value);
    // TODO: implement build
    return Transform.rotate(
        angle: tweenAnimation.value,
        child: Image.asset('assets/images/add_gateman_detail_loading.png',
        width: this.widget.width,height: this.widget.height,));
  }
}
