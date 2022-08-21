

import 'package:get/get.dart';

class HomeController extends GetxController
{
  var onlineStatus=false.obs;

  changeOnlineStatus()
  {
    onlineStatus.value=!onlineStatus.value;
  }

}