import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

class Carousel extends StatefulWidget {
  final List<Widget>? list;
  final int length;
  const Carousel({Key? key, this.list, required this.length}) : super(key: key);

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  Timer? timer;
@override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 10), (Timer t) => _controller.nextPage());
  }
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(

        width: double.infinity,
        child: CarouselSlider(
            carouselController: _controller,
            items:  widget.list,
            options: CarouselOptions(
                viewportFraction: 1,
                aspectRatio: 1.0,
                enableInfiniteScroll: true),
          ),
      ),

      widget.length !=  1 ?   Positioned(left: 0,bottom: 0,top: 0,
        child: IconButton(
          splashRadius: 30,
          onPressed: () => _controller.previousPage(),
          icon: const Icon(Icons.chevron_left,color: Constants.primary,size: 30),
        ),
      )
          : const SizedBox(width: 30),


      widget.length !=  1 ? Positioned(right: 0,bottom: 0,top: 0,
        child: IconButton(
          splashRadius: 30,
          color: Colors.grey[350],
          onPressed: () => _controller.nextPage(),
          icon: const Icon(Icons.chevron_right,color: Constants.primary,size: 30),
        ),
      ) : const SizedBox(width: 30),

    ]);
  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}