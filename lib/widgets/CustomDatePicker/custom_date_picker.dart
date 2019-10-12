import 'package:flutter/material.dart';
import 'package:gateapp/utils/colors.dart';
import 'package:gateapp/widgets/CustomInputField/custom_input_field.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  
  DateTime minimumAllowedDate;

  DateTime now;

  int currentMonthValue;

  int currentWeekIndex;

  int currentYear;

  int currentDay;

  int currentMonthIndex;

  List<int> currentDayFull;

  int selectedMonthValue;

  int calendarCurrentViewMonth;

  int weekIndexOfFirstDayOfSelectedMonth;

  List<String> weeks;

  List<int> selectedDayFull;

  List<String> months = ['January','Feburary','March','April','May','June','July',
  'August','September','October','November','December'];

  int colorPos = 0;

 List<List<List<int>>> dayRows = [
    [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]],
    [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]],
    [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]],
    [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]],
    [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]]
  ];

  bool includeInput;
  bool showingDetail = true;
 CustomDatePicker({this.includeInput = false,@required this.onChanged,@required this.onSaved,this.now,this.minimumAllowedDate,this.maximumAllowedDate}):assert(minimumAllowedDate==null&&maximumAllowedDate==null?true:minimumAllowedDate!=null&&maximumAllowedDate!=null?minimumAllowedDate.compareTo(maximumAllowedDate)<1:
minimumAllowedDate==null&&maximumAllowedDate!=null?DateTime.now().compareTo(maximumAllowedDate)<1:minimumAllowedDate!=null&&maximumAllowedDate==null?minimumAllowedDate.compareTo(DateTime.now())<1:true){
  if(this.now==null){
    this.now = DateTime.now();
  }
  if(this.includeInput==true){
    showingDetail=false;
  }
   
  this.currentMonthValue = now.month;
  this.currentWeekIndex = now.weekday - 1;
  this.currentYear = now.year;
  this.currentDay = now.day;
  this.currentMonthIndex = this.currentMonthValue - 1;
this.currentDayFull = [this.currentDay, this.currentMonthValue, this.currentYear];
  selectedMonthValue = now.month;
  calendarCurrentViewMonth = now.month;
  calendarCurrentViewYear= now.year;
  selectedYearValue = now.year;
  weekIndexOfFirstDayOfSelectedMonth = DateTime(currentYear,currentMonthValue,1).weekday -1;
  
  weeks = ['MON', 'TUE', 'WED', 'THUR', 'FRI', 'SAT', 'SUN'];

  
  // List<List<int>> dayRows = [
  //   [28, 29, 30, 31, 1, 2, 3],
  //   [4, 5, 6, 7, 8, 9, 10],
  //   [11, 12, 13, 14, 15, 16, 17],
  //   [18, 19, 20, 21, 22, 23, 24],
  //   [25, 26, 27, 28, 29, 30, 1]
  // ];

  selectedDayFull = currentDayFull;
}
  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();

  Function(String) onChanged;

  Function(String) onSaved;

  int calendarCurrentViewYear;

  int selectedYearValue;

  DateTime maximumAllowedDate;
}

