import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    var htextTheme=TextStyle(color: Color(0xff1e319d),fontWeight: FontWeight.bold,fontSize: 30.sp);

    var default_color=Color(0xff1e319d);
    return Scaffold(
      backgroundColor: default_color,
      body: Column(
        children: [

          Container(
            height: 200.h,
            width: double.infinity,
            child: Center(child: Text("I am top")),
          ),

          Expanded(
            child: Container(
              width: double.infinity,
              child: Text("dsd"),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r))
              ),

            ),
          )
        ],
      ),
    );
  }
}
