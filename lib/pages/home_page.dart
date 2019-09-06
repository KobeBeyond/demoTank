// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key key}) : super(key: key);

//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController typeController = TextEditingController();
//   String showText = "欢迎来到美好人间";

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("美好人间"),
//         ),
//         body: SingleChildScrollView(
//           child: Container(
//             child: Column(
//               children: <Widget>[
//                 TextField(
//                   controller: typeController,
//                   decoration: InputDecoration(
//                       contentPadding: EdgeInsets.all(10.0),
//                       labelText: '美女类型',
//                       helperText: '请输入你喜欢的类型'),
//                   autofocus: false,
//                 ),
//                 RaisedButton(
//                   onPressed: _choiceAction,
//                   child: Text("选择完毕"),
//                 ),
//                 Text(
//                   showText,
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _choiceAction() {
//     print("开始选择你喜欢的类型");
//     if (typeController.text.toString() == '') {
//       showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//                 title: Text("美女类型不能为空"),
//               ));
//     } else {
//       getHttp(typeController.text.toString()).then((val) {
//         setState(() {
//           showText = val['data']['name'].toString();
//         });
//       });
//     }
//   }

//   Future getHttp(String typeText) async {
//     try {
//       Response response;
//       var data = {'name': typeText};
//       response = await Dio().get("https://", queryParameters: data);
//       return response.data;
//     } catch (e) {
//       return print(e);
//     }
//   }
// }

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:demo/config/httpHeaders.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key key}) : super(key: key);

//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//   String showText = "还没有请求数据";
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//        child: Scaffold(
//          appBar: AppBar(
//            title: Text('请求远程数据'),
//          ),
//          body: SingleChildScrollView(
//            child: Column(
//              children: <Widget>[
//                RaisedButton(
//                  onPressed: _jike,
//                  child: Text("请求数据"),
//                ),
//               Text(showText)
//              ],
//            ),
//          ),
//        ),
//     );
//   }

//   void _jike(){
//     print("开始向极客时间请求数据");
//     getHttp().then((val){
//       setState(() {
//        showText = val['data'].toString();
//       });
//     });
//   }

