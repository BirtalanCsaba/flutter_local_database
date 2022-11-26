import 'package:fluttercrud/competition/models/competition_model.dart';
import 'package:fluttercrud/competition/repository/competitions_repository.dart';

class CompetitionsRepositoryImpl extends CompetitionsRepository {
  List<Competition> competitions = [];
  int nextId = 0;

  CompetitionsRepositoryImpl() {
    var comp1 = Competition.all(
        1,
        "Landscape photography",
        "landscape",
        60,
        "new camera",
        "Landscape photography in detail",
        DateTime.now().add(const Duration(days: 10)),
        false
    );
    var comp2 = Competition.all(
        1,
        "Women portrait",
        "portrait",
        30,
        "new camera",
        "Portrait photography in detail",
        DateTime.now().add(const Duration(days: 10)),
        false
    );
    comp1.id = getNextId();
    comp2.id = getNextId();
    competitions.add(comp1);
    competitions.add(comp2);
  }

  int getNextId() {
    return nextId++;
  }

  @override
  Future<Competition> add(Competition item) async {
    item.id = getNextId();
    competitions.add(item);
    return item;
  }

  @override
  Future<List<Competition>> get() async {
    return competitions;
  }

  @override
  Future<void> update(Competition item) async {
    int index = competitions.indexWhere((element) => element.id == item.id);
    competitions[index] = item;
  }

  @override
  Future<void> delete(int? id) async {
    if (id == null) {
      return;
    }
    competitions.removeWhere((element) => element.id == id);
  }

  @override
  Future<Competition> findById(int? id) async {
    if (id == null) {
      throw Exception("Id is null");
    }
    Competition foundCompetition = competitions.firstWhere((element) => element.id == id);
    var theComp = Competition.all(
      foundCompetition.judgeId,
      foundCompetition.title,
      foundCompetition.category,
      foundCompetition.maxPoints,
      foundCompetition.firstPlacePrize,
      foundCompetition.description,
      foundCompetition.submissionDeadline,
      foundCompetition.isFinished,
    );
    theComp.id = id;
    return theComp;
  }

}