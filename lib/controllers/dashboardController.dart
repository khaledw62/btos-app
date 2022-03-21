import 'package:btos/view/screens/MainScreanPages/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController{
  RxInt index = 0.obs;
  Rx<Widget> currentWidget = Container(child: HomeScreen(),).obs;
  setIndex(int index)=> this.index.value = index;
  setCurrentWidget(Widget currentWidget)=>this.currentWidget.value = currentWidget;
}