import 'package:btos/controllers/PropertiesControllers/PropertiesListingController.dart';
import 'package:btos/controllers/logincontroller.dart';
import 'package:btos/widgets/Values/sizes.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends GetWidget<PropertiesListingController> {
  final listViewController = ScrollController();

  final AuthViewModel authViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: ListView(
        controller: listViewController,
        children: [
          const SizedBox(
            height: 20,
          ),
          if (authViewModel.googleSignIn.currentUser != null)
            ListTile(
              title: const Text(""),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(authViewModel.googleSignIn.currentUser!.photoUrl!),
              ),
              subtitle: Text(
                authViewModel.googleSignIn.currentUser!.displayName ?? "",
                style: Themes().headingStyle,
              ),
              trailing: TextButton(
                onPressed: () async {
                  GoogleSignInAccount? logout = await authViewModel.googleSignIn.signOut();
                  if (logout == null) {
                    Get.offNamedUntil("/login", (route) => false);
                  }
                },
                child: Text(
                  "Log Out",
                  style: Themes().appbarTitle,
                ),
              ),
              isThreeLine: true,
            ),
          GestureDetector(
            child: Container(
              width: SizeConfig.screenWidth * 0.8,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: white,
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.search,
                    color: lightRed,
                  ),
                  Text(
                    "Where are you going?",
                    style: TextStyle(
                      color: black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () => Get.toNamed('/searchPage'),
          ),
          const SizedBox(
            height: 15,
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayCurve: Curves.linearToEaseOut,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              viewportFraction: 1,
            ),
            items: [
              SizedBox(
                width: double.infinity,
                child: ClipRRect(
                  child: Image.asset(
                    "assets/testimages/item1.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  child: Image.asset(
                    "assets/testimages/item2.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  child: Image.asset(
                    "assets/testimages/item3.jpeg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  child: Image.asset(
                    "assets/testimages/lastitem.gif",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          GetX<PropertiesListingController>(
              init: controller,
              builder: (controller) {
                print("list size ${controller.total.value}");
                return Column(
                  children: controller.propertiesListing.value
                      .map((e) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            width: SizeConfig.screenWidth * 0.9,
                            height: 400,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Card(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage("assets/testimages/ad2.jpeg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: double.maxFinite,
                                        color: white,
                                        child: Column(
                                          children: [
                                            Text(
                                              e.project,
                                              style: Themes().headingStyle,
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              e.area.textual_value.toString(),
                                              style: Themes().subTitleStyle,
                                            ),
                                          ],
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                        ),
                                        padding: const EdgeInsets.only(left: 20, top: 15),
                                      ),
                                    ),
                                  ],
                                ),
                                color: lightRed,
                              ),
                            ),
                          ))
                      .toList(),
                );
              }),
        ],
      ),
    );
    /*CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: SizeConfig.screenHeight * 0.7,
          leadingWidth: 80,
          toolbarHeight: 50,
          stretch: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              "assets/images/homebg.jpeg",
              fit: BoxFit.cover,
            ),
            stretchModes: const [StretchMode.blurBackground],
            title: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Not sure where to go?",
                    style: Themes().appbarTitle,
                  ),
                  Text(
                    "Perfect.",
                    style: Themes().appbarTitle,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomButton(
                    text: GradientText(
                      "I'm flexible",
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                      gradient: LinearGradient(colors: [
                        Colors.red.shade400,
                        Colors.blue.shade900,
                      ]),
                    ),
                    onTap: () {},
                    background: white,
                    textColor: black,
                    hPadding: 10,
                    vPadding: 5,
                    fontWeight: FontWeight.bold,
                    textSize: 10,
                  )
                ],
              ),
            ),
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            child: Container(
              padding: const EdgeInsets.only(left: 10, top: 20, bottom: 5),
              child: Text(
                "Inspiration for you",
                style: Themes().headingStyle,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            child: Container(
              padding: const EdgeInsets.only(left: 10, bottom: 20),
              child: Text(
                "next trip",
                style: Themes().headingStyle,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: SizeConfig.screenHeight * 0.4,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemExtent: 300,
              semanticChildCount: 4,
              addAutomaticKeepAlives: false,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 300.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Card(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(list[index].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.maxFinite,
                              color: list[index].color,
                              child: Column(
                                children: [
                                  Text(list[index].title,style: Themes().headingStyle,),
                                  const SizedBox(height: 8,),
                                  Text(list[index].distance,style: Themes().subTitleStyle,),
                                ],
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                              ),
                              padding: const EdgeInsets.only(left: 20,top: 15),
                            ),
                          ),
                        ],
                      ),
                      color: lightRed,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );*/
  }
}
