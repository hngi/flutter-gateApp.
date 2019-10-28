import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:xgateapp/utils/intro_view/Models/page_bubble_view_model.dart';

/// This class contains the UI for page bubble.
class PageBubble extends StatelessWidget {
  //view model
  final PageBubbleViewModel viewModel;

  //Constructor
  PageBubble({
    this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 15, //55.0,
      height: 35, //65.0,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, right: 3, left: 3),
          child: Container(
            width: lerpDouble(
                20.0,
                45.0,
                viewModel
                    .activePercent), //This method return in between values according to active percent.
            height: lerpDouble(20.0, 45.0, viewModel.activePercent),
            //       width: 45, //55.0,
            // height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //Alpha is used to create fade effect for background color
              color: viewModel.isHollow
                  ? viewModel.bubbleBackgroundColor
                      .withAlpha((0x88 * viewModel.activePercent).round())
                  : viewModel.bubbleBackgroundColor,
              // border: Border.all(
              //   color: viewModel.isHollow
              //       ? viewModel.bubbleBackgroundColor.withAlpha(
              //           (0x88 * (1 - viewModel.activePercent)).round())
              //       : Colors.transparent,
              //   width: 2.0,
              // ), //Border
            ), //BoxDecoration
            child: Opacity(
              opacity: viewModel.activePercent,
              child: (viewModel.iconAssetPath != null &&
                      viewModel.iconAssetPath != "")
                  // ignore: conflicting_dart_import
                  ? CircleAvatar(
                      backgroundColor: Color(0xFFE21800).withOpacity(.5),
                      //radius: 40,
                    )
                  : viewModel.bubbleInner != null
                      ? Transform.scale(
                          scale: viewModel.activePercent.clamp(0.5, 1.0),
                          child: viewModel.bubbleInner,
                        )
                      : Container(),
            ), //opacity
          ), //Container
        ), //Padding
      ), //Center
    ); //Container
  }
}
