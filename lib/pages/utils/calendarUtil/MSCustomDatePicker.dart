
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MSCustomDatePicker extends StatelessWidget {
  MSCustomDatePicker({
    Key? key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    this.helpText,
    this.cancelText = "取消",
    this.sureText = "确定",
  });

  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final String? helpText;
  final String cancelText;
  final String sureText;

  DateTime? _chooseDateTime;

  @override
  Widget build(BuildContext context) {
    _chooseDateTime = initialDate;
    final ValueNotifier<DateTime> _chooseDateValueNoti =
    ValueNotifier<DateTime>(initialDate);

    // final double textScaleFactor = math.min(MediaQuery.of(context).textScaleFactor, 1.3);
    final Size _calendarPortraitDialogSize = Size(330.0, 518.0);
    // final Size dialogSize = _calendarPortraitDialogSize * textScaleFactor;

    final MaterialLocalizations localizations =
    MaterialLocalizations.of(context);

    final header = SizedBox(
      height: 120,
      child: Material(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: EdgeInsetsDirectional.only(start: 24, end: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                helpText ?? "",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[200]),
              ),
              const Flexible(child: SizedBox(height: 38)),
              ValueListenableBuilder<DateTime>(
                valueListenable: _chooseDateValueNoti,
                builder: (context, datetime, child) {
                  final String dateText =
                  localizations.formatMediumDate(datetime);
                  return Text(
                    dateText,
                    textScaleFactor: 2.0,
                    style: TextStyle(color: Colors.white),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );

    final picker = CalendarDatePicker(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      currentDate: DateTime.now(),
      onDateChanged: (datetime) {
        _chooseDateTime = datetime;
        _chooseDateValueNoti.value = datetime;
        print("DateChanged $datetime");
      },
    );

    final Widget actions = Container(
      alignment: AlignmentDirectional.centerEnd,
      constraints: const BoxConstraints(minHeight: 52.0),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: OverflowBar(
        spacing: 8,
        children: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(_chooseDateTime);
            },
            child: Text(sureText),
          ),
        ],
      ),
    );

    return Dialog(
      insetPadding:
      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        height: 20,
        width: 20,
        curve: Curves.easeIn,
        child: Builder(
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                header,
                Expanded(child: picker),
                actions,
              ],
            );
          },
        ),
      ),
    );
  }
}
