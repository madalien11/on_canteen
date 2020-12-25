import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QACard extends StatefulWidget {
  final String question;
  final String answer;
  final String name;
  final String phoneNum;
  final Map<int, bool> showAnswerMap;
  final int answerId;
  final int questionId;
  QACard({
    @required this.question,
    this.answerId,
    this.showAnswerMap,
    this.questionId,
    this.answer = '',
    this.name = '',
    this.phoneNum = '',
  });

  @override
  _QACardState createState() => _QACardState();
}

class _QACardState extends State<QACard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.showAnswerMap[widget.questionId] =
              !widget.showAnswerMap[widget.questionId];
        });
      },
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(0),
            color: Color(0xff2A2F33),
            elevation: 0,
            child: Center(
                child: ListTile(
              isThreeLine: widget.showAnswerMap[widget.questionId],
              trailing: Icon(
                  widget.showAnswerMap[widget.questionId]
                      ? Icons.keyboard_arrow_down_rounded
                      : Icons.arrow_forward_ios_rounded,
                  size: widget.showAnswerMap[widget.questionId] ? 42 : 24,
                  color: Color(0xffFABF03)),
              title: Text(
                widget.question,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffF2F2F2)),
              ),
              subtitle: widget.showAnswerMap[widget.questionId]
                  ? Text(
                      widget.answer,
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
