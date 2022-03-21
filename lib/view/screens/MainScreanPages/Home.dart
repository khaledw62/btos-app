import 'package:btos/controllers/PropertiesControllers/PropertiesListingController.dart';
import 'package:btos/controllers/logincontroller.dart';
import 'package:btos/widgets/Properties/PropertyCard.dart';
import 'package:btos/widgets/Values/sizes.dart';
import 'package:btos/widgets/Values/theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final listViewController = ScrollController();

  final AuthViewModel authViewModel = Get.find();

  @override
  final PropertiesListingController controller = Get.put(PropertiesListingController());
  @override
  void initState() {
    controller.getPropertiesListing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig sizeConfig = SizeConfig.init(context);
    return Directionality(
      textDirection: Get.locale == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
      child: SingleChildScrollView(
        child: Column(
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
                width: sizeConfig.screenWidth * 0.8,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: white,
                ),
                alignment: Alignment.center,
                child: Row(
                  textDirection: Get.locale == const Locale("ar") ? TextDirection.rtl : TextDirection.ltr,
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
              onTap: ()=>Get.toNamed('/searchPage'),
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
                  return Column(
                    children: controller.propertiesListing.value
                        .map(
                          (e) => PropertyCard(property: e),
                        )
                        .toList(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
