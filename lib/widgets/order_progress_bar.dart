import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/controllers/progress_bar_controller.dart';
import 'package:rs_books/styles.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ProgressBarItem extends StatelessWidget {
  final String stepLabel;
  final IconData icon;
  final bool isFirst;
  final bool isLast;
  final ProgressItemState itemState;
  const ProgressBarItem({
    Key? key,
    this.itemState = ProgressItemState.incomplete,
    required this.stepLabel,
    required this.icon,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  Color getColorForState(ProgressItemState state) {
    switch (state) {
      case ProgressItemState.active:
      case ProgressItemState.complete:
        return Colors.green;
      case ProgressItemState.incomplete:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Color getColorForStepSequenceIcon(ProgressItemState state) {
    switch (state) {
      case ProgressItemState.active:
        return Colors.green;
      case ProgressItemState.complete:
        return Colors.white;
      case ProgressItemState.incomplete:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  Color getColorForStepSequenceLabel(ProgressItemState state) {
    switch (state) {
      case ProgressItemState.active:
        return Colors.green;
      case ProgressItemState.complete:
        return Colors.black;
      case ProgressItemState.incomplete:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TimelineTile(
          alignment: TimelineAlign.center,
          axis: TimelineAxis.horizontal,
          isFirst: isFirst,
          isLast: isLast,
          endChild: Container(
            alignment: Alignment.center,
            // height: 100,
            child: Text(
              stepLabel.toUpperCase(),
              style: TextStyles.callout1.copyWith(
                color: getColorForStepSequenceLabel(itemState),
                fontWeight: itemState == ProgressItemState.complete
                    ? FontWeight.bold
                    : null,
              ),
            ),
          ),
          indicatorStyle: IndicatorStyle(
            width: 36,
            height: 36,
            drawGap: true,
            indicator: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: getColorForState(itemState), width: 3),
                color: itemState == ProgressItemState.complete
                    ? getColorForState(itemState)
                    : null,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: getColorForStepSequenceIcon(itemState),
                ),
              ),
            ),
            padding: EdgeInsets.symmetric(
              vertical: Insets.sm,
            ),
          ),
          afterLineStyle: LineStyle(
            thickness: 3,
            color: itemState == ProgressItemState.complete
                ? Colors.green
                : Colors.grey,
          ),
          beforeLineStyle:
              LineStyle(thickness: 3, color: getColorForState(itemState)),
        ),
        if (!isLast)
          SizedBox(
            width: 10,
            child: TimelineTile(
              alignment: TimelineAlign.center,
              axis: TimelineAxis.horizontal,
              hasIndicator: false,
              beforeLineStyle: LineStyle(
                thickness: 3,
                color: itemState == ProgressItemState.complete
                    ? Colors.green
                    : Colors.grey,
              ),
            ),
          ),
      ],
    );
  }
}

class OrderProgressStatusBar extends StatelessWidget {
  List<ProgressBarItem> getProgressItemsFromMap(
    Map<ProgressBarSteps, ProgressItemState> itemStatemap,
  ) {
    return [
      ProgressBarItem(
        stepLabel: "Shipping",
        isFirst: true,
        icon: Icons.local_shipping,
        itemState: itemStatemap[ProgressBarSteps.shipping]!,
      ),
      ProgressBarItem(
        stepLabel: "Payement",
        icon: Icons.payment,
        itemState: itemStatemap[ProgressBarSteps.payment]!,
      ),
      ProgressBarItem(
        stepLabel: "Confirmation",
        isLast: true,
        icon: Icons.confirmation_num,
        itemState: itemStatemap[ProgressBarSteps.confirmation]!,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProgressBarController>(
      builder: (
        BuildContext context,
        ProgressBarController progressBarController,
        Widget? child,
      ) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: getProgressItemsFromMap(progressBarController.itemStatemap),
        );
      },
    );
  }
}
