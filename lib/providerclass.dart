import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'database.dart';

class ProviderClass extends ChangeNotifier {
  List<Map<String, dynamic>> _notes = [];

  UnmodifiableListView<Map<String, dynamic>> get note {
    return UnmodifiableListView(_notes);
  }

  int get notecount => _notes.length;

  void refreshNotes() async {
    final data = await SQLHelper.getItems();
    _notes = data;
    notifyListeners();
  }

  Future<void> addTask(String text) async {
    await SQLHelper.createItem(text);
    refreshNotes();
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    await SQLHelper.deleteItem(id);
    refreshNotes();
    notifyListeners();
  }

  Future<void> deleteAllTasks() async {
    await SQLHelper.deleteAllItem();
    refreshNotes();
    notifyListeners();
  }

  bool isChecked = false;

  void changeIsChecked() {
    isChecked = !isChecked;
    notifyListeners();
  }
}
