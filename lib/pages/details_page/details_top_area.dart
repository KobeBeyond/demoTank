import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:demo/provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  const DetailsTopArea({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(
      builder: (context, child, val){
        var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;

        if (goodsInfo != null) {
          return Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNum(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
              ],
            ),
          );
        } else {
          return Text('正在加载中...');
        }
      },
    );
  }

// 商品图片
  Widget _goodsImage(url) {
    return Image.network(
      url,
      width: ScreenUtil().setWidth(740),
    );
  }

// 商品名称
  Widget _goodsName(name){

    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(30),
        ),
      ),
    );
  }  

  // 商品编号
  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text('编号：$num',
      style: TextStyle(
        color: Colors.black12
      ),),
    );
  }
// 商品价格
  Widget _goodsPrice(price, oriPrice) {
    return Container(
      width: ScreenUtil().setWidth(730),
      height: ScreenUtil().setHeight(100),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Text(
              '￥ $price',
              style: TextStyle(
                color: Colors.blue,
                fontSize: ScreenUtil().setSp(30),
              )
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Text(
              '市场价：'
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Text(
              '$oriPrice',
              style: TextStyle(
                color: Colors.black12,
                decoration: TextDecoration.lineThrough
              ),
            ),
          ),
        ],
      ),
    );
  }

}