import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/models/ad.model.dart';
import 'package:daily_recipe/provider/ads.provider.dart';
import 'package:daily_recipe/services/ads.services.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../cubit/ads_cubit.dart';

class AdsCarousal extends StatelessWidget {
  const AdsCarousal({super.key});

  @override
  Widget build(BuildContext context) {
    final CarouselController carouselControllerEx = CarouselController();
    return Consumer<AdsProvider>(builder: (context, value, child) {
      /* BlocConsumer<AdsCubit, AdsState>(
        listener: (_, __) {},
        builder: (context, state) {*/
      //  print(
      //   "============================ Ads ${value.adsList}");
      // if (context.read<AdsCubit>().ads.isNotEmpty) {
      if (value.adsList.isNotEmpty) {
        return Column(
          children: [
            Stack(children: [
              CarouselSlider(
                carouselController: carouselControllerEx,
                //context.read<AdsCubit>().carouselControllerEx,
                //  items: context.read<AdsCubit>().ads.map(
                items: value.adsList.map(
                  (ad) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(30),
                        color: Colors.white70,
                      ),
                      child: FadeInImage(
                       /* fadeInDuration: Duration(seconds: 3),
                        fadeInCurve: Curves.easeIn,*/
                        image: NetworkImage(ad.image!),
                        fit: BoxFit.fitHeight,
                        width: 200,
                        height: 130,
                        placeholder: AssetImage("assets/images/loading.gif"),
                      ),
                      //  Text("${i}")
                      /* Image(
                              image: NetworkImage(ad.image!),
                              fit: BoxFit.fitWidth,
                            )*/
                    );
                  },
                ).toList(),
                options: CarouselOptions(
                    height: 200.0,
                    viewportFraction: .75,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enlargeFactor: .3,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    onPageChanged: (index, _) {
                      Provider.of<AdsProvider>(context, listen: false)
                          .changeIndex(index);

                      //   print(
                      //  "============${value.currentIndex}=============");
                    }),
              ),
              Positioned(
                  left: 20,
                  top: 100,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      size: 40,
                      color: Colors.brown,
                    ),
                    onPressed: () async {
                      carouselControllerEx.previousPage();
                    },
                  )),
              Positioned(
                  right: 20,
                  top: 100,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_outlined,
                      size: 40,
                      color: Colors.brown,
                    ),
                    onPressed: () async {
                      carouselControllerEx.nextPage();
                    },
                  ))
            ]),
            Align(
              alignment: Alignment.center,
              child: DotsIndicator(
                dotsCount: value.adsList!.length,
                position: value.currentIndex,
                onTap: (position) async {
                  carouselControllerEx.animateToPage(position);

                  Provider.of<AdsProvider>(context, listen: false)
                      .changeIndex(position);

                  // print(
                  //   "===========position  new = $position=================");
                },
                decorator: DotsDecorator(
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
          ],
        );
      }
      return Container(
        child: CircularProgressIndicator(),
      );
    });
  }
}
