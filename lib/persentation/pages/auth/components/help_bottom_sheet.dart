import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import 'package:jd_mobile/persentation/pages/global/components/text_heading.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height * .80,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 107,
              height: 3,
              color: AppColors.greyColor,
              margin: const EdgeInsets.symmetric(vertical: 5),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Text(
              "Kesulitan login",
              textAlign: TextAlign.center,
              style: AppTheme.heading6.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(height: 10),
                  const TextHeadings(
                    keys: "1",
                    value: "Pastikan kamu memasukkan no HP yang benar.",
                  ),
                  const SizedBox(height: 10),
                  const TextHeadings(
                    keys: "2",
                    value:
                        "No hp yang dimasukkan harus sudah terdaftar ke “Whatsapp” karena kode OTP akan dikirimkan melalui Whatsapp",
                  ),
                  const SizedBox(height: 10),
                  const TextHeadings(
                    keys: "3",
                    value:
                        "Jika masih mengalami kendala saat login cobalah menggunakan no HP (Whatsapp) yang lain.",
                  ),
                  const SizedBox(height: 10),
                  const TextHeadings(
                    keys: "4",
                    value:
                        "Dan pastikan kamu tidak memberitahukan kode OTP kepada siapapun yang mengatasnamakan JumpaDokter maupun pihak lain.",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
