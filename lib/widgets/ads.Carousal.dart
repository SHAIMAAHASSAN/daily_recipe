import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/models/ad.model.dart';
import 'package:daily_recipe/services/ads.services.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../cubit/ads_cubit.dart';

class AdsCarousal extends StatelessWidget {
  const AdsCarousal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdsCubit, AdsState>(
        listener: (_, __) {},
        builder: (context, state) {
          print(
              "============================ Ads ${context.read<AdsCubit>().ads}");
          if (context.read<AdsCubit>().ads.isNotEmpty) {
            return Column(
              children: [
                Stack(children: [
                  CarouselSlider(
                    carouselController:
                        context.read<AdsCubit>().carouselControllerEx,
                    items: context.read<AdsCubit>().ads.map(
                      (ad) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.white70,
                            ),
                            child:
                                //  Text("${i}")
                                Image(
                              image: NetworkImage(ad.image!),
                              fit: BoxFit.fitWidth,
                            ));
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
                          context.read<AdsCubit>().changeIndex(index);

                          print(
                              "============${state.currentIndex}=============");
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
                          context
                              .read<AdsCubit>()
                              .carouselControllerEx
                              .previousPage();
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
                          context
                              .read<AdsCubit>()
                              .carouselControllerEx
                              .nextPage();
                        },
                      ))
                ]),
                Align(
                  alignment: Alignment.center,
                  child: DotsIndicator(
                    dotsCount: context.read<AdsCubit>().ads.length,
                    position: state.currentIndex,
                    onTap: (position) async {
                      await context
                          .read<AdsCubit>()
                          .carouselControllerEx
                          .animateToPage(position);
                      context.read<AdsCubit>().changeIndex(position);

                      print(
                          "===========position  new = $position=================");
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
