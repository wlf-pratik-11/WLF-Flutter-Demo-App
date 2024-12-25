import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:main_app_demo/commons/common_functions.dart';

class DatetimeScreen extends StatefulWidget {
  const DatetimeScreen({super.key});

  @override
  State<DatetimeScreen> createState() => _DatetimeScreenState();
}

class _DatetimeScreenState extends State<DatetimeScreen> {
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar("Date Time Demo"),
      body: _buildBody(today),
    );
  }
}

Widget _buildBody(DateTime today) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(25, 30, 25, 30),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            DateFormat('dd MMMM yyyy').format(today),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
          ),
          SizedBox(height: 20,),
          Text(
            DateFormat('dd MMM yyyy ').format(today),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
          ),
          SizedBox(height: 20,),
          Text(
            DateFormat('dd-MMMM-yyyy hh:MM aaa z').format(today),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
          ),
          SizedBox(height: 20,),
          Text(
            DateFormat('EE dd MMMM yyyy').format(today),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
          ),
          SizedBox(height: 20,),
          Text(
            DateFormat('EEEE dd/MM/yyyy hh:MM:ss aaa ').format(today),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
          ),
          SizedBox(height: 20,),
          Text(
            DateFormat('EE.LLLL.yyyy KK:MM:ss aaa z').format(today),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
          ),
          SizedBox(height: 20,),
          Text(
            DateFormat('E.MMM.yyyy HH:mm:ss aaa z').format(today),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),
          ),
        ],
      ),
    ),
  );
}
