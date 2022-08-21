import 'package:al_mandoob_rider/Map/OrderTrackingPageState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../Controller/HomeConroller.dart';


class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flexible space title',
      home: MyHomePage(),
    );
  }
}
var default_color=Color(0xff1e319d);

HomeController homeController=Get.put(HomeController());

class MyHomePage extends StatelessWidget {
  var htextTheme=TextStyle(color: Color(0xffffffff),fontWeight: FontWeight.bold,fontSize: 18.sp);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            centerTitle: true,
            backgroundColor: default_color,
            pinned: true,
            toolbarHeight: 90.h,
            title:Container(
              color: default_color,
              padding: EdgeInsets.symmetric(horizontal: 10),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("Hi, Salman ",style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Obx(() => CircleAvatar(
                                        radius: 5.r,
                                        backgroundColor:homeController.onlineStatus.value?Colors.green:Colors.grey,
                                      )),
                                      Obx(() => Switch(
                                          inactiveThumbColor: Colors.grey,
                                          activeColor: Colors.white,
                                          value: homeController.onlineStatus.value,
                                          onChanged: (b)
                                          {
                                            homeController.changeOnlineStatus();
                                            print("sl;ksl; ${ homeController.onlineStatus.value}");

                                          }))
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.star,color: Colors.amber,size: 14,),
                              Text("Star Rider",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.normal),),
                            ],
                          )


                        ],),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Pierre-Person.jpg/1200px-Pierre-Person.jpg"),
                      )

                    ],
                  ),
                ],
              ),
            ),
            expandedHeight: MediaQuery.of(context).size.height*0.35,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              collapseMode: CollapseMode.parallax,
              background: Container(
                margin: EdgeInsets.only(top: 10.h),

                child: Stack(
                  children: [

                    Expanded(
                      child: Container(
                        color: default_color,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(height: 5.h,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [

                                Container(
                                  width: 150.w,
                                  height: 80.h,
                                  padding: EdgeInsets.all(5.w),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text("Complete Rides",style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),),
                                      Text("422",style: TextStyle(
                                          fontSize: 24,
                                      ),),
                                    ],
                                  ),
                                ),

                                Container(
                                  width: 150.w,
                                  height: 80.h,
                                  padding: EdgeInsets.all(5.w),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20)
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text("Canceled Rides",style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold
                                      ),),
                                      Text("422",style: TextStyle(
                                        fontSize: 24,
                                      ),),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 30.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft:  Radius.circular(20),
                                  topRight:  Radius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(left: 8, right: 8,top: 10,bottom: 20),

            sliver: SliverGrid(

              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 20,
              ),

              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int i) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: default_color,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: showCard(i),
                    ),
                  );
                },
                childCount: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }

   _listview(int count) {
    List<Widget> listItems =[];



    for (int i = 0; i < count; i++) {
      listItems.add(new
      Padding(padding: new EdgeInsets.all(20.0), child: new Text('Item ${i.toString()}', style: new TextStyle(fontSize: 25.0))));
    }

    return listItems;
  }

  showCard(int i) {
    if(i==0)
    {
      return InkWell(
        onTap: (){
          Get.to(OrderTrackingPageState());
        },
        child: dashboardCardWidget(Icons.request_page_outlined,"Check Request"),
      ) ;
    }
    else if(i==1)
    {
      return dashboardCardWidget(Icons.done,"Done Rides") ;
    }
    else if(i==2)
    {
      return dashboardCardWidget(Icons.cancel,"Cancel Rides") ;
    }
    else if(i==3)
    {
      return dashboardCardWidget(Icons.reviews,"Profile Reviews") ;
    }
    else if(i==4)
    {
      return dashboardCardWidget(Icons.message,"Message") ;
    }
    else if(i==5)
    {
      return dashboardCardWidget(Icons.info,"Privacy Policy") ;
    }
  }

  dashboardCardWidget(icon,text){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon,color: Colors.white,),
        SizedBox(height: 10.h,),
        Text("${text}",style: TextStyle(color: Colors.white
            ,fontWeight: FontWeight.bold,fontSize: 18.sp),)
      ],);
  }

}

