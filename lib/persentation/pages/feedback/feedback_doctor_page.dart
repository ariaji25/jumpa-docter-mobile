import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jd_mobile/common/extensions/context_ext.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/size.dart';

import '../../../common/resources/assets.dart';
import '../../../common/theme/theme.dart';
import '../../widgets/app_bars.dart';
import '../../widgets/buttons.dart';
import '../../widgets/confirm_modal.dart';
import '../../widgets/logo_widget.dart';
import '../base/base_page.dart';
import '../chat/components/profile_chat.dart';

class FeedbackDoctorPage extends StatefulWidget {
  static const routeName = "/FeedbackDoctorPage";
  const FeedbackDoctorPage({Key? key}) : super(key: key);

  @override
  State<FeedbackDoctorPage> createState() => _FeedbackDoctorPageState();
}

class _FeedbackDoctorPageState extends State<FeedbackDoctorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppsBar(
        elevation: 0.0,
        flexibleSpaceBar: FlexibleSpaceBar(
          centerTitle: true,
          title: Container(
            margin: const EdgeInsets.only(right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      BasePage.routeName,
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: AppColors.whiteColor,
                  ),
                ),
                LogoWidget.logoIcon(height: 23, width: 65, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: SizeConstants.margin, vertical: SizeConstants.margin),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Penilaian dokter",
                style: AppTheme.heading5.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ),
              context.sbHeight(size: 3),
              Text(
                "Berikan penilaian atas pelayanan dokter",
                style: AppTheme.subtitle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColorDarkColor,
                ),
              ),
              context.sbHeight(size: 40),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const ProfileChatWidget(
                        size: 46,
                      ),
                      context.sbWidth(size: 15),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "dr. Ralph Edwards",
                            style: AppTheme.bodyText.copyWith(
                                fontSize: 16,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "No. STR : 1234567890",
                            style: AppTheme.bodyText.copyWith(
                                fontSize: 12,
                                color: AppColors.primaryColorDarkColor,
                                fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: const Color(0XFF2D3748),
                                    borderRadius: BorderRadius.circular(2)),
                                child: Image.asset(
                                  "${Assets.iconsPath}/doctor_item.png",
                                  height: 8,
                                  width: 8,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "6 Thn - Spesialisasi anak",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.bodyText.copyWith(
                                    fontSize: 12,
                                    color: const Color(0XFF2D3748),
                                    fontWeight: FontWeight.w400),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    height: 1,
                    color: Color(0XFFA6B7D4),
                  )
                ],
              ),
              context.sbHeight(size: 25),
              Center(
                child: RatingBar.builder(
                  initialRating: 0.5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 30,
                  unratedColor: const Color(0XFFE1E8FF),
                  itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, _) {
                    return Image.asset("${Assets.iconsPath}/ic_stars.png");
                  },
                  onRatingUpdate: (rating) {
                    //
                  },
                ),
              ),
              context.sbHeight(size: 25),
              Text(
                "Kesan kamu konsultasi bersama dokter (Opsional)",
                style: AppTheme.heading5.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColorDarkColor,
                ),
              ),
              context.sbHeight(size: 10),
              TextFormField(
                minLines: 6,
                keyboardType: TextInputType.multiline,
                maxLines: 7,
                maxLength: 200,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              context.sbHeight(size: 20),
              MultiSelectContainer(items: [
                _itemSelectFeedback(label: "Sangat memuaskan"),
                _itemSelectFeedback(label: "Informatif"),
                _itemSelectFeedback(label: "Ramah"),
                _itemSelectFeedback(label: "Membantu"),
                _itemSelectFeedback(label: "Penjelasannya bagus"),
                _itemSelectFeedback(label: "Responnya cepat"),
              ], onChange: (allSelectedItems, selectedItem) {}),
              context.sbHeight(size: 20),
              Buttons(
                title: "Kirim",
                borderRadius: 6,
                onTap: () {
                  Alerts.showAlertDialogSuccess(context);
                },
                marginBottom: 0,
              )
            ],
          ),
        ),
      ),
    );
  }

  MultiSelectCard<String> _itemSelectFeedback(
      {required String label, String? value}) {
    return MultiSelectCard(
      value: value ?? label,
      label: label,
      contentPadding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      textStyles: MultiSelectItemTextStyles(
          textStyle: AppTheme.bodyText.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColorDarkColor),
          selectedTextStyle: AppTheme.bodyText.copyWith(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white)),
      decorations: MultiSelectItemDecorations(
        decoration: BoxDecoration(
            color: AppColors.grey200Color,
            borderRadius: BorderRadius.circular(45)),
        selectedDecoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(45)),
      ),
    );
  }
}
