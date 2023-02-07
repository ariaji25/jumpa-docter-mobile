import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../../../common/resources/assets.dart';
import '../../../common/resources/colors.dart';
import '../../../common/resources/size.dart';
import '../../../common/theme/theme.dart';
import '../../widgets/menu_item.dart';
import 'common/item_selected.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

int selectedIndex = 0;

List<String> imgList = [
  "${Assets.othersPath}/iklan_3.png",
  "${Assets.othersPath}/iklan_3.png",
  "${Assets.othersPath}/iklan_3.png",
];

class HomeScreenState extends State<HomePage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ITEMS
          const SizedBox(height: 30),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: SizeConstants.margin),
            child: Text(
              "Layanan JumpaDokter",
              style: AppTheme.subtitle.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColorDarkColor,
              ),
            ),
          ),
          GridView.count(
            primary: false,
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            mainAxisSpacing: 16,
            crossAxisCount: 4,
            children: menus(context),
          ),

          /// SLIDER
          Transform.translate(
            offset: const Offset(0, -20),
            child: Container(
              color: AppColors.whiteColor,
              child: CarouselSlider(
                items: imageSliders,
                carouselController: _controller,
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imgList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 6.0,
                    height: 6.0,
                    margin: const EdgeInsets.only(
                      top: 0.0,
                      bottom: 8,
                      left: 4.0,
                      right: 4.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : AppColors.primaryColor)
                          .withOpacity(
                        _current == entry.key ? 0.9 : 0.4,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          /// ARTICELS
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: SizeConstants.margin),
            child: Text(
              "Artikel kesehatan",
              style: AppTheme.subtitle.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.primaryColorDarkColor,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: SizeConstants.margin),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 15,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 0,
                        itemBuilder: (context, index) {
                          final e = null;
                          return ItemSelected(
                            title: e.split(":")[0].capitalize,
                            isActive: selectedIndex == index,
                            onTap: () {
                              if (e == "Semua") {
                                _getAll();
                              } else if (e == "Lebih banyak") {
                                // _article.selectedByTag.value = "";
                                // Get.to(() => const ArticleScreen());
                              } else {
                                _getByTag(e);
                              }

                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: InkWell(
                      onTap: () {
                        // _article.selectedByTag.value = "";
                        // Get.to(() => const ArticleScreen());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        margin: const EdgeInsets.only(left: 5),
                        child: const Icon(
                          Icons.chevron_right,
                          size: 20,
                          color: AppColors.primaryColor,
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor),
                            borderRadius: BorderRadius.circular(100)),
                      ),
                    ),
                  )
                ],
              )),
          const SizedBox(height: 19),
          /* false
              ?SizedBox(
            height: 171,
            width: double.infinity,
            child: Center(child: loadingWidget),
          )
              :*/
          SizedBox(
            height: 240,
            width: double.infinity,
            child: LazyLoadScrollView(
              onEndOfPage: () {
                // _article.loadNextPage();
              },
              isLoading: true,
              scrollDirection: Axis.horizontal,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 5),
                physics: const BouncingScrollPhysics(),
                itemCount: 0,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, idx) {
                  final article = null;

                  /// CARD ARTICLE
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Container() /*ComplaintScreen(
            serviceId: "yUIh9XQqwWy|MhyZyvVteRY",
            title: "Pemeriksaan Umum",
            logoPath: "${Assets.iconsPath}/ic_umum.png",
            titleColor: AppColors.orangePrimaryColor,
          )*/
                            ),
                      );
                    },
                    child: Container(
                      width: 280,
                      padding: const EdgeInsets.all(5),
                      margin: EdgeInsets.only(
                        left: idx == 0 ? 30 : 8,
                        right: idx == true ? 30 : 0,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.whiteColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 3),
                            ),
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          article.thumbnail == null || article.thumbnail == ""
                              ? Container(
                                  width: double.infinity,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Image.asset(
                                    "${Assets.othersPath}/artic.png",
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  height: 130,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      article.thumbnail.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                          /// TITLE
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 6,
                              top: 5,
                            ),
                            child: Text(
                              article.title.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.subtitle.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColor,
                                fontSize: 12,
                              ),
                            ),
                          ),

                          /// DESC
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Text(
                              article.shortDesc.toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: AppTheme.subtitle.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.greyColor,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 19),
        ],
      ),
    );
  }

  _getByTag(String tag) {
    // _article.selectedByTag.value = tag;
    // _article.page.value = 1;
    // _article.getArticle();
  }

  _getAll() {
    // _article.selectedByTag.value = "";
    // _article.page.value = 1;
    // _article.article.clear();
    // _article.getArticle();
  }

  final List<Widget> imageSliders = imgList.map((item) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      child: Image.asset(
        item,
        fit: BoxFit.contain,
        width: 1000.0,
      ),
    );
  }).toList();

  List<Widget> menus(BuildContext context) {
    return [
      MenuItems(
        title: "Umum",
        colors: AppColors.orangeColor,
        imagePath: "${Assets.iconsPath}/ic_home_umum.png",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Container() /*ComplaintScreen(
            serviceId: "yUIh9XQqwWy|MhyZyvVteRY",
            title: "Pemeriksaan Umum",
            logoPath: "${Assets.iconsPath}/ic_umum.png",
            titleColor: AppColors.orangePrimaryColor,
          )*/
                ),
          );
        },
      ),
      MenuItems(
        title: "SWAB",
        colors: AppColors.redColor,
        imagePath: "${Assets.iconsPath}/ic_home_swab.png",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Container() /*const ComplaintScreen(
            serviceId: "LPH5Qihd5Ux|JtpO3a0CUhm",
            title: "Swab Antigen",
            logoPath: "${Assets.iconsPath}/ic_swab.png",
            titleColor: AppColors.redPrimaryColor,
          )()*/
                ),
          );
        },
      ),
      MenuItems(
        title: "Gula Darah",
        colors: AppColors.greenColor,
        imagePath: "${Assets.iconsPath}/ic_home_gula.png",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Container() /* const ComplaintScreen(
            serviceId: "XwbXDJqe9Je|ytHrqQJuamG",
            title: "Periksa Gula Darah",
            logoPath: "${Assets.iconsPath}/ic_gula.png",
            titleColor: AppColors.greenPrimaryColor,
          )()*/
                ),
          );
        },
      ),
      MenuItems(
        title: "Kolesterol",
        colors: AppColors.blueColor,
        imagePath: "${Assets.iconsPath}/ic_home_priksa.png",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Container() /* const ComplaintScreen(
            serviceId: "n7XVDlPb8WJ|q8dFWkwNMJS",
            title: "Periksa Kolesterol",
            logoPath: "${Assets.iconsPath}/ic_priksa.png",
            titleColor: AppColors.bluePrimaryColor,
          )()*/
                ),
          );
        },
      ),
      MenuItems(
        title: "Asam Urat",
        colors: AppColors.purpleColor,
        imagePath: "${Assets.iconsPath}/ic_home_asam.png",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Container() /*const ComplaintScreen(
            serviceId: "enzACS7PSah|gzhaZrxlnvQ",
            title: "Periksa Asam Urat",
            logoPath: "${Assets.iconsPath}/ic_asam.png",
            titleColor: AppColors.purplePrimaryColor,
          )()*/
                ),
          );
        },
      ),
      MenuItems(
        title: "Khitanan",
        colors: AppColors.pinkColor,
        imagePath: "${Assets.iconsPath}/ic_home_khitan.png",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Container() /* const ComplaintScreen(
            serviceId: "fFLfhYeNaxA|lmeeX5ZJ8i2",
            title: "Khitanan",
            logoPath: "${Assets.iconsPath}/ic_khitan.png",
            titleColor: AppColors.redPrimaryColor,
          )()*/
                ),
          );
        },
      ),
      MenuItems(
        title: "Luka",
        colors: AppColors.yellowColor,
        imagePath: "${Assets.iconsPath}/ic_home_luka.png",
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Container() /*const ComplaintScreen(
            serviceId: "b3KEOx3Aa0H|zclX2e1l3bcs",
            title: "Perawatan Luka",
            logoPath: "${Assets.iconsPath}/ic_luka.png",
            titleColor: AppColors.yellowColor,
          ),*/
                ),
          );
        },
      ),
      MenuItems(
        title: "Chat Dokter",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconsPath}/ic_chat.png",
        showBadge: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Container() /*const SpecializationScreen()*/),
          );
        },
      ),
    ];
  }
}
