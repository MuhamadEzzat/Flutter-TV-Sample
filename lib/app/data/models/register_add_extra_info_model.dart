class RegisterAddExtraInfoModel {
  ParentRegisterExtraInfo parentInfo;
  List<KidRegisterExtraInfo> kids;
  bool loading;
  int step;

  RegisterAddExtraInfoModel(
      {required this.parentInfo,
      required this.kids,
      required this.loading,
      required this.step});
}

class ParentRegisterExtraInfo {
  String? gender;
  String? name;
  int? birthDateYear;

  ParentRegisterExtraInfo({this.gender, this.birthDateYear, this.name});
}

class KidRegisterExtraInfo {
  String name;
  int age;
  String avatar;
  bool isAvatarFile;
  String gender;

  KidRegisterExtraInfo(
      {required this.name,
      required this.age,
      required this.avatar,
      required this.gender,
      required this.isAvatarFile});
}
