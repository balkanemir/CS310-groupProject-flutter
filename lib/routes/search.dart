import 'package:flutter/material.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';

import 'mainpage.dart';

class Search extends StatefulWidget {
  static const String routeName = '/search';

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  static const historyLength = 5;
  List<String> _searchHistory = ["selam", "ben", "püren"];
  List<String> filteredSearchHistory = [];
  late String selectedTerm;

  List<String> filterSearchTerms(
      @required String? filter) {
    if (filter != null && filter.isNotEmpty)
      {
        return _searchHistory.reversed
            .where((term) => term.startsWith(filter)).toList();
      }
    else{
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term){
    if(_searchHistory.contains(term)){
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if(_searchHistory.length > historyLength){
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(null);
  }

  void deleteSearchTerm(String term){
    _searchHistory.removeWhere((t) => t ==term);
    filteredSearchHistory = filterSearchTerms(null);
  }

  void putSearchTermFirst(String term){
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  @override
  void initState(){
    super.initState();
    filteredSearchHistory = filterSearchTerms(null);
  }
  int _currentindex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentindex,
          backgroundColor: primaryPink200,
          selectedItemColor: textOnSecondaryWhite,
          unselectedItemColor: secondaryPink800,
          selectedFontSize: 18.0,
          unselectedFontSize: 18.0,
          onTap: (value) {
            setState(() => _currentindex = value);
            if (_currentindex == 0) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MainPage()));
            }
            if (_currentindex == 1) {
              //Search Navigator
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Search()));
            }
            if (_currentindex == 2) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Shuffle()));
            }
            if (_currentindex == 3) {
              // Add Navigator
            }
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shuffle), label: 'Shuffle'),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add')
          ]),
      body: Text('Zaaaa'),
    );
  }
}
