import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/persentation/widgets/logo_widget.dart';

import '../../../common/extensions/padding_ext.dart';
import '../../../common/resources/assets.dart';
import '../../../common/theme/theme.dart';
import '../../widgets/app_bars.dart';
import '../../widgets/menu_item.dart';
import 'list_doctor_page.dart';

class SpecializationPage extends StatefulWidget {
  static const routeName = "/SpecializationPage";

  const SpecializationPage({Key? key}) : super(key: key);

  @override
  State<SpecializationPage> createState() => _SpecializationPageState();
}

class _SpecializationPageState extends State<SpecializationPage> {
  final TextEditingController _searchController = TextEditingController();

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
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back),
            ),
            LogoWidget.logoWhite
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: AppColors.primaryColor, height: 1.0),
        ),
      ),
      body: Padding(
        padding: paddingAll(SizeConstants.margin),
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
                    fillColor: AppColors.grey200Color,
                    filled: true,
                    contentPadding: const EdgeInsets.all(10),
                    hintText: "Cari spesialisasi",
                    hintStyle: AppTheme.bodyText.copyWith(
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
                      "${Assets.iconsPath}/search.png",
                    ),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Pilih dokter spesialis anda",
              style: AppTheme.bodyText.copyWith(
                  fontSize: 14,
                  color: AppColors.primaryColorDarkColor,
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
                children: listMenus(),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> listMenus() {
    return [
      MenuItems(
        title: "Umum",
        colors: AppColors.orangeColor,
        imagePath: "${Assets.iconSpecialistPath}/umum.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Spesialisasi Gigi",
        colors: AppColors.redColor,
        imagePath: "${Assets.iconSpecialistPath}/spesialis_gigi.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Psikiater",
        colors: AppColors.greenColor,
        imagePath: "${Assets.iconSpecialistPath}/psikiater.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Seksologi & Reproduksi Pria",
        colors: AppColors.blueColor,
        imagePath: "${Assets.iconSpecialistPath}/seksiologi.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Dokter Konsulen",
        colors: AppColors.purpleColor,
        imagePath: "${Assets.iconSpecialistPath}/konsulen.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Laktasi",
        colors: AppColors.pinkColor,
        imagePath: "${Assets.iconSpecialistPath}/laktasi.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Program Hamil",
        colors: AppColors.yellowColor,
        imagePath: "${Assets.iconSpecialistPath}/program_hamil.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Spesialisasi Mata",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/spesialis_mata.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Penyakit dalam",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/penyakit_dalam.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Medikolegal & Hukum Kesehatan",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/medikolegal.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Spesialisasi Anak",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/spesialis_anak.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Spesialisasi Kulit",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/spesialis_kulit.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Spesialis Jantung",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/spesialis_jantung.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Spesialis Bedah",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/spesialis_bedah.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Spesialis Saraf",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/spesialis_saraf.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Dokter Hewan",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/dokter_hewan.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Psikolog Klinis",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/psikolog_klinis.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Kesehatan Paru",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/kesehatan_paru.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Spesialis Gizi",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/spesialis_gizi.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Fisioterapi & Rehabilitasi",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/fisioterapi.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Spesialisasi Kandungan",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/spesialis_kandungan.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
      MenuItems(
        title: "Spesialisasi THT",
        colors: AppColors.pinkOtherColor,
        imagePath: "${Assets.iconSpecialistPath}/spesialis_tht.png",
        size: 40,
        onTap: () {
          Navigator.pushNamed(
            context,
            ListDoctorPage.routeName,
          );
        },
      ),
    ];
  }
}
