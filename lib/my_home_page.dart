import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ready_you/detail_audio_page.dart';
import 'package:ready_you/my_tabs.dart';
import 'app_colors.dart' as AppColors;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
   late List popularbooks;
  late List books;
   late ScrollController _scrollController;
  late TabController _tabController;

  ReadData() async {
    await DefaultAssetBundle.of(context).loadString("json/popularbooks.json").then((s){
      setState(() {
        popularbooks=json.decode(s);
      });
    } );
    await DefaultAssetBundle.of(context).loadString("json/books.json").then((s){
      setState(() {
        books=json.decode(s);
      });
    } );
  }

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController= ScrollController();
    ReadData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child:SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top:7,left:20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Icon(Icons.menu),
                    SizedBox(width: 10,),
                    Row(
                      children: [
                        Icon(Icons.search),
                        Icon((Icons.notifications),),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left:20),
                    child: Text("Popular Books", style: TextStyle(fontSize: 30)),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Container(
                height: 180,
                child: Stack(
                  children:[
                    Positioned(
                      top:0,
                      left: -30,
                      right: 0,
                      child:SizedBox(
                      height: 180,

                      child: PageView.builder(
                          controller: PageController(viewportFraction: 0.8),
                          itemCount: popularbooks==null?0:popularbooks.length,
                          itemBuilder: (_, i){
                            return Container(
                              height: 180,
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    image: AssetImage(popularbooks[i]['img']),
                                  )
                              ),
                            );
                          }),
                    ),
                    )
                  ]
                ),
              ),
              Expanded(child: NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (BuildContext context, bool isScroll) {
                  return [
                    SliverAppBar(
                      backgroundColor: AppColors.silverBackground,
                      pinned: true,
                      bottom: PreferredSize(
                        preferredSize: Size.fromHeight(50),
                        child: Container(
                          margin: const EdgeInsets.only( bottom: 20),
                          child: TabBar(
                            controller: _tabController,
                            indicatorPadding: const EdgeInsets.all(0),
                            indicatorSize: TabBarIndicatorSize.label,
                            labelPadding: const EdgeInsets.only(right: 10),
                            isScrollable: true,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(1),
                                  blurRadius: 7,
                                  offset: Offset(0,2)
                                )
                              ]
                            ),
                            tabs: [
                            AppTabs(color: AppColors.menu1Color, text: "New"),
                              AppTabs(color: AppColors.menu2Color, text: "Popular"),
                              AppTabs(color: AppColors.menu3Color, text: "Trending")

                            ],

                          ),
                        ),
                      ),
                    )
                  ];
                }, body: TabBarView(
                controller: _tabController,
                children:[
                  ListView.builder(
                      itemCount: books==null?0:books.length,
                      itemBuilder: (_,i){
                  return
                    GestureDetector(
                      onTap:(){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>DetailAudioPage(booksData:books, index:i, audioPath: '',  ))
                        );
                      },
                      child: Container(
                        color: AppColors.tabVarVIewColor,
                        margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow:[
                                BoxShadow(
                                  blurRadius: 2,
                                  offset: const Offset(0,0),
                                  color: Colors.grey.withOpacity(0.2),
                                )
                              ]
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                Container(
                                  width: 90,
                                  height: 120,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image:  DecorationImage(
                                        image: AssetImage(books[i]["img"]),
                                      )
                                  ),
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.star,size: 24,color: AppColors.starColor),
                                        SizedBox(width: 5,),

                                        Text(books[i]["rating"], style: TextStyle(
                                            color:AppColors.menu2Color
                                        ),),

                                      ],
                                    ),
                                    Text(books[i]["title"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,fontFamily: "Avenir"),),
                                    Text(books[i]["text"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,fontFamily: "Avenir", color: AppColors.subTitleText),),
                                    Container(
                                      width: 60,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: AppColors.loveColor,
                                      ),
                                      child: Text("Love", style: TextStyle(fontSize: 14, fontFamily: "Avenir", color: Colors.white ),),
                                      alignment: Alignment.center,
                                    )


                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    );



                  }
                  ),

                  Material(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,

                      ),
                      title: Text("Content"),
                    ),
                  ),
                  Material(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,

                      ),
                      title: Text("Content"),
                    ),
                  ),
                ],
              ),
               

              ))

            ],
          ),

        ) ,
      )
    );
  }
}
