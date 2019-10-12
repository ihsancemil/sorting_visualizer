import 'package:flutter/material.dart';
import 'package:sorting_visualizer/widgets/element_widget.dart';

class ListWidget extends StatelessWidget {

  final List<double> list;
  final elementPadding;

  const ListWidget({Key key, this.list, this.elementPadding}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double elementWidgetWidth = _getElementWidgetWidth(context, constraints);
        double elementWidgetHeightRatio = _getElementWidgetHeight(context, constraints);

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: list.map(
            (element) => ElementWidget(
              height: element * elementWidgetHeightRatio,
              width: elementWidgetWidth,
              padding: elementPadding,
            ),
          ).toList(),
        );
      }
    );
  }

  double _getElementWidgetWidth(BuildContext context, BoxConstraints constraints){
    return constraints.maxWidth / (list.length); 
  }

  double _getElementWidgetHeight(BuildContext context, BoxConstraints constraints){
    double max = _getMax(this.list);

    return constraints.maxHeight / max;
  }

  double _getMax(List<double> list){
    if (list.length == 0) throw ArgumentError("Length should not be 0");
    if (list.length == 1) return list[0];
    double max = list[0];

    for (int i = 1; i < list.length; i++) {
      if (list[i] > max) {
        max = list[i];
      }
    }

    return max;
  }
}