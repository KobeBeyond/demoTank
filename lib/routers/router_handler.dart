import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:demo/pages/details_page.dart';
import 'package:demo/pages/search_page.dart';
// import 'package:demo/pages/search_result_page.dart';

Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String goodsId = params['id'].first;
    print('index>details goodsId is $goodsId');
    return DetailsPage(goodsId);
  } 
);

Handler searchHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String tempText = params['text'].first;
    print('index>details goodsId is $tempText');
    return SearchPage();
  }
);

// Handler searchResultHandler = Handler(
//   handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//     String tempText = params['text'].first;
//     print('index>details goodsId is $tempText');
//     return SearchResultPage(tempText);
//   }
// );