import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('会员中心'),
        ),
        body: ListView(
          children: <Widget>[
            _topHeader(),
            _orderTitle(),
            _orderType(),
            _actionList()
          ],
        ));
  }

  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(780),
      padding: EdgeInsets.all(20),
      color: Colors.blueAccent,
      child: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(370),
            height: ScreenUtil().setHeight(180),
            margin: EdgeInsets.only(top: 30),
            color: Colors.blueAccent,
            child: ClipOval(
              child: Image.network(
                  'http://blogimages.jspang.com/blogtouxiang1.jpg'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'JSPang',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(36), color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  //我的订单
  Widget _orderTitle(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12)
        ),
      ),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text('我的订单'),
        trailing: Icon(Icons.arrow_right),
      ),
    ); 
  }

  // 
  Widget _orderType(){
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(150),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.query_builder,
                size: 30,
                ),
                Text('待付款')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.party_mode,
                size: 30,
                ),
                Text('待发货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.directions_transit,
                size: 30,
                ),
                Text('待收货')
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(Icons.comment,
                size: 30,
                ),
                Text('待评价')
              ],
            ),
          ),
        ],
      ),
    );
  }

  //通用ListTile
  Widget _myListTile(String title){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12
          )
        )
      ),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
      ),
    );
  }

  Widget _actionList() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _myListTile('领取优惠券'),
          _myListTile('已领取优惠券'),
          _myListTile('地址管理'),
          _myListTile('客服电话'),
          _myListTile('关于我们'),
        ],
      ),
    );
  }
}

