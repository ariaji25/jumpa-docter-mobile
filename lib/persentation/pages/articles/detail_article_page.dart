import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/domain/entities/articles/article_entites.dart';
import 'package:jd_mobile/persentation/widgets/logo_widget.dart';
import 'package:provider/provider.dart';

import '../../../common/env/env.dart';
import '../../../common/resources/colors.dart';
import '../../../common/resources/size.dart';
import '../../../common/theme/theme.dart';
import '../../../injection.dart';
import '../../provider/article/article_provider.dart';
import '../../widgets/app_bars.dart';

class DetailArticlePage extends StatefulWidget {
  static const routeName = "/DetailArticlePage";

  const DetailArticlePage({
    Key? key,
  }) : super(key: key);

  @override
  State<DetailArticlePage> createState() => _DetailArticleState();
}

class _DetailArticleState extends State<DetailArticlePage> {
  final Env _env = getIt<Env>();

  @override
  Widget build(BuildContext context) {
    ArticleProvider articleProvider =
        Provider.of<ArticleProvider>(context, listen: true);
    final article =
        ModalRoute.of(context)?.settings.arguments as ArticlesEntities;
    return Scaffold(
        backgroundColor: Colors.white,
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
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: AppColors.whiteColor,
                    ),
                  ),
                  LogoWidget.logoIcon(
                      height: 23, width: 65, color: Colors.white),
                ],
              ),
            ),
          ),
        ),
        body: Transform.translate(
          offset: const Offset(0, -5),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                article.thumbnail == null || article.thumbnail == ""
                    ? SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          "${Assets.othersPath}/artic.png",
                          height: 239,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.network(
                        article.thumbnail.toString(),
                        width: double.infinity,
                        height: 239,
                        fit: BoxFit.cover,
                      ),
                Transform.translate(
                  offset: const Offset(0, -50),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: SizeConstants.margin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// DATE
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Visibility(
                                    visible: article.tags != null &&
                                        article.tags != "",
                                    child: Wrap(
                                      children:
                                          article.tags!.split(",").map((e) {
                                        return Container(
                                          margin: const EdgeInsets.only(
                                            top: 3,
                                            bottom: 3,
                                            right: 3,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffE1E8FF),
                                            borderRadius:
                                                BorderRadius.circular(21),
                                          ),
                                          child: Text(
                                            e.toString(),
                                            style: AppTheme.bodyText.copyWith(
                                              fontSize: 12,
                                              color: AppColors
                                                  .purplePrimaryTextColor,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: article.createdAt != null,
                                  child: Text(
                                    "${article.createdAt?.day} ${article.createdAt?.month} ${article.createdAt?.year}",
                                    style: AppTheme.subtitle.copyWith(
                                        color: AppColors.primaryColorDarkColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                )
                              ],
                            ),
                          ),

                          /// CONTENT
                          const SizedBox(height: 14),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title ?? "",
                                textAlign: TextAlign.left,
                                style: AppTheme.subtitle.copyWith(
                                  color: AppColors.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Penulis : JumpaDokter",
                                      style: AppTheme.subtitle.copyWith(
                                        color: AppColors.primaryDarkLightColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  InkWell(
                                    onTap: () => share(article),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                              color: AppColors.primaryColor,
                                              width: 1)),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "${Assets.iconsPath}/share.png",
                                            width: 12,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Bagikan artikel",
                                            style: AppTheme.bodyText.copyWith(
                                              fontSize: 12,
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Html(
                            data: article.body,
                            style: {
                              "body": Style(
                                  fontSize: FontSize(12),
                                  color: AppColors.primaryColorDarkColor)
                            },
                          ),
                          const SizedBox(height: 40),
                          Text(
                            "Artikel yang mungkin anda suka",
                            style: AppTheme.subtitle.copyWith(
                              color: AppColors.primaryColorDarkColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          /// ARTICLE FAVORITE
                          const SizedBox(height: 15),
                          Column(
                            children: articleProvider.articleFav.map((data) {
                              return InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, DetailArticlePage.routeName,
                                      arguments: data);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: Row(
                                    children: [
                                      /// COLUMN
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.title ?? "",
                                              style: AppTheme.subtitle.copyWith(
                                                color: AppColors.primaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Visibility(
                                              visible: data.tags != null &&
                                                  data.tags != "",
                                              child: Wrap(
                                                children: data.tags!
                                                    .split(",")
                                                    .map((e) {
                                                  return Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                      top: 3,
                                                      bottom: 3,
                                                      right: 3,
                                                    ),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5,
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xffECE8FF),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              21),
                                                    ),
                                                    child: Text(
                                                      e.toString(),
                                                      style: AppTheme.bodyText
                                                          .copyWith(
                                                        fontSize: 12,
                                                        color: AppColors
                                                            .purplePrimaryTextColor,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              data.shortDesc ?? "",
                                              maxLines: 5,
                                              style: AppTheme.subtitle.copyWith(
                                                color: AppColors
                                                    .primaryColorDarkColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      data.thumbnail == null ||
                                              data.thumbnail == ""
                                          ? ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              child: SizedBox(
                                                height: 64,
                                                width: 64,
                                                child: Image.asset(
                                                  "${Assets.othersPath}/artic.png",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5)),
                                              child: SizedBox(
                                                height: 64,
                                                width: 64,
                                                child: Image.network(
                                                  data.thumbnail.toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> share(ArticlesEntities articles) async {
    await FlutterShare.share(
      title: '${articles.title}',
      text: '${articles.shortDesc}',
      linkUrl: '${_env.baseUrl ?? ''}/articles/detail/${articles.id}',
    );
  }
}
