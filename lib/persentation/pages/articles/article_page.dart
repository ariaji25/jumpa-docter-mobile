import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/common/utils/state_enum.dart';
import 'package:jd_mobile/persentation/widgets/logo_widget.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';

import '../../../common/resources/colors.dart';
import '../../provider/article/article_provider.dart';
import '../../widgets/app_bars.dart';
import '../../widgets/loading.dart';
import '../../widgets/text_field.dart';
import '../../widgets/universal_empty_state.dart';
import 'components/card_tile.dart';
import 'detail_article_page.dart';

class ArticlePage extends StatefulWidget {
  static const routeName = "/ArticlePage";

  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ArticleProvider articleProvider =
          Provider.of<ArticleProvider>(context, listen: false);
      articleProvider.getArticle();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ArticleProvider articleProvider =
        Provider.of<ArticleProvider>(context, listen: true);
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: SizeConstants.margin),
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  "Info seputar gaya hidup sehat",
                  style: AppTheme.subtitle
                      .copyWith(fontSize: 12, color: Colors.white),
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: SizeConstants.margin),
                child: Text(
                  "JumpaDokter\nUpdate",
                  style: AppTheme.subtitle.copyWith(
                    fontSize: 24,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: SizeConstants.margin),
                child: textfieldSearchArticleWidget(
                  controller: articleProvider.searchCtrl,
                  onTap: () {
                    articleProvider.setSelectedByTag("");
                    articleProvider.setSearch(articleProvider.searchCtrl.text);
                    if (articleProvider.search.isNotEmpty) {
                      articleProvider.getArticle();
                    }
                  },
                ),
              ),
              const SizedBox(height: 29),
              SizedBox(
                height: 30,
                width: double.infinity,
                child: articleProvider.tag.isNotEmpty
                    ? ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: SizeConstants.margin),
                        itemCount: articleProvider.tag.length - 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          final tags = articleProvider.tag[index];

                          return TagSelecetdItem(
                            tags: tags,
                            index: index,
                            isSelecetd: articleProvider.selectedIndex == index,
                            onTap: () {
                              articleProvider.setSearch("");
                              if (tags == "Semua") {
                                _getAll(articleProvider);
                              } else {
                                _getByTag(articleProvider, tags);
                              }

                              articleProvider.setSelectedIndex(index);
                            },
                          );
                        },
                      )
                    : Container(),
              ),
              const SizedBox(height: 29),
              articleProvider.requestStateArticles == RequestState.Loading
                  ? const Center(child: Loading())
                  : articleProvider.requestStateArticles ==
                              RequestState.Loaded &&
                          articleProvider.article.isNotEmpty
                      ? SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: LazyLoadScrollView(
                            onEndOfPage: () {
                              if (!articleProvider.lastPage) {
                                articleProvider.loadNextPage();
                              }
                            },
                            isLoading: articleProvider.lastPage,
                            scrollDirection: Axis.horizontal,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: articleProvider.article.length,
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: SizeConstants.margin),
                              itemBuilder: (context, index) {
                                final data = articleProvider.article[index];
                                return cardTileArticle(data, () {
                                  Navigator.pushNamed(
                                      context, DetailArticlePage.routeName,
                                      arguments: data);
                                }, index, articleProvider.article.length);
                              },
                            ),
                          ),
                        )
                      : universalEmptyState(label: 'Artikel Kosong'),
            ],
          ),
        ));
  }

  _getByTag(ArticleProvider articleProvider, String tag) {
    articleProvider.setSelectedByTag(tag);
    articleProvider.setPage(1);
    articleProvider.getArticle();
  }

  _getAll(ArticleProvider articleProvider) {
    articleProvider.setSelectedByTag("");
    articleProvider.setPage(1);
    articleProvider.clearArticle();
    articleProvider.getArticle();
  }
}

class TagSelecetdItem extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const TagSelecetdItem({
    required this.tags,
    required this.index,
    required this.isSelecetd,
    required this.onTap,
  });

  final String tags;
  final int index;
  final bool isSelecetd;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 5),
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelecetd ? AppColors.primaryColor : Colors.transparent,
        ),
        child: Center(
          child: Text(
            tags.split(":")[0],
            style: AppTheme.bodyText.copyWith(
              color: isSelecetd ? AppColors.whiteColor : AppColors.greyColor,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
