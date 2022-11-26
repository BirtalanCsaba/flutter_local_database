import 'package:flutter/cupertino.dart';
import 'package:fluttercrud/competition/repository/competitions_repository.dart';

import '../models/competition_model.dart';

class HomeViewModel extends ChangeNotifier {

  HomeViewModel({
    required this.competitionsRepository,
  });

  List<Competition> competitions = [];

  final CompetitionsRepository competitionsRepository;

  DateTime selectedDate = DateTime.now();
  int maxPoints = 0;

  Future<void> fetchData() async {
    competitions = await competitionsRepository.get();
    notifyListeners();
  }

  Future<void> add(Competition competition) async {
    await competitionsRepository.add(competition);
    // competitions.add(competition);
    notifyListeners();
  }

  Future<void> update(Competition competition) async {
    await competitionsRepository.update(competition);
    int index = competitions.indexWhere((element) => element.id == competition.id);
    competitions[index] = competition;
    notifyListeners();
  }

  Future<void> delete(int id) async {
    await competitionsRepository.delete(id);
    competitions.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<Competition> findById(int? id) async {
    return competitionsRepository.findById(id);
  }

  // void _updateStates() {
  //   titleInputController.value = TextEditingValue();
  //   categoryInputController.value =
  //       TextEditingValue(text: _competition.category);
  //   _descriptionInputController.value =
  //       TextEditingValue(text: _competition.description);
  //   _firstPlacePrizeInputController.value =
  //       TextEditingValue(text: _competition.firstPlacePrize);
  //   _maxPoints = _competition.maxPoints == null ? 0 : _competition.maxPoints!;
  // }
}
