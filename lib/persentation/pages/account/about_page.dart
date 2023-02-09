import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/assets.dart';
import 'package:jd_mobile/common/theme/theme.dart';
import '../../../common/resources/colors.dart';
import '../../widgets/app_bars.dart';
import '../../widgets/logo_widget.dart';

class AboutPage extends StatefulWidget {
  static const routeName = "/AboutPage";
  const AboutPage({Key? key}) : super(key: key);

  @override
  AboutPageState createState() => AboutPageState();
}

class AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
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
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: AppColors.whiteColor,
                  ),
                ),
                LogoWidget.logoIcon(
                  height: 23,
                  width: 65,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Transform.translate(
        offset: const Offset(0, -1),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildBody(),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 30,
        left: 25,
        right: 25,
      ),
      child: Column(
        children: [
          LogoWidget.logoIcon(
            height: 52,
            width: 147,
            color: Colors.white,
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Text(
                "Tentang JumpaDokter",
                style: AppTheme.bodyText.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Image.asset(
                "${Assets.iconsPath}/flat_about.png",
                width: 12,
                height: 12,
              ),
            ],
          ),
          _buildItemAbout(
            "Praktek Umum JumpaDokter didirikan pada bulan Januari 2022, dengan konsep sebagai klinik umum untuk melayani masyarakat terutama di area Kota Medan dan sekitarnya.",
          ),
          _buildItemAbout(
            "Sejalan dengan meningkatnya kebutuhan dan permintaan pasien, maka Praktek Umum JumpaDokter meluaskan jangkauan pelayanan kesehatan untuk memberikan pelayanan kesehatan dari rumah.",
          ),
          _buildItemAbout(
            "Pasien bisa melakukan pemesanan untuk jadwal bertemu dokter melalui Whatsapp resmi JumpaDokter. Pasien juga dapat memilih jenis layanan kesehatan dan mendapatkan layanan dari rumah atau langsung berkunjung ke lokasi klinik.",
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Text(
                "Layanan JumpaDokter",
                style: AppTheme.bodyText.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Image.asset(
                "${Assets.iconsPath}/baseline_medication.png",
                width: 12,
                height: 12,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          _buildDetailMenuAbout(
            "${Assets.iconsPath}/umum_white.png",
            "Pemeriksaan Umum",
          ),
          _buildDetailMenuAbout(
            "${Assets.iconsPath}/swab.png",
            "SWAB Antigen",
          ),
          _buildDetailMenuAbout(
            "${Assets.iconsPath}/gula_darah.png",
            "Pemeriksaan gula darah",
          ),
          _buildDetailMenuAbout(
            "${Assets.iconsPath}/kolesterol.png",
            "Periksa Kolesterol",
          ),
          _buildDetailMenuAbout(
            "${Assets.iconsPath}/asam_urat.png",
            "Periksa Asam Urat",
          ),
          _buildDetailMenuAbout(
            "${Assets.iconsPath}/khitan.png",
            "Khitanan",
          ),
          _buildDetailMenuAbout(
            "${Assets.iconsPath}/luka.png",
            "Perawatan Luka",
          ),
        ],
      ),
    );
  }

  Widget _buildItemAbout(String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          text,
          textAlign: TextAlign.justify,
          style: AppTheme.bodyText.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailMenuAbout(String asset, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            asset,
            width: 22,
            height: 22,
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            flex: 2,
            child: Text(
              text,
              textAlign: TextAlign.left,
              style: AppTheme.subtitle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
