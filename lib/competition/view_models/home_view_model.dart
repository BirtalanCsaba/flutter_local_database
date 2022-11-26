import 'package:flutter/cupertino.dart';
import 'package:fluttercrud/competition/repository/competitions_repository.dart';
import 'package:fluttercrud/competition/services/DatabaseHelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as developer;

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
    List<Competition>? items = [];
    try {
      items = await DatabaseHelper.getAll();
      if (items == null) {
        return;
      }
    } on DatabaseException catch(ex) {
      developer.log(ex.toString());
      throw Exception("Cannot fetch data");
    }
    await competitionsRepository.populate(items);
    competitions = await competitionsRepository.get();
    notifyListeners();
  }

  Future<void> add(Competition competition) async {
    try {
      await DatabaseHelper.add(competition);
    } on DatabaseException catch(ex) {
      developer.log(ex.toString(), name: runtimeType.toString());
      throw Exception("Cannot add data");
    }
    await competitionsRepository.add(competition);
    notifyListeners();
  }

  Future<void> update(Competition competition) async {
    try {
      await DatabaseHelper.update(competition);
    } on DatabaseException catch(ex) {
      developer.log(ex.toString(), name: runtimeType.toString());
      throw Exception("Cannot update data");
    }
    await competitionsRepository.update(competition);
    int index = competitions.indexWhere((element) => element.id == competition.id);
    competitions[index] = competition;
    notifyListeners();
  }

  Future<void> delete(int id) async {
    try {
      await DatabaseHelper.delete(id);
    } on DatabaseException catch(ex) {
      developer.log(ex.toString(), name: runtimeType.toString());
      throw Exception("Cannot update data");
    }
    await competitionsRepository.delete(id);
    competitions.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<Competition> findById(int? id) async {
    return competitionsRepository.findById(id);
  }
}
