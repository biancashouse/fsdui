import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui/src/snippet/pnodes/editors/date_range_button.dart';

class DateRangePNode extends PNode {
  int? fromValue;
  int? untilValue;
  final ValueChanged<DateRange?> onRangeChange;

  DateRangePNode({
    required this.fromValue,
    required this.untilValue,
    required this.onRangeChange,
    required super.snode,
    required super.name,
  });

  @override
  void revertToOriginalValue() {
    onRangeChange(null);
  }

  @override
  Widget toPropertyNodeContents(BuildContext context) {
    
    return DateRangeButton(
      from: fromValue,
      until: untilValue,
      onChangeF: (DateRange range) {
        fromValue = range.from;
        untilValue = range.until;
        onRangeChange.call(range);
      },
       
    );
  }
}
