import 'package:flutter/material.dart';

class HelloAi extends StatefulWidget {
  const HelloAi({super.key});

  @override
  State<HelloAi> createState() => _HelloAiState();
}

class _HelloAiState extends State<HelloAi> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _controller2;
  late final Animation<AlignmentGeometry> _alignAnimation;
  late Animation sizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4));

    sizeAnimation = Tween(begin: 0.0, end: 0.5).animate(CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.40, 0.75, curve: Curves.easeOut)));
    _controller.forward();
    _controller.addListener(() {
      setState(() {});
    });
    //
    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat(reverse: true);

    _alignAnimation = Tween<AlignmentGeometry>(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    _alignAnimation;
    sizeAnimation;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    return SizedBox(
      width: size.height / 2,
      height: size.width / 2,
      child: AlignTransition(
        alignment: _alignAnimation,
        child: Center(
          child: Container(
            // width: size.width * sizeAnimation.value,
            // height: size.height * sizeAnimation.value,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.transparent),
            child: Image.asset("assets/r2.gif"),
          ),
        ),
      ),
    );
  }
}
