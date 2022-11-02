import 'package:hive/hive.dart';

class ExperienceService {
  static final ExperienceService instance = ExperienceService._internal();
  static Box? box;

  factory ExperienceService() {
    return instance;
  }

  Future openBox() async {
    await Hive.openBox('experience');
    box = Hive.box('experience');
  }

  ExperienceService._internal();

  String retrieveExperience() {
    return box?.get('preference') ?? 'empty';
  }

  void setExperience(String preference) {
    box?.put('preference', preference);
  }
}
