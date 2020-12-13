import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QACard extends StatelessWidget {
  final String question;
  final String answer;
  final bool showAnswer;
  final Function onTap;
  QACard({
    @required this.question,
    @required this.onTap,
    this.answer = '',
    this.showAnswer = false,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(0),
            color: Color(0xff2A2F33),
            elevation: 0,
            child: Center(
                child: ListTile(
              isThreeLine: showAnswer,
              trailing: Icon(
                  showAnswer
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.arrow_forward_ios_rounded,
                  size: showAnswer ? 44 : 24,
                  color: Color(0xffFABF03)),
              title: Text(
                question,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffF2F2F2)),
              ),
              subtitle: showAnswer
                  ? Text(
                      answer,
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey),
                    )
                  : null,
            )),
          ),
          Divider(height: 0, thickness: 1, color: Colors.grey[700]),
        ],
      ),
    );
  }
}
