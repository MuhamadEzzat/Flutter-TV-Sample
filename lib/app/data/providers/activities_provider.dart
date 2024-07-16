import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../core/Constants/constants.dart';
import '../models/activities_model.dart';
import '../services/dio_client.dart';

class ActivitiesAPIProvider {
  final DioClient _dioClient = DioClient.instance;

  Future<Activity> makeActivitiesRequest(int activityId) async {
    try {
      Response response = await _dioClient.post(
          AppConstants.getActivityDetails +
              '?Activity_ID=' +
              activityId.toString());

      return Activity.fromJson(response.data);
    } catch (error) {
      debugPrint("Exception: $error");
      return Activity.withError("$error");
    }
  }

  Future<Activity> getGeneralActivityRequest() async {
    try {
      Response response = await _dioClient.get(AppConstants.getGeneralActivity);
      return Activity.fromJson(response.data);
    } catch (error) {
      debugPrint("Exception: $error");
      return Activity.withError("$error");
    }
  }

  Future<bool> checkActivityTrackingRequest(int activityId, int childId) async {
    try {
      Response response = await _dioClient
          .get(AppConstants.checkActivityTracking, queryParameters: {
        "Activity_ID": activityId,
        "Child_ID": childId,
      });
      return response.data;
    } catch (error) {
      debugPrint("Exception: $error");
      return false;
    }
  }
}
