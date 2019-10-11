import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:intl/intl.dart';



class CustomDatePicker extends StatefulWidget{

  Function onChanged;
  Function onSaved;
  CustomDatePicker({@required this.onChanged,@required this.onSaved});
  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  int selectedMonthIndex = 9;
  List<int> currentDay = [23,9,2018];
  int currentMonthIndex = 9;
  int currentYear = 2018;
  List<List<int>> dayRows = [
      [28,29,30,31,1,2,3],
      [4,5,6,7,8,9,10],
      [11,12,13,14,15,16,17],
      [18,19,20,21,22,23,24],
      [25,26,27,28,29,30,1]
  ];

  List<String> months = ['January','February','March','April','May','June','July','August',
  'September','October','November','December'];

  List<int> selectedDay = [21,9,2018];
  List<String> weeks = ['MON','TUE','WED','THUR','FRI','SAT','SUN'];
  String yearType = 'LEAP'; //OR NON_LEAP

  List<int> getMonthRange(int index){
    if (index==8||index==3||index==5||index==10){
      return [1,30];
    } else if (index==1){
      if (yearType == 'LEAP'){
        return [1,28];
      } else {
        return [1,29];
      }

    } else {
      return [1,31];
    }

  }

  void setSelectedDay(int value,int pos) {
    int numOfTimes = 0;
    int stateSelectedMonthIndex = selectedMonthIndex;
    dayRows.forEach((list){
        if (list.contains(value)){
          numOfTimes += 1;
        }
    });
    print(numOfTimes);
    print(pos);
    if (numOfTimes > 1 && pos == 0 && value>= 25){
      stateSelectedMonthIndex = currentMonthIndex - 1;
    } else if (numOfTimes > 1 && pos == 0 && value<= 7){
      stateSelectedMonthIndex = currentMonthIndex;
    } else if (numOfTimes > 1 && pos == 4 && value>= 25){
      stateSelectedMonthIndex = currentMonthIndex;
    } else if (numOfTimes > 1 && pos == 4 && value<= 7){
      stateSelectedMonthIndex = currentMonthIndex + 1;
    }
    print(selectedMonthIndex);
    setState(() {
      selectedMonthIndex = stateSelectedMonthIndex;
     this.selectedDay = [value,stateSelectedMonthIndex,currentYear]; 
    });
    
  }

        Widget header(){
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.keyboard_arrow_left), onPressed: () {},
              ),
      
              Text(months[this.currentMonthIndex]+ ' ' + currentYear.toString(),style: TextStyle(fontSize: 14,color: Colors.black87),
              ),
              IconButton(
                icon: Icon(Icons.keyboard_arrow_right), onPressed: () {},
              )
            ],
          );
        }

        Widget weekHeader() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: this.weeks.map((value){
              return Text(value,style:TextStyle(color: Colors.grey));
          }).toList(),);
        }

        Widget dayWidget(int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:dayRows[index].map((value){
                return InkWell(
                  splashColor: GateManColors.primaryColor,
                  onTap: (){print(value.toString() + " tapped");
                  setSelectedDay(value,index);
                                    },
                                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: selectedDay[0] == value && selectedDay[1] == selectedMonthIndex && selectedDay[2]==currentYear?GateManColors.primaryColor:
                                        currentDay[0] == value && currentDay[1] == currentMonthIndex && currentDay[2] == currentYear?
                                        GateManColors.primarySwatchColor.shade100:Colors.white
                                      ),
                                      width: 30,
                                      height: 30,
                                      child: Center(child:Text(value.toString(),textAlign: TextAlign.center,
                                        style: TextStyle(color:selectedDay[0] == value && selectedDay[1] == currentMonthIndex && selectedDay[2]==currentYear?Colors.white:
                                        currentDay[0] == value && currentDay[1] == currentMonthIndex && currentDay[2] == currentYear?GateManColors.primaryColor:Colors.black54 
                                        ),))),
                                  );
                            }).toList() );
                            
                            
                          }

                    

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(child: Column(children: <Widget>[
      header(),
      weekHeader(),
      Divider(color: Colors.grey,),
      dayWidget(0),
      dayWidget(1),
      dayWidget(2),
      dayWidget(3),
      dayWidget(4),
      FlatButton(child: Text("DONE", style: TextStyle(color: GateManColors.primaryColor)),
      onPressed: (){},)
      
          ],),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(6)
          ),
          margin: EdgeInsets.only(top: 3),);
        }
}



// class DisabledNode extends FocusNode {
//   @override
//   bool get hasFocus => false;
// }

// /// A custom textfield that serves as a date picker
// class CustomDatePickerFormField extends StatefulWidget {
//   ///[isRow] to check if the date picker will be in a row of two elements
//   /// [dateController] for saving and setting the readable version of the date
//   /// [selectDate] a function that gets called when the calendar icon is clicked, the function that shows the main calendar
//   /// [label] The name the current date picker
//   /// [type] The type of the current date picker

//   final bool isRow;
//   final Function selectDate;
//   final String label;
//   final String type;
//   final String initialValue;
//   Function(String) onSaved;
//   String Function(String) validator;

//   CustomDatePickerFormField({
//     Key key,
//     this.isRow = false,
//     this.selectDate,
//     this.label,
//     this.type,
//     this.initialValue,
//     this.onSaved,
//     this.validator,
//   }) : super(key: key);

//   @override
//   _CustomDatePickerFormFieldState createState() =>
//       _CustomDatePickerFormFieldState();
// }

// class _CustomDatePickerFormFieldState extends State<CustomDatePickerFormField> {
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       flex: widget.isRow ? 3 : 0,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             widget.label,
//             style: TextStyle(
//               color: Color(0xFF103366),
//               fontSize: 12,
//             ),
//           ),
//           TextFormField(
//             enabled: true,
//             initialValue: widget.initialValue,
//             onSaved: widget.onSaved,
//             validator: widget.validator,
//             focusNode: DisabledNode(),
//             style: TextStyle(
//                 color: Color(0xFF103366),
//                 fontSize: 14,
//                 fontWeight: FontWeight.bold),
//             decoration: InputDecoration(
//               suffixIcon: IconButton(
//                 onPressed: () {
//                   widget.selectDate();
//                 },
//                 icon: Icon(
//                   Icons.calendar_today,
//                   size: 20.0,
//                   color: Color(0xFF103366),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: screenAwareSize(4.0, context),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<Null> _selectDate(BuildContext context, String startDate,
//       DateTime initialDate, String type) async {
//     final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: initialDate,
//         firstDate: DateTime(2015, 8),
//         lastDate: DateTime(2101));

//     String formatted = DateFormat('y/MM/dd').format(picked);
//     if (picked != null && picked != initialDate) {
//       setState(() {
//         startDate = formatted;
//       });
//     }
//   }
// }
