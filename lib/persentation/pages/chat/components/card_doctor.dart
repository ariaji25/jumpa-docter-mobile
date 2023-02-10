import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jd_mobile/common/extensions/context_ext.dart';

import '../../../../common/resources/assets.dart';
import '../../../../common/resources/colors.dart';
import '../../../../common/theme/theme.dart';
import 'profile_chat.dart';

class DoctorItemWidget extends StatelessWidget {
  final Function onTap;

  const DoctorItemWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
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
                    "Spesialisasi anak",
                    style: AppTheme.bodyText.copyWith(
                        fontSize: 12,
                        color: AppColors.grey800Color,
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
                        "2 Thn",
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
                      Image.asset(
                        "${Assets.iconsPath}/star-fill.png",
                        height: 12,
                        width: 12,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "4.5",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTheme.bodyText.copyWith(
                            fontSize: 12,
                            color: const Color(0XFFFFA800),
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rp. 50.000",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.bodyText.copyWith(
                                fontSize: 12,
                                color: const Color(0XFFEF0C11),
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.lineThrough),
                          ),
                          Text(
                            "Rp. 30.000",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTheme.bodyText.copyWith(
                                fontSize: 12,
                                color: AppColors.primaryColorDarkColor,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () => onTap(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            children: [
                              SvgPicture.asset("${Assets.iconsPath}/chat.svg",
                                  width: 12, height: 12, color: Colors.white),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Chat",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTheme.bodyText.copyWith(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            height: 1,
            color: Color(0XFFA6B7D4),
          )
        ],
      ),
    );
  }
}
