import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/values/localization/local_keys.dart';

RxList<Route> routeStack = RxList([]);

class AppNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    print(
        "AppNavigatorObserver didPush ${route.settings.arguments} -**- ${route.settings.name}");

    if (!routeStack
        .any((element) => element.settings.name == route.settings.name)) {
      super.didPush(route, previousRoute);
      routeStack.add(route);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    routeStack.remove(route);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    routeStack.remove(route);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);

    routeStack.remove(oldRoute);
    routeStack.add(newRoute!);
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    super.didStartUserGesture(route, previousRoute);

    routeStack.add(route);
  }
}

String routeName(Route route, bool? isSeries) {
  final dynamic arguments = route.settings.arguments;
  if (arguments != null &&
      arguments.runtimeType.toString().trim() == "List<Map<String, Object?>>" &&
      arguments[2]['kContentName'] != null &&
      route.settings.name != "/child-episode-details-new") {
    print("routeName 00 ${route.settings.name}");

    return arguments[2]['kContentName'];
  } else {
    print("routeName ${route.settings.name}");
    if (route.settings.name == "/child-series-new") {
      return isSeries! ? LocalKeys.kSeries.tr : LocalKeys.kDiscover.tr;
    }
    if (route.settings.name == "/child-games-new") {
      return LocalKeys.kGames.tr;
    }
    if (route.settings.name == "/child-read-with-jeel-new") {
      return LocalKeys.kReadWithJeel.tr;
    }
    if (route.settings.name == "/child-radios-new") {
      return LocalKeys.kJeelRadio.tr;
    }
    if (route.settings.name == "/child-songs-new") {
      return LocalKeys.kSongs.tr;
    }
    if (route.settings.name == "/child-serial-details-new") {
      return LocalKeys.kAllEpisodes.tr;
    } else if (route.settings.name == "/child-episode-details-new") {
      return LocalKeys.kEpisode.tr;
    } else if (route.settings.name == "/josoor-welcome") {
      return LocalKeys.kEducationSystem.tr;
    } else if (route.settings.name == "/josoor-home") {
      return LocalKeys.kJeelValues.tr;
    } else if (route.settings.name == "/josoor-series" ||
        route.settings.name == "/josoor-radio" ||
        route.settings.name == "/josoor-song" ||
        route.settings.name == "/josoor-subvalue") {
      return LocalKeys.kValueCreativity.tr;
    } else if (route.settings.name == "/josoor-subvalue-details") {
      return LocalKeys.kEpisodeIncludeActivity.tr;
    }
    if (route.settings.name == "/section-content-all") {
      return LocalKeys.kAllSections.tr;
    }
    return route.settings.name!;
  }
}
