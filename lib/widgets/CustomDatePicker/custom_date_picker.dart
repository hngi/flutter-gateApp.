// import 'package:flutter/material.dart';
// import 'package:backup_cash/src/helper/helper.dart';
// import 'package:intl/intl.dart';

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
