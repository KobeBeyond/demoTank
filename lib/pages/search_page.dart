import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:demo/provide/search.dart';

class SearchPage extends StatefulWidget {
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = new TextEditingController();
  final FocusNode focusNode1 = new FocusNode();
  String search = '';
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    TextField searchField = new TextField(
      cursorColor: Colors.white,
      autofocus: true,
      decoration: new InputDecoration(
          border: InputBorder.none, hintText: '搜索', fillColor: Colors.white),
      focusNode: focusNode1,
      controller: _searchController,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        title: searchField,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Application.router.navigateTo(
              //     context, '/searchResult?text=${_searchController.text}');
              Provide.value<SearchTextProvide>(context)
                  .getSearchText(_searchController.text);
              search = Provide.value<SearchTextProvide>(context).searchText;
            },
          ),
        ],
      ),
      body: Container(
        child: Text('$search'),
      ),
    );
  }
}
