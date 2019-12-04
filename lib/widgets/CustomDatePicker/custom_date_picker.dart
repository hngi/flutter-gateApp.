import 'package:flutter/material.dart';
import 'package:xgateapp/main.dart';
import 'package:xgateapp/utils/colors.dart';
import 'package:xgateapp/widgets/CustomInputField/custom_input_field.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  
  DateTime minimumAllowedDate;
  TextEditingController dateController = TextEditingController();


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

  bool useSelectedDate = true;

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
  
  List<int> selectedDate;
 CustomDatePicker({this.selectedDate,this.showingDetail,this.includeInput = false,@required this.onChanged,@required this.onSaved,this.now,this.minimumAllowedDate,this.maximumAllowedDate,@required this.dateController}):assert(minimumAllowedDate==null&&maximumAllowedDate==null?true:minimumAllowedDate!=null&&maximumAllowedDate!=null?minimumAllowedDate.compareTo(maximumAllowedDate)<1:
minimumAllowedDate==null&&maximumAllowedDate!=null?DateTime.now().compareTo(maximumAllowedDate)<1:minimumAllowedDate!=null&&maximumAllowedDate==null?minimumAllowedDate.compareTo(DateTime.now())<1:true){
  if(this.now==null){
    this.now = DateTime.now();
  }
  // if(this.includeInput==true){
  //   showingDetail=false;
  // }
   
  this.currentMonthValue = now.month;
  this.currentWeekIndex = now.weekday - 1;
  this.currentYear = now.year;
  this.currentDay = now.day;
  this.currentMonthIndex = this.currentMonthValue - 1;
this.currentDayFull = [this.currentDay, this.currentMonthValue, this.currentYear];
  selectedMonthValue = this.selectedDate!=null?this.selectedDate[1]:now.month;
  calendarCurrentViewMonth = now.month;
  calendarCurrentViewYear= now.year;
  selectedYearValue = this.selectedDate!=null?this.selectedDate[2]:now.year;
  weekIndexOfFirstDayOfSelectedMonth = DateTime(currentYear,currentMonthValue,1).weekday -1;
  
  weeks = ['MON', 'TUE', 'WED', 'THUR', 'FRI', 'SAT', 'SUN'];

  print(this.selectedDate);
  selectedDayFull = this.selectedDate!=null?[this.selectedDate[0],this.selectedDate[1],this.selectedDate[2]]:currentDayFull;
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

@override
void initState() {
    // TODO: implement initState
    super.initState();
    
  }
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
      this.widget.useSelectedDate = false;
   this.widget.calendarCurrentViewMonth = 1;
   this.widget.calendarCurrentViewYear = this.widget.calendarCurrentViewYear + 1;
  this.widget.weekIndexOfFirstDayOfSelectedMonth = DateTime(this.widget.calendarCurrentViewYear,this.widget.calendarCurrentViewMonth,1).weekday -1;
  });
  } else{
  setState(() {
    this.widget.useSelectedDate = false;
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
          this.widget.useSelectedDate = false;
   this.widget.calendarCurrentViewMonth = 12;
    this.widget.calendarCurrentViewYear = this.widget.calendarCurrentViewYear-1;
    this.widget.weekIndexOfFirstDayOfSelectedMonth = DateTime(this.widget.calendarCurrentViewYear,this.widget.calendarCurrentViewMonth,1).weekday -1;
  });
    }else{
  setState(() {
    this.widget.useSelectedDate = false;
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
       
       
       workingMonth = workingMonth +1;
       if (workingMonth > 12){
         print("caughtme");
         workingYear = workingYear+1;
         workingMonth = 1;
       }
      
     }

     //daysRowCC[j][i][2] = workingYear;
     
     selectedMonthControlDay += 1;
     

     }
   }
   }
  //  print(daysRowCC);
   this.widget.dayRows = daysRowCC;
   return daysRowCC;
    }

    void _onChanged() {
      // print("current weekday is " + this.widget.currentWeekIndex.toString());
      if (this.widget.onChanged != null) {
        this.widget.onChanged(this.widget.selectedDayFull.join('/'));
      }
      this.widget.dateController.text = this.widget.selectedDayFull.join('/');
    }

    void _onSubmitted() {
      if (this.widget.onChanged != null) {
        this.widget.onChanged(this.widget.selectedDayFull.join('/'));
        if (this.widget.selectedDate != null){
          this.widget.onSaved(this.widget.selectedDayFull.join('/'));
        }
      }
      this.widget.dateController.text = this.widget.selectedDayFull.join('/');
      toggleShowingDetail();
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
          stateSelectedMonthValue = 1;
        }

        // print("4 case");
      } else {
        stateSelectedMonthValue = this.widget.calendarCurrentViewMonth;
        // print("5 case");
      }
      // print([stateSelectedYearValue,stateSelectedMonthValue,value[0]]);
      // print([this.widget.minimumAllowedDate.year,this.widget.minimumAllowedDate.month,this.widget.minimumAllowedDate.day]);
      // print(selectedMonthIndex);
      if(this.widget.minimumAllowedDate!=null && DateTime(stateSelectedYearValue,stateSelectedMonthValue,value[0]).compareTo(DateTime(this.widget.minimumAllowedDate.year,this.widget.minimumAllowedDate.month,this.widget.minimumAllowedDate.day))<0){

      } else if(DateTime(stateSelectedYearValue,stateSelectedMonthValue,value[0]).compareTo(DateTime(this.widget.minimumAllowedDate.year,this.widget.minimumAllowedDate.month,this.widget.minimumAllowedDate.day))==0 || !(this.widget.minimumAllowedDate!=null && DateTime(stateSelectedYearValue,stateSelectedMonthValue,value[0]).compareTo(this.widget.minimumAllowedDate)<0)){
      setState(() {
        this.widget.selectedMonthValue = stateSelectedMonthValue;
        
        this.widget.selectedYearValue = stateSelectedYearValue;
        this.widget.selectedDayFull = [value[0], stateSelectedMonthValue, this.widget.selectedYearValue];
        this.widget.colorPos = pos;
      });
      }
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
              // print("moving to nextmonth view");
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
                
                // print(this.widget.currentDayFull);
                // print(this.widget.selectedDayFull);
              },
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (this.widget.selectedDayFull[0] == value[0] &&
                              this.widget.selectedDayFull[1] == value[1] &&
                              this.widget.selectedDayFull[2] == value[2]) || (
                                this.widget.selectedDate != null &&
                                this.widget.selectedDate[0] == value[0] &&
                                this.widget.selectedDate[1] == value[1] &&
                                this.widget.selectedDate[2] == value[2]
                              ) &&
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
                        color: (this.widget.selectedDayFull[0] == value[0] &&
                              this.widget.selectedDayFull[1] == value[1] &&
                              this.widget.selectedDayFull[2] == value[2] ) || (
                                this.widget.selectedDate != null &&
                                this.widget.selectedDate[0] == value[0] &&
                                this.widget.selectedDate[1] == value[1] &&
                                this.widget.selectedDate[2] == value[2]
                              )  &&
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
      this.widget.dateController.text = this.widget.selectedDayFull.join('/');
      if(this.widget.selectedDate != null && this.widget.useSelectedDate){
      print('selected dare us not null');
      print(this.widget.selectedDate);
      this.widget.calendarCurrentViewMonth = this.widget.selectedDate[1];
      this.widget.calendarCurrentViewYear = this.widget.selectedDate[2];
    }
    this.widget.useSelectedDate = true;
      if (this.widget.includeInput){
      return AnimatedSize(
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: (){toggleShowingDetail();},
                    child:CustomInputField(
                      textEditingController: this.widget.dateController,
                      forCustomDatePicker: true,
                    enabled: false,
        hint: 'Enter arrival date',
        prefix: Icon(Icons.calendar_today,color: GateManColors.primaryColor,),
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

