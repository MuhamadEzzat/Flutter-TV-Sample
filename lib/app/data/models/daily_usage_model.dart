class DailyUsage {
  List<Periods>? periods;
  double? averageDailyUsage;
  double? totalUsage;
  double totalHoursSpent = 0;
  DurationOfUse? durationOfUse;
  TimeOfUse? timeOfUse;
  bool loading = false;
  String? error;

  DailyUsage({
    this.periods,
    this.averageDailyUsage,
    this.totalUsage,
    this.error,
    this.durationOfUse,
    this.timeOfUse,
  });

  DailyUsage.loading() : loading = true;

  DailyUsage.fromJson(Map<String, dynamic> json) {
    if (json['periods'] != null) {
      periods = <Periods>[];
      json['periods'].forEach((v) {
        periods?.add(Periods.fromJson(v));
      });

      for (int i = 0; i < (periods?.length ?? 0); i++) {
        totalHoursSpent += periods![i].duration.toDouble();
      }
    }
    durationOfUse = json['durationOfUse'] != null
        ? DurationOfUse.fromJson(json['durationOfUse'])
        : null;
    timeOfUse = json['timeOfUse'] != null
        ? TimeOfUse.fromJson(json['timeOfUse'])
        : null;
    averageDailyUsage = json['averageDailyUsage'] != null
        ? json['averageDailyUsage'].toDouble()
        : 0;
    totalUsage =
        json['averageDailyUsage'] != null ? json['totalUsage'].toDouble() : 0;
  }
  DailyUsage.withError(String errorValue)
      : periods = null,
        averageDailyUsage = -1,
        totalUsage = -1,
        error = errorValue;
}

class Periods {
  String? periodStartDate;
  String? periodEndDate;
  int? numberOfPeriodSessions;
  double? percentage;
  // ignore: prefer_typing_uninitialized_variables
  var duration;

  Periods({
    this.periodStartDate,
    this.periodEndDate,
    this.numberOfPeriodSessions,
    this.percentage,
    this.duration,
  });

  Periods.fromJson(Map<String, dynamic> json) {
    periodStartDate = json['periodStartDate'];
    periodEndDate = json['periodEndDate'];
    numberOfPeriodSessions = json['numberOfPeriodSessions'];
    percentage = json['percentage'];
    duration = json['duration'];
  }
}

class DurationOfUse {
  String? text;
  String? articleUrl;
  String? programUrl;
  int? id;
  int? duration;

  DurationOfUse({
    this.text,
    this.articleUrl,
    this.programUrl,
    this.id,
    this.duration,
  });

  DurationOfUse.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    articleUrl = json['articleUrl'];
    programUrl = json['programUrl'];
    id = json['id'];
    duration = json['duration'];
  }
}

class TimeOfUse {
  String? text;
  String? articleUrl;
  String? programUrl;
  int? id;

  TimeOfUse({
    this.text,
    this.articleUrl,
    this.programUrl,
    this.id,
  });

  TimeOfUse.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    articleUrl = json['articleUrl'];
    programUrl = json['programUrl'];
    id = json['id'];
  }
}
