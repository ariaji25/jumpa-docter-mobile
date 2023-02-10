import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jd_mobile/common/const.dart';
import 'package:jd_mobile/common/exts.dart';

import '../../common/logo.dart';
import '../../common/theme/theme.dart';
import '../../common/widgets/appbar.dart';
import '../../common/widgets/menu_item.dart';
import 'list_doctor_page.dart';

class SpecializationPage extends StatefulWidget {
  const SpecializationPage({Key? key}) : super(key: key);

  @override
  State<SpecializationPage> createState() => _SpecializationPageState();
}

class _SpecializationPageState extends State<SpecializationPage> {
  final TextEditingController _searchController = TextEditingController();

  List<Widget> menus = [
    MenuItems(
      title: "Umum",
      colors: Themes.orangeColor,
      imagePath: "$iconSpesialisPath/umum.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Spesialisasi Gigi",
      colors: Themes.redColor,
      imagePath: "$iconSpesialisPath/spesialis_gigi.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Psikiater",
      colors: Themes.greenColor,
      imagePath: "$iconSpesialisPath/psikiater.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Seksologi & Reproduksi Pria",
      colors: Themes.blueColor,
      imagePath: "$iconSpesialisPath/seksiologi.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Dokter Konsulen",
      colors: Themes.purpleColor,
      imagePath: "$iconSpesialisPath/konsulen.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Laktasi",
      colors: Themes.pinkColor,
      imagePath: "$iconSpesialisPath/laktasi.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Program Hamil",
      colors: Themes.yellowColor,
      imagePath: "$iconSpesialisPath/program_hamil.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Spesialisasi Mata",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/spesialis_mata.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Penyakit dalam",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/penyakit_dalam.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Medikolegal & Hukum Kesehatan",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/medikolegal.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Spesialisasi Anak",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/spesialis_anak.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Spesialisasi Kulit",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/spesialis_kulit.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Spesialis Jantung",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/spesialis_jantung.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Spesialis Bedah",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/spesialis_bedah.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Spesialis Saraf",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/spesialis_saraf.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Dokter Hewan",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/dokter_hewan.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Psikolog Klinis",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/psikolog_klinis.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Kesehatan Paru",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/kesehatan_paru.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Spesialis Gizi",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/spesialis_gizi.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Fisioterapi & Rehabilitasi",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/fisioterapi.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Spesialisasi Kandungan",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/spesialis_kandungan.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
    MenuItems(
      title: "Spesialisasi THT",
      colors: Themes.pinkOtherColor,
      imagePath: "$iconSpesialisPath/spesialis_tht.png",
      size: 40,
      onTap: () {
        Get.to(
          () => const ListDoctorScreen(),
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppsBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            logoWhite
          ],
        ),
        bottom: PreferredSize(
          child: Container(color: Themes.primaryColor, height: 1.0),
          preferredSize: const Size.fromHeight(1.0),
        ),
      ),
      body: Padding(
        padding: paddingAll(margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: TextFormField(
                  controller: _searchController,
                  autofocus: false,
                  focusNode: FocusNode(canRequestFocus: false),
                  onSaved: (val) {},
                  cursorColor: Theme.of(context).colorScheme.primary,
                  decoration: InputDecoration(
                    fillColor: Themes.grey200Color,
                    filled: true,
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Cari spesialisasi",
                    hintStyle: kBodyText.copyWith(
                        fontSize: 12,
                        color: const Color(0XFFA6B7D4),
                        fontWeight: FontWeight.w400),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(
                          color: Color(0XFFEDF2F7),
                          width: 1,
                        )),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(
                          color: Color(0XFFEDF2F7),
                          width: 1,
                        )),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        borderSide: BorderSide(
                          color: Color(0XFFEDF2F7),
                          width: 1,
                        )),
                    prefixIcon: Image.asset(
                      "$iconsPath/search.png",
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Pilih dokter spesialis anda",
              style: kBodyText.copyWith(
                  fontSize: 14,
                  color: Themes.primaryColorDarkColor,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                crossAxisCount: 4,
                children: menus,
              ),
            )
          ],
        ),
      ),
    );
  }
}
