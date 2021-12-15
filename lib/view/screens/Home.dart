import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height.runtimeType);
    print(MediaQuery.of(context).size.width);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 70,
            leadingWidth: 80,
            toolbarHeight: 70,
            backgroundColor: Colors.teal,
            leading: Image.asset("assets/images/Artboard 12.png"),
            centerTitle: true,
            actions: const [
              Icon(Icons.album_outlined,size: 40,),
              Icon(Icons.settings,size: 40,),
            ],
          ),
        ],
      ),
    );
  }
}