//   Future getHttp() async{
//     try{
//       Response response;
//       Dio dio = new Dio();
//       dio.options.headers=httpHeaders;
//       response = await dio.get("https://time.geekbang.org/serv/v1/column/topList");
//       print(response);
//       return response.data;
//     } catch(e) {
//       return print(e);
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:demo/service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:demo/routers/application.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  int page = 1;
  List<Map> hotGoodsList = [];
  bool isSearching = false;
  //bool searchAble = true;
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();
  @override
  bool get wantKeepAlive => true;

  String homePageContent = "正在获取数据";

  @override
  void initState() {
    // r().then((val){
    //   setState(() {
    //     homePageContent = val.toString();
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    return Scaffold(
        appBar: isSearching
            ? AppBar()
            : AppBar(
                title: Text('TankMall'),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Application.router
                          .navigateTo(context, "/search?text='123'");
                    },
                  )
                ],
              ),
        body: FutureBuilder(
          future: request('homePageContent', formData: formData),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = json.decode(snapshot.data.toString());
              List<Map> swiper = (data['data']['slides'] as List).cast();
              List<Map> navigatorList =
                  (data['data']['category'] as List).cast();
              String adPicture =
                  data['data']['advertesPicture']['PICTURE_ADDRESS'];
              String leaderImage = data['data']['shopInfo']['leaderImage'];
              String leaderPhone = data['data']['shopInfo']['leaderPhone'];
              List<Map> recommendList =
                  (data['data']['recommend'] as List).cast();
              String floor1Title = data['data']['floor1Pic']['PICTURE_ADDRESS'];
              String floor2Title = data['data']['floor2Pic']['PICTURE_ADDRESS'];
              String floor3Title = data['data']['floor3Pic']['PICTURE_ADDRESS'];
              List<Map> floor1 = (data['data']['floor1'] as List).cast();
              List<Map> floor2 = (data['data']['floor2'] as List).cast();
              List<Map> floor3 = (data['data']['floor3'] as List).cast();

              return EasyRefresh(
                refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.blue,
                  showMore: true,
                  noMoreText: '',
                  moreInfo: '加载中...',
                  loadReadyText: '上拉加载...',
                  loadedText: '已加载',
                ),
                child: ListView(
                  children: <Widget>[
                    SwiperDiy(swiperDatelist: swiper),
                    TopNavigator(
                      navigatorList: navigatorList,
                    ),
                    AdBanner(
                      adPicture: adPicture,
                    ),
                    LeaderPhone(
                      leaderImage: leaderImage,
                      leaderPhone: leaderPhone,
                    ),
                    Recommend(
                      recommendList: recommendList,
                    ),
                    FloorTitle(
                      pictureAddress: floor1Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor1,
                    ),
                    FloorTitle(
                      pictureAddress: floor2Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor2,
                    ),
                    FloorTitle(
                      pictureAddress: floor3Title,
                    ),
                    FloorContent(
                      floorGoodsList: floor3,
                    ),
                    _hotGoods()
                  ],
                ),
                loadMore: () async {
                  print("开始加载更多...");
                  var formData = {'page': page};
                  await request('homePageBelowConten', formData: formData)
                      .then((val) {
                    var data = json.decode(val.toString());
                    List<Map> newGoodList = (data['data'] as List).cast();
                    setState(() {
                      hotGoodsList.addAll(newGoodList);
                      page++;
                    });
                  });
                },
              );
            } else {
              return Center(
                child: Text("加载中..."),
              );
            }
          },
        ));
  }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.0),
    alignment: Alignment.center,
    color: Colors.transparent,
    padding: EdgeInsets.all(5.0),
    child: Text('火爆专区'),
  );

  // 火爆专区
  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList.map((val) {
        return InkWell(
          onTap: () {
            Application.router
                .navigateTo(context, '/detail?id=${val['goodsId']}');
          },
          child: Container(
            width: ScreenUtil().setWidth(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: ScreenUtil().setWidth(370),
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.blue, fontSize: ScreenUtil().setSp(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text(
                      '￥${val['mallPrice']}',
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('加载中...');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: <Widget>[
          hotTitle,
          _wrapList(),
        ],
      ),
    );
  }
}

// 首页轮播组件
class SwiperDiy extends StatelessWidget {
  final List swiperDatelist;
  SwiperDiy({Key key, this.swiperDatelist});
  @override
  Widget build(BuildContext context) {
    print('设备的像素密度:${ScreenUtil.pixelRatio}');
    print('设备的高:${ScreenUtil.screenHeight}');
    print('设备的宽:${ScreenUtil.screenWidth}');
    return Container(
      height: ScreenUtil().setHeight(320),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Application.router.navigateTo(
                  context, '/detail?id=${swiperDatelist[index]['goodsId']}');
            },
            child: Image.network("${swiperDatelist[index]['image']}",
                fit: BoxFit.fill),
          );
        },
        itemCount: swiperDatelist.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

// 顶部导航
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击了导航');
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(95),
          ),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.navigatorList.length > 10) {
      this.navigatorList.removeRange(10, this.navigatorList.length);
    }

    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        //physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

// 广告区域
class AdBanner extends StatelessWidget {
  final String adPicture;
  AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

// 店长电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderImage; // 店长头像
  final String leaderPhone; // 店长图片
  LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launcherURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launcherURL() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'url不能正常访问';
    }
  }
}

// 商品推荐类
class Recommend extends StatelessWidget {
  final List recommendList;
  Recommend({Key key, this.recommendList}) : super(key: key);
// 标题方法
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.blue),
      ),
    );
  }

// 商品单独项方法
  Widget _item(context, index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
            context, "/detail?id=${recommendList[index]['goodsId']}");
      },
      child: Container(
        height: ScreenUtil().setHeight(330),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              left: BorderSide(width: 1, color: Colors.black12),
            )),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),

            Text('￥${recommendList[index]['mallPrice']}'),
            // Text(
            //   '￥${recommendList[index]['price']}',
            //   style: TextStyle(
            //     decoration: TextDecoration.lineThrough,
            //     color: Colors.grey,
            //   ),
            // )
          ],
        ),
      ),
    );
  }

// 横向列表方法
  Widget _recommendList() {
    return Container(
      height: ScreenUtil().setHeight(312),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(context, index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(380),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommendList()],
      ),
    );
  }
}

// 楼层标题
class FloorTitle extends StatelessWidget {
  final String pictureAddress;

  FloorTitle({Key key, this.pictureAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(pictureAddress),
    );
  }
}

// 楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;
  FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _firstRow(context),
          _otherGoods(context),
        ],
      ),
    );
  }

  Widget _firstRow(context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodsList[0]),
        Column(
          children: <Widget>[
            _goodsItem(context, floorGoodsList[1]),
            _goodsItem(context, floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(context) {
    return Row(
      children: <Widget>[
        _goodsItem(context, floorGoodsList[3]),
        _goodsItem(context, floorGoodsList[4]),
      ],
    );
  }

  Widget _goodsItem(BuildContext context, Map goods) {
    return Container(
      width: ScreenUtil().setWidth(375),
      child: InkWell(
        onTap: () {
          Application.router
              .navigateTo(context, "/detail?id=${goods['goodsId']}");
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}
