import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sheekosh/ui/widgets/home/reklam_item.dart';

class TopReklamCarousel extends StatelessWidget {
  final List<String> imgList;
  TopReklamCarousel({Key? key, required this.imgList}) : super(key: key);

  final CarouselController _controller = CarouselController();

  int _current = 0;
  //final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders =
        imgList.map((item) => ReklamItem(imageUrl: item)).toList();

    return Container(
      //color: Colors.red,
      width: double.infinity,
      child: CarouselSlider(
        items: imageSliders,
        carouselController: _controller,
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
          viewportFraction: 1,
          autoPlayAnimationDuration: const Duration(
            seconds: 5,
          ),
        ),
      ),
    );
  }
}
