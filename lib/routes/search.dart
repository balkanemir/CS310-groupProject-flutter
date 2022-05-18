import 'package:flutter/material.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';

import 'mainpage.dart';

class Search extends StatefulWidget {
  static const String routeName = '/search';

  @override
  _SearchState createState() => _SearchState();
}


class _SearchState extends State<Search> {
  static const historyLength = 5;
  List<String> _searchHistory = [];
  List<String> filteredSearchHistory = [];

  String selectedTerm ="";

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

  FloatingSearchBarController controller = FloatingSearchBarController();

  @override
  void initState(){
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(null);
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
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
      body: FloatingSearchBar(
        controller: controller,
        body: FloatingSearchBarScrollNotifier(
            child: ((SearchResultsListView()))
        ),
        transition: CircularFloatingSearchBarTransition(),
        physics: BouncingScrollPhysics(),
        hint: "Search",
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query){
          setState(() {
            filteredSearchHistory = filterSearchTerms(query);
          });
        },
        onSubmitted: (query){
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;
          });
          controller.close();
        },
        builder: (context, transition){
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4,
              child: Builder(builder: (context) {
                if(filteredSearchHistory.isEmpty && controller.query.isEmpty){
                  return Container(
                    height: 56,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      'Start searching',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  );
                }
                else if(filteredSearchHistory.isEmpty){
                  return ListTile(
                    title: Text(controller.query),
                    leading: const Icon(Icons.search),
                    onTap: (){
                      setState(() {
                        addSearchTerm(controller.query);
                        selectedTerm = controller.query;
                      });
                      controller.close();
                    },
                  );
                }
                else{
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: filteredSearchHistory.map((term) => ListTile(
                      title: Text(
                        term,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      leading: const Icon(Icons.history),
                      trailing: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            deleteSearchTerm(term);
                          });
                        },
                      ),
                      onTap: () {
                        setState(() {
                          putSearchTermFirst(term);
                          selectedTerm = term;
                        });
                        controller.close();
                      },
                    ),).toList(),
                  );
                }
              })
            )
          );
        },
      ),
    );
  }

  ListView SearchResultsListView() {

  final fsb = FloatingSearchBar.of(context);

  return ListView(
  padding: EdgeInsets.only(top: 75, bottom: 56),
  children: List.generate(
  5,
  (index) => ListTile(
  title: Text('$selectedTerm search result'),
  subtitle: Text(index.toString()),
  ),
  ),
  );
  }
}




