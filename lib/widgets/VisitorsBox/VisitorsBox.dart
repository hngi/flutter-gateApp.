import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/utils/helpers.dart';
import 'package:gateapp/widgets/SmallButton/small_button.dart';



class VisitorsBox extends StatefulWidget {

  final String visitorsName,visitorsNumber,visitorsCategory;

  VisitorsBox({@required this.visitorsName,@required this.visitorsNumber,@required this.visitorsCategory});

  @override
  _VisitorsBoxState createState() => _VisitorsBoxState();
}

class _VisitorsBoxState extends State<VisitorsBox> {
  bool showDetail=false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      height: 120,width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3)),
        border: Border.all(
          width: 1,
          style: BorderStyle.solid,
          color: GateManColors.textColor,
        )
      ),

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.visitorsName,style: TextStyle(fontSize: 14,color: Color(0xFF494949),fontWeight: FontWeight.w600),),
                GestureDetector(child: Icon(Icons.keyboard_arrow_down,color: Colors.green,),
                  onTap: (){
                    showDetail=!showDetail;
                    setState(() {

                    });
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical:5.0),
              child: Visibility(child: Text(widget.visitorsCategory,style: TextStyle(fontSize: 10,color: Color(0xFF494949)),),visible: showDetail,),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(widget.visitorsNumber,style: TextStyle(fontSize: 10,color: Color(0xFF878787)),),
                Visibility(child: SmallButton(buttonText: 'Add', onPressed: null),
                  visible: showDetail,
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
