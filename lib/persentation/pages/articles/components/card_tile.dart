import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/domain/entities/articles/article_entites.dart';

import '../../../../common/resources/assets.dart';

Widget cardTileArticle(ArticlesEntities data, Function onTap, int index, int length) {
  return InkWell(
    onTap: () {
      onTap();
    },
    child: Container(
      width: 228,
      padding: const EdgeInsets.all(5),
      margin: EdgeInsets.only(
          left: index == 0 ? 0 : 8,
          right: index == length - 1 ? 0 : 0,
          bottom: 5,
          top: 5),
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
          data.thumbnail == null || data.thumbnail == ""
              ? Container(
                  width: double.infinity,
                  height: 130,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
                      data.thumbnail.toString(),
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
              data.title.toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:AppTheme.subtitle.copyWith(
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
              data.shortDesc.toString(),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: AppTheme.subtitle.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.greyColor,
                fontSize: 12,
              ),
            ),
          ),
          Wrap(
              children: data.tags!.split(",").map(
            (e) {
              return Container(
                  margin: const EdgeInsets.only(right: 2, bottom: 2),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(65),
                    color: const Color(0xffE1E8FF)
                  ),
                  child: Text(
                    e,
                    style: AppTheme.bodyText.copyWith(
                        color: AppColors.purplePrimaryTextColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ));
            },
          ).toList())
        ],
      ),
    ),
  );
}

