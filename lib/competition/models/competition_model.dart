import 'dart:core';

import 'package:fluttercrud/competition/models/base_model.dart';

class Competition extends BaseModel<int> {
  int? judgeId;
  String title = "";
  String category = "";
  int maxPoints = 0;
  String firstPlacePrize = "";
  String description = "";
  DateTime submissionDeadline = DateTime.now();
  bool isFinished = false;

  Competition();

  Competition.all(
      this.judgeId,
      this.title,
      this.category,
      this.maxPoints,
      this.firstPlacePrize,
      this.description,
      this.submissionDeadline,
      this.isFinished);

}