import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:demo/provide/search.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../service/service_method.dart';
import 'dart:convert';
import 'package:demo/model/category.dart';
import 'package:demo/provide/child_category.dart';
import 'package:demo/model/categoryGoodsList.dart';
import 'package:demo/provide/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo/routers/application.dart';

class SearchPage extends StatefulWidget {
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = new TextEditingController();
  final FocusNode focusNode1 = new FocusNode();
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
              Provide.value<SearchTextProvide>(context)
                  .getSearchText(_searchController.text);
              isSearching = Provide.value<SearchTextProvide>(context)
                  .changeSearchState(isSearching);
            },
          ),
        ],
      ),
      body: Provide<SearchTextProvide>(
      builder: (context, child, val){
        return Container(
          child: Text('${val.searchText}'),
        );
      })
    );
  }

  // 获得更多列表
  void _getMoreList() {
    Provide.value<ChildCategory>(context).addPage();
    var data = {
      'categoryId': Provide.value<ChildCategory>(context).categoryId,
      'categorySubId': Provide.value<ChildCategory>(context).subId,
      'page': Provide.value<ChildCategory>(context).page
    };

    request("getMallGoods", formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Fluttertoast.showToast(
          msg: "已经到底了",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Provide.value<ChildCategory>(context).changeNoMoreText('没有更多了');
      } else {
        Provide.value<CategoryGoodsListProvide>(context)
            .getMoreList(goodsList.data);
      }
    });
  }

// 获取商品图片
  Widget _goodsImage(List newList, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

// 获取商品名称
  Widget _goodsName(List newList, index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

// 获取商品价格
  Widget _goodsPrice(List newList, index) {
    return Container(
      width: ScreenUtil().setWidth(370),
      margin: EdgeInsets.only(top: 20.00),
      child: Row(
        children: <Widget>[
          Text(
            '价格:￥${newList[index].presentPrice}',
            style:
                TextStyle(color: Colors.blue, fontSize: ScreenUtil().setSp(32)),
          ),
          SizedBox(width: 2.0),
          Text(
            '价格:￥${newList[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough,
                fontSize: ScreenUtil().setSp(28)),
          ),
        ],
      ),
    );
  }

// 上品
  Widget _listItemWidget(List newList, int index) {
    return InkWell(
      onTap: () {
        Application.router
            .navigateTo(context, '/detail?id=${newList[index].goodsId}');
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
