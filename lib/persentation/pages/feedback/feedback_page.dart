import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/resources/dialogs.dart';
import 'package:jd_mobile/common/resources/size.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/persentation/widgets/app_bars.dart';
import 'package:jd_mobile/common/extensions/context_ext.dart';
import 'package:jd_mobile/persentation/widgets/button_widget.dart';

class FeedbackPage extends StatefulWidget {
  static const routeName = '/FeedbackPage';
  const FeedbackPage({Key? key}) : super(key: key);

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
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
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: AppColors.whiteColor,
                  ),
                ),
                Image.asset(
                  Assets.logoSplash,
                  height: 23,
                  width: 65,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SizeConstants.margin,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              context.sbHeight(size: 150),
              Text(
                "Kritik dan saran",
                style: AppTheme.heading5.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              context.sbHeight(size: 3),
              Text(
                "Beri kami kritik dan saran untuk membuat platform ini semakin lebih baik lagi.",
                style: AppTheme.heading5.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                ),
              ),
              context.sbHeight(size: 37),
              Center(
                child: RatingBar.builder(
                  initialRating: 0.5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) {
                    return Image.asset(Assets.icStar);
                  },
                  onRatingUpdate: (rating) {
                    //
                  },
                ),
              ),
              context.sbHeight(size: 39),
              Text(
                "Apa yang bisa kami perbaiki untuk kedepannya?",
                style: AppTheme.heading5.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                ),
              ),
              context.sbHeight(size: 9),
              TextFormField(
                minLines: 6,
                keyboardType: TextInputType.multiline,
                maxLines: 7,
                maxLength: 500,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: AppColors.primaryColor,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              context.sbHeight(size: 33),
              ButtonWidget(
                title: "Kirim Masukkan",
                onTap: () {
                  return Dialogs.shoeDialogSuccesSendFeedback(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
