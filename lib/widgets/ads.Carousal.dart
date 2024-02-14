import 'package:carousel_slider/carousel_slider.dart';
import 'package:daily_recipe/pages/view.all.recipes.dart';
import 'package:daily_recipe/provider/ads.provider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/navigation.utils.dart';

class AdsCarousal extends StatelessWidget {
  const AdsCarousal({super.key});

  @override
  Widget build(BuildContext context) {
    final CarouselController carouselControllerEx = CarouselController();
    return Consumer<AdsProvider>(builder: (context, value, child) {
      if (value.adsList.isNotEmpty) {
        return Column(
          children: [
            Stack(children: [
              CarouselSlider(
                carouselController: carouselControllerEx,
                items: value.adsList.map(
                  (ad) {
                    return InkWell(
                      onDoubleTap: ()=> NavigationUtils.push(context: context, page: const ViewAllRecipes()),

                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(
                          color: Colors.white70,
                        ),
                        child: FadeInImage(
                          image: NetworkImage(ad.image!),
                          fit: BoxFit.fitHeight,
                          width: 200,
                          height: 130,
                          placeholder: const AssetImage("assets/images/loading.gif"),
                        ),

                      ),
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
      return Image.asset("assets/images/loading.gif");
    });
  }
}
