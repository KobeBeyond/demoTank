import 'package:flutter/material.dart';
// import 'package:demo/model/categoryGoodsList.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

class SearchTextProvide with ChangeNotifier {
  String searchText = '';
  bool isSearching = false;

  getSearchText(String tempText) {
    searchText = tempText;
    notifyListeners();
  }

  changeSearchState(bool val) {
    if (val) {
      isSearching = false;
    } else {
      isSearching = true;
    }
  }
}
