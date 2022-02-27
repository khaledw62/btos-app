import 'package:btos/widgets/Values/theme.dart';
import 'package:flutter/material.dart';

class BToSLoader extends StatefulWidget {
  const BToSLoader({Key? key}) : super(key: key);

  @override
  State<BToSLoader> createState() => _BToSLoaderState();
}

class _BToSLoaderState extends State<BToSLoader> with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _animation;

  late AnimationController _controller1;
  late Animation<double> _animation1;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(vsync: this, duration:  const Duration(milliseconds: 1000),lowerBound: .5)..repeat(reverse: true);
    _animation1 = CurvedAnimation(parent: _controller1, curve: Curves.fastOutSlowIn);
  }

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor.withOpacity(.7),
          borderRadius: BorderRadius.circular(20)
      ),
      height: 100,
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/LogoLayers/Vector3.png"),
          ScaleTransition(scale: _animation1,child: Column(
            children: [Image.asset("assets/LogoLayers/Vector2.png"),Image.asset("assets/LogoLayers/Vector1.png"),],
          ),),
          Image.asset("assets/LogoLayers/Vector.png"),
          //Image.asset("assets/LogoLayers/Vector.png"),
        ],
      ),
    );
  }
}
