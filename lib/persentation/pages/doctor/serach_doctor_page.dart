import 'package:flutter/material.dart';
import 'package:jd_mobile/common/extensions/padding_ext.dart';
import 'package:jd_mobile/common/extensions/context_ext.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/persentation/pages/doctor/components/doctor_card.dart';
import 'package:jd_mobile/persentation/widgets/app_bars.dart';
import 'package:jd_mobile/persentation/widgets/button_widget.dart';

class SearchDoctorPage extends StatefulWidget {
  const SearchDoctorPage({Key? key}) : super(key: key);

  @override
  State<SearchDoctorPage> createState() => _SearchDoctorPageState();
}

class _SearchDoctorPageState extends State<SearchDoctorPage> {
  final TextEditingController _searchCtrl = TextEditingController();

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
                onPressed: () {},
                icon: const Icon(Icons.arrow_back),
              ),
              Image.asset(
                Assets.logoSplash,
                height: 23,
                width: 65,
                color: Colors.white,
              ),
            ],
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: paddingOnly(
                top: context.padding1,
                left: context.padding1,
                right: context.padding1,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  SearchButtonWidget(
                    title: "Daerah Klinik",
                    subtitle: "Pilih",
                    onTap: () {},
                  ),
                  const SizedBox(height: 15),
                  SearchButtonWidget(
                    title: "Pilih Klinik",
                    subtitle: "Pilih",
                    onTap: () {},
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 6.0,
                      horizontal: 12.0,
                    ),
                    decoration: const BoxDecoration(
                      color: Color(0xffEDF2F7),
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.search),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: _searchCtrl,
                            decoration: const InputDecoration.collapsed(
                              filled: true,
                              fillColor: Color(0xffEDF2F7),
                              hoverColor: Color(0xffEDF2F7),
                              hintText: "Cari Dokter",
                            ),
                            onFieldSubmitted: (value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    "Hasil Pencarian",
                    textAlign: TextAlign.left,
                    style: AppTheme.bodyText.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.primaryColorDarkColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView.count(
                  physics: const ScrollPhysics(),
                  padding: paddingOnly(
                    top: 10.0,
                    left: context.padding1,
                    right: context.padding1,
                  ),
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio:
                      DoctorCard.itemWidth / DoctorCard.itemHeight,
                  children: List.generate(
                    10,
                    (index) {
                      return DoctorCard(
                        onTap: () {},
                        name: "MUHAMMAD",
                        docterType: "Dokter Umum",
                        imagePath: null,
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