class _CustomDatePickerState extends State<CustomDatePicker> with TickerProviderStateMixin{

TextEditingController dateController = TextEditingController();

void toggleShowingDetail(){
  setState(() {
   this.widget.showingDetail = !this.widget.showingDetail; 
  });
}
 
void nextMonth(){
  bool run = true;
  if (this.widget.maximumAllowedDate==null){
      run = true;
  } else {
    if (this.widget.calendarCurrentViewYear+1>this.widget.maximumAllowedDate.year && this.widget.calendarCurrentViewMonth + 1 > 12 && this.widget.calendarCurrentViewMonth +1 > this.widget.maximumAllowedDate.month){
      run = false;
    }
  }
  if (run){
  if (this.widget.calendarCurrentViewMonth + 1 > 12){
    setState(() {
   this.widget.calendarCurrentViewMonth = 1;
   this.widget.calendarCurrentViewYear = this.widget.calendarCurrentViewYear + 1;
  this.widget.weekIndexOfFirstDayOfSelectedMonth = DateTime(this.widget.calendarCurrentViewYear,this.widget.calendarCurrentViewMonth,1).weekday -1;
  });
  } else{
  setState(() {
    this.widget.calendarCurrentViewMonth = this.widget.calendarCurrentViewMonth+1;
    this.widget.weekIndexOfFirstDayOfSelectedMonth = DateTime(this.widget.calendarCurrentViewYear,this.widget.calendarCurrentViewMonth,1).weekday -1;
    
  });
  }
  }

  
}


void prevMonth(){
  bool run = true;
  if (this.widget.minimumAllowedDate==null){
      run = true;
  } else {
    if ((this.widget.calendarCurrentViewYear-1<this.widget.minimumAllowedDate.year && this.widget.calendarCurrentViewMonth - 1 < 1)||(this.widget.calendarCurrentViewYear-1<this.widget.minimumAllowedDate.year && this.widget.calendarCurrentViewMonth - 1 < this.widget.minimumAllowedDate.month)){
      run = false;
    }
  }

  if (run){

    if (this.widget.calendarCurrentViewMonth - 1 < 1){
        setState(() {
   this.widget.calendarCurrentViewMonth = 12;
    this.widget.calendarCurrentViewYear = this.widget.calendarCurrentViewYear-1;
    this.widget.weekIndexOfFirstDayOfSelectedMonth = DateTime(this.widget.calendarCurrentViewYear,this.widget.calendarCurrentViewMonth,1).weekday -1;
  });
    }else{
  setState(() {
   this.widget.calendarCurrentViewMonth = this.widget.calendarCurrentViewMonth-1;
    this.widget.weekIndexOfFirstDayOfSelectedMonth = DateTime(this.widget.calendarCurrentViewYear,this.widget.calendarCurrentViewMonth,1).weekday -1;
  });
    }
    
    
  }

}

void buildDateItemsWithChangeState(){
  
  List<List<List<int>>> daysRowCC =  buildDateItems();
     setState(() {
      this.widget.dayRows = daysRowCC; 
     });
  }
  
