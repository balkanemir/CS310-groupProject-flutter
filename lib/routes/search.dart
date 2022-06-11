import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterui/routes/profile.dart';
import 'package:flutterui/routes/shuffle.dart';
import 'package:flutterui/routes/notificationPage.dart';
import 'package:flutterui/utils/styles.dart';
import 'package:flutterui/utils/screensizes.dart';
import 'package:flutterui/utils/colors.dart';
import 'package:flutterui/utils/dimensions.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:flutterui/services/analytics.dart';
import 'mainpage.dart';

class Search extends StatefulWidget {
  static const String routeName = '/search';

  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  static const historyLength = 5;
  List<String> _searchHistory = [];
  List<String> filteredSearchHistory = [];

  CollectionReference _users =
  FirebaseFirestore.instance.collection('users');

  String selectedTerm = "";
  bool onTap = false;

  List<String> filterSearchTerms(@required String? filter) {
    if (filter != null && filter.isNotEmpty) {
      return _searchHistory.reversed
          .where((term) => term.startsWith(filter))
          .toList();
    } else {
      return _searchHistory.reversed.toList();
    }
  }

  void addSearchTerm(String term) {
    if (_searchHistory.contains(term)) {
      putSearchTermFirst(term);
      return;
    }
    _searchHistory.add(term);
    if (_searchHistory.length > historyLength) {
      _searchHistory.removeRange(0, _searchHistory.length - historyLength);
    }

    filteredSearchHistory = filterSearchTerms(null);
  }

  void deleteSearchTerm(String term) {
    _searchHistory.removeWhere((t) => t == term);
    filteredSearchHistory = filterSearchTerms(null);
  }

  void putSearchTermFirst(String term) {
    deleteSearchTerm(term);
    addSearchTerm(term);
  }

  FloatingSearchBarController controller = FloatingSearchBarController();

  @override
  void initState() {
    super.initState();
    controller = FloatingSearchBarController();
    filteredSearchHistory = filterSearchTerms(null);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  int _currentindex = 1;
  @override
  Widget build(BuildContext context) {
    AppAnalytics.logCustomEvent("Search_Page", <String, dynamic>{});
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentindex,
          backgroundColor: textOnSecondaryWhite,
          selectedItemColor: secondaryPink800,
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NotificationPage()));
            }
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shuffle), label: 'Shuffle'),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications), label: 'Notifications')
          ]),
      body: FloatingSearchBar(

        controller: controller,
        body:
            FloatingSearchBarScrollNotifier(
                child: (
                    (SearchResultsListView())),
                ),
        transition: CircularFloatingSearchBarTransition(),
        physics: BouncingScrollPhysics(),
        hint: "Search",
        actions: [
          FloatingSearchBarAction.searchToClear(),
        ],
        onQueryChanged: (query) {
          setState(() {
            filteredSearchHistory = filterSearchTerms(query);
          });
        },
        onSubmitted: (query) {
          setState(() {
            addSearchTerm(query);
            selectedTerm = query;

            onTap = true;
          });
          controller.close();
        },
        builder: (context, transition) {
          return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Material(
                  color: Colors.white,
                  elevation: 4,
                  child: Builder(builder: (context) {
                    if (filteredSearchHistory.isEmpty &&
                        controller.query.isEmpty) {
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
                    } else if (filteredSearchHistory.isEmpty) {
                      return ListTile(
                        title: Text(controller.query),
                        leading: const Icon(Icons.search),
                        onTap: () {
                          setState(() {
                            addSearchTerm(controller.query);
                            selectedTerm = controller.query;

                          });
                          controller.close();
                        },
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: filteredSearchHistory
                            .map(
                              (term) => ListTile(
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
                              ),
                            )
                            .toList(),
                      );
                    }
                  })));
        },
      ),
    );
  }

  StreamBuilder<QuerySnapshot> SearchResultsListView() {
    final fsb = FloatingSearchBar.of(context);

    return StreamBuilder<QuerySnapshot>(
      stream: _users.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

          if (snapshot.hasError) {
            return const Text('error');
          }
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          }
          else{
            //print(snapshot.data);
            if (onTap == false){
                return Center(child: Text("Search anything here"));
            }
            else{
              if(snapshot.data!.docs.where(((QueryDocumentSnapshot<Object?> element) => element['username']
                  .toString()
                  .toLowerCase()
                  .contains(selectedTerm.toLowerCase()))).isEmpty){

                      return Center(child: Text("No such user found"));
          }
              else{
            return ListView(
                padding: EdgeInsets.only(top: 75, bottom: 56),
              children: [
                ...snapshot.data!.docs.where(((QueryDocumentSnapshot<Object?> element) => element['username']
                    .toString()
                    .toLowerCase()
                    .contains(selectedTerm.toLowerCase()))).map((QueryDocumentSnapshot<Object?> data) {
                      final String username = data.get('username');
                      final String image = data.get('profileImage');
                      final String fullname = data.get('name') + data.get('surname');


                      return ListTile(
                        onTap:() {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));

                        },
                        title: Text(username),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(image),
                        ),
                        subtitle: Text(fullname),
                      );
                })
              ],
            );
          }}}
        }
    );
  }
}
