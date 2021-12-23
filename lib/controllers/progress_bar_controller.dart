import 'package:flutter/material.dart';

enum ProgressItemState { complete, active, incomplete }
enum ProgressBarSteps { shipping, payment, confirmation }

class ProgressBarController with ChangeNotifier {
  Map<ProgressBarSteps, ProgressItemState> itemStatemap = {
    ProgressBarSteps.shipping: ProgressItemState.incomplete,
    ProgressBarSteps.payment: ProgressItemState.incomplete,
    ProgressBarSteps.confirmation: ProgressItemState.incomplete,
  };

  void setStepState(Map<ProgressBarSteps, ProgressItemState> newStates) {
    for (final step in newStates.keys) {
      itemStatemap[step] = newStates[step]!;
    }
    notifyListeners();
  }
}