  List<List<List<int>>> buildDateItems() {
    
    
      List<List<List<int>>> daysRowCC = [
    [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]],
    [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]],
    [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]],
    [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]],
    [[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0],[0,0,0]]
  ];
 int selectedMonthControlDay = 1;
   List<int> calculatedIndex = [];
   int workingMonth;
   int workingYear;
   workingMonth = this.widget.calendarCurrentViewMonth;
   workingYear = this.widget.calendarCurrentViewYear;
   daysRowCC[0][this.widget.weekIndexOfFirstDayOfSelectedMonth][0] = selectedMonthControlDay;
   daysRowCC[0][this.widget.weekIndexOfFirstDayOfSelectedMonth][1] = workingMonth;
   daysRowCC[0][this.widget.weekIndexOfFirstDayOfSelectedMonth][2] = workingYear;
   
   calculatedIndex.add(this.widget.weekIndexOfFirstDayOfSelectedMonth);
   int lastMonthControlDay = getMonthRange(this.widget.calendarCurrentViewMonth)[1];
   selectedMonthControlDay += 1;
   for(var i=this.widget.weekIndexOfFirstDayOfSelectedMonth-1;i>=0;i--){
     daysRowCC[0][i][0] = lastMonthControlDay;
     if (workingMonth-1==0){
       daysRowCC[0][i][1] = 12;
     } else{
       daysRowCC[0][i][1] = workingMonth-1;
     }

     if(workingMonth-1==0){
     daysRowCC[0][i][2] = workingYear-1;

     } else{
       daysRowCC[0][i][2] = workingYear;
     }
     calculatedIndex.add(i);
     lastMonthControlDay = lastMonthControlDay-1;
   }
   for(var j=0;j<daysRowCC.length;j++){
   for (var i=0;i<7;i++){
     if (j==0 && calculatedIndex.contains(i)){
        continue;
     } else{
     daysRowCC[j][i][0] = selectedMonthControlDay;
    daysRowCC[j][i][1] = workingMonth;
     
     
     daysRowCC[j][i][2] = workingYear;
     
     if(selectedMonthControlDay == getMonthRange(this.widget.calendarCurrentViewMonth)[1]){
       selectedMonthControlDay = 0;
       
       if (workingMonth + 1 > 12){
         print("caughtme");
         daysRowCC[j][i][2] = workingYear+1;
       }
       workingMonth = workingMonth +1;
     }
     
     
     selectedMonthControlDay += 1;
     

     }
   }
   }
   print(daysRowCC);
   this.widget.dayRows = daysRowCC;
   return daysRowCC;
    }

    void _onChanged() {
      print("current weekday is " + this.widget.currentWeekIndex.toString());
      if (this.widget.onChanged != null) {
        this.widget.onChanged(this.widget.selectedDayFull.join('/'));
      }
      dateController.text = this.widget.selectedDayFull.join('/');
    }

    void _onSubmitted() {
      if (this.widget.onChanged != null) {
        this.widget.onChanged(this.widget.selectedDayFull.join('/'));
      }
      dateController.text = this.widget.selectedDayFull.join('/');
    }

    List<int> getMonthRange(int index) {
      if (index == 9 || index == 4 || index == 6 || index == 11) {
        return [1, 30];
      } else if (index == 2) {
        if (this.widget.calendarCurrentViewYear % 4 == 0 && this.widget.calendarCurrentViewYear % 100 != 0 || this.widget.calendarCurrentViewYear % 400 == 0) {
          return [1, 29];
        } else {
          return [1, 28];
        }
      } else {
        return [1, 31];
      }
    }

    void setSelectedDay(List<int> value, int pos) {
      int numOfTimes = 0;
      int stateSelectedMonthValue = this.widget.calendarCurrentViewMonth;
      int stateSelectedYearValue = this.widget.calendarCurrentViewYear;
      buildDateItems().forEach((list) {
        if (list.contains(value)) {
          numOfTimes += 1;
        }
      });
      // print(numOfTimes);
      // print(pos);
      if (numOfTimes > 1 && pos == 0 && value[0] >= 25 || pos == 0 && value[0] >= 25) {
        // print("1 case");
        
        stateSelectedMonthValue = this.widget.calendarCurrentViewMonth - 1;
        if (this.widget.calendarCurrentViewMonth==1){  
          stateSelectedMonthValue = 12;
        }
        if (this.widget.calendarCurrentViewMonth==1){
          stateSelectedYearValue = stateSelectedYearValue - 1;
        }
      } else if (numOfTimes > 1 && pos == 0 && value[0] <= 7 ||
          pos == 0 && value[0] <= 7) {
        stateSelectedMonthValue = this.widget.calendarCurrentViewMonth;
        // print("2 case");
      } else if (numOfTimes > 1 && pos == 4 && value[0] >= 25 ||
          pos == 4 && value[0] >= 25) {
        stateSelectedMonthValue = this.widget.calendarCurrentViewMonth;
        // print("3 case");
      } else if (numOfTimes > 1 && pos == 4 && value[0] <= 7 ||
          pos == 4 && value[0] <= 7) {
        stateSelectedMonthValue = this.widget.calendarCurrentViewMonth + 1;
        if (this.widget.calendarCurrentViewMonth==12){
          stateSelectedYearValue = stateSelectedYearValue + 1;
        }

        // print("4 case");
      } else {
        stateSelectedMonthValue = this.widget.calendarCurrentViewMonth;
        // print("5 case");
      }
      // print(selectedMonthIndex);
      setState(() {
        this.widget.selectedMonthValue = stateSelectedMonthValue;
        
        this.widget.selectedYearValue = stateSelectedYearValue;
        this.widget.selectedDayFull = [value[0], stateSelectedMonthValue, this.widget.selectedYearValue];
        this.widget.colorPos = pos;
      });
      
    }

    Widget header() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.keyboard_arrow_left),
            onPressed: () {prevMonth();},
          ),
          Text(
            this.widget.months[this.widget.calendarCurrentViewMonth-1] + ' ' + this.widget.calendarCurrentViewYear.toString(),
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          IconButton(
            icon: Icon(Icons.keyboard_arrow_right),
            onPressed: () {
              print("moving to nextmonth view");
              nextMonth();},
          )
        ],
      );
    }

    Widget weekHeader() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: this.widget.weeks.map((value) {
          return Text(value, style: TextStyle(color: Colors.grey));
        }).toList(),
      );
    }

    Widget dayWidget(int index) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: buildDateItems()[index].map((value) {
            return InkWell(
              splashColor: GateManColors.primaryColor,
              onTap: () {
                //print(value.toString() + " tapped");
                
                setSelectedDay(value, index);
                //print("month tappe is " + months[selectedMonthIndex]);
                _onChanged();
                
                print(this.widget.currentDayFull);
                print(this.widget.selectedDayFull);
              },
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: this.widget.selectedDayFull[0] == value[0] &&
                              this.widget.selectedDayFull[1] == value[1] &&
                              this.widget.selectedDayFull[2] == value[2] &&
                              this.widget.colorPos == index
                          ? GateManColors.primaryColor
                          : this.widget.currentDayFull[0] == value[0] &&
                                  this.widget.currentDayFull[1] == value[1] &&
                                  this.widget.currentDayFull[2] == value[2]
                              ? GateManColors.primarySwatchColor.shade100
                              : Colors.white),
                  width: 30,
                  height: 30,
                  child: Center(
                      child: Text(
                    value[0].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: this.widget.selectedDayFull[0] == value[0] &&
                              this.widget.selectedDayFull[1] == value[1] &&
                              this.widget.selectedDayFull[2] == value[2] &&
                              this.widget.colorPos == index
                            ? Colors.white
                            : this.widget.currentDayFull[0] == value[0] &&
                                  this.widget.currentDayFull[1] == value[1] &&
                                  this.widget.currentDayFull[2] == value[2]
                                ? GateManColors.primaryColor
                                : Colors.black54),
                  ))),
            );
          }).toList());
    }

 
    @override
    Widget build(BuildContext context) {
      dateController.text = this.widget.selectedDayFull.join('/');
      if (this.widget.includeInput){
      return AnimatedSize(
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: (){toggleShowingDetail();},
                    child:CustomInputField(
                      textEditingController: dateController,
                      forCustomDatePicker: true,
                    enabled: false,
        hint: 'Enter arrival date',
        prefix: Icon(Icons.calendar_today),
        keyboardType: TextInputType.datetime,
      )),
                  this.widget.showingDetail?
                  Container(
          child: Column(
            children: <Widget>[
                  header(),
                  weekHeader(),
                  Divider(
                    color: Colors.grey,
                  ),
                  dayWidget(0),
                  dayWidget(1),
                  dayWidget(2),
                  dayWidget(3),
                  dayWidget(4),
                  FlatButton(
                    child: Text("DONE",
                        style: TextStyle(color: GateManColors.primaryColor)),
                    onPressed: () {
                      _onSubmitted();
                    },
                  )
            ],
          ),
          decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6)),
          margin: EdgeInsets.only(top: 3),
        ):Container(width: 0,height: 0,)],
              ), duration: Duration(milliseconds: 500), vsync: this,
      );
    }
    
    
    else{
      return Container(
          child: Column(
            children: <Widget>[
                  header(),
                  weekHeader(),
                  Divider(
                    color: Colors.grey,
                  ),
                  dayWidget(0),
                  dayWidget(1),
                  dayWidget(2),
                  dayWidget(3),
                  dayWidget(4),
                  FlatButton(
                    child: Text("DONE",
                        style: TextStyle(color: GateManColors.primaryColor)),
                    onPressed: () {
                      _onSubmitted();
                    },
                  )
            ],
          ),
          decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(6)),
          margin: EdgeInsets.only(top: 3),
        );

    }
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
