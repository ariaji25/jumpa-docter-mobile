import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';

import '../../common/extensions/padding_ext.dart';
import '../../common/theme/theme.dart';

bottomSheetPrivacyPolicyWidget(BuildContext context) {
  return showModalBottomSheet(
    enableDrag: true,
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return const PrivacyPolicyWidget();
    },
  );
}

class PrivacyPolicyWidget extends StatelessWidget {
  const PrivacyPolicyWidget({Key? key}) : super(key: key);

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
              margin: const EdgeInsets.symmetric(
                vertical: 5,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "KEBIJAKAN PRIVASI\nJUMPADOKTER",
              textAlign: TextAlign.center,
              style: AppTheme.heading6.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Kebijakan privasi ini (“Kebijakan Privasi”) akan menjelaskan bagaimana PT Castellum Digital Indonesia dan setiap perusahaan afiliasinya (“Kami”), memperoleh, mengumpulkan, menggunakan, menampilkan, mengumumkan, mengungkapkan, memproses, membukakan akses, menyimpan, mengirim, memberi, mengalihkan, mengolah, mengelola, memusnahkan dan melindungi informasi dan data pribadi (secara bersama-sama, “Pemanfaatan”) yang anda sebagai pengguna (“Anda”) Platform (sebagaimana didefinisikan di bawah) berikan sebagaimana diminta maupun pada saat menggunakan Platform (“Data Pribadi”). Perlu dicatat bahwa Data Pribadi di sini tidak termasuk Data Pribadi yang telah tersedia di domain publik.",
                    textAlign: TextAlign.justify,
                    style: AppTheme.subtitle.copyWith(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Kebijakan Privasi ini merupakan bagian dari Syarat dan Ketentuan JumpaDokter. Penggunaan Platform dan setiap fitur dan/atau layanan yang tersedia dalam Platform (“Layanan”) merupakan bentuk persetujuan anda terhadap Ketentuan Penggunaan dan Kebijakan Privasi tersebut.",
                    textAlign: TextAlign.justify,
                    style: AppTheme.subtitle.copyWith(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Oleh karena itu, Anda perlu untuk membaca Kebijakan Privasi ini dengan saksama untuk memastikan bahwa Anda memahaminya sepenuhnya sebelum mendaftar, mengakses dan/atau menggunakan Platform dan Layanan Kami.",
                    textAlign: TextAlign.justify,
                    style: AppTheme.subtitle.copyWith(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),

                  /// 1
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "1",
                    value: "Ruang Lingkup Kebijakan Privasi",
                  ),
                  const SizedBox(height: 10),
                  const TextSubHeadings(
                    keys: "a",
                    value:
                        "Secara khusus namun tidak terbatas terhadap layanan dikelola oleh Kami, PT Castellum Digital Indonesia yang terkoneksi dengan pihak ketiga.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "Kebijakan Privasi ini mengatur Pemanfaatan Data Pribadi penggunaan Aplikasi JumpaDokter.",
                  ),
                  const TextSubHeadings(
                    keys: "c",
                    value:
                        "Dengan menggunakan Platform Aplikasi JumpaDokter, maka Anda dianggap telah membaca Kebijakan Privasi ini dan menyetujui mekanisme Pemanfaatan Data Pribadi Anda sebagaimana diatur dalam Kebijakan Privasi ini.",
                  ),
                  const TextSubHeadings(
                    keys: "d",
                    value:
                        "Apabila Kami meminta Anda untuk memberikan informasi ketika menggunakan Platform Aplikasi JumpaDokter, maka informasi tersebut hanya akan digunakan untuk keperluan pemberian Layanan sesuai dengan Kebijakan Privasi ini.",
                  ),
                  const TextSubHeadings(
                    keys: "e",
                    value:
                        "Kami dapat mengubah, menghapus dan untuk menerapkan ketentuan baru dalam Kebijakan Privasi ini. Anda diharapkan untuk memeriksa halaman Kebijakan Privasi Platform Aplikasi JumpaDokter  secara berkala untuk mengetahui perubahan tersebut.",
                  ),
                  const TextSubHeadings(
                    keys: "f",
                    value:
                        "Dengan menggunakan Aplikasi Platform JumpaDokter setelah terjadinya perubahan tersebut, Anda dianggap telah mengetahui dan menyetujui perubahan-perubahan ketentuan pada Kebijakan Privasi ini.",
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  /// 2
                  const TextHeadings(
                    keys: "2",
                    value: "Registrasi",
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value:
                        "Anda diharuskan melakukan pendaftaran dalam Platform Aplikasi JumpaDokter untuk dapat menggunakan fitur – fitur didalamnya.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "Untuk melakukan pendaftaran dalam Platform, Anda harus memberikan informasi yang Kami perlukan sebagaimana tercantum pada Pasal 3 – Data Pribadi, di bawah ini.",
                  ),

                  /// 3
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "3",
                    value: "Data Pribadi",
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value:
                        "Anda mengetahui dan menyetujui bahwa Kami mengumpulkan informasi pribadi yang diberikan saat membuat akun, profil, maupun pada saat menggunakan fitur-fitur yang terdapat dalam Platform Aplikasi JumpaDokter.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "Informasi mengenai identitas diri yang wajib diisi oleh Anda saat membuat akun di Platform antara lain adalah:",
                  ),
                  const TextSubtitle(
                    keys: "i",
                    value:
                        "Nama lengkap sesuai kartu identitas yang berlaku (KTP atau Paspor); dan",
                  ),
                  const TextSubtitle(
                    keys: "ii",
                    value: "Nomor telepon genggam yang terhubung ke Whatsapp.",
                  ),
                  const TextSubHeadings(
                    keys: "c",
                    value:
                        "Anda dapat mengaktifkan atau menonaktifkan layanan pengenalan lokasi saat Anda menggunakan Platform Aplikasi JumpaDokter.",
                  ),
                  const TextSubHeadings(
                    keys: "d",
                    value:
                        "Apabila diperlukan, Kami dapat melakukan verifikasi langsung kepada Anda tentang data diri yang telah diisi pada Platform Aplikasi JumpaDokter.",
                  ),
                  const TextSubHeadings(
                    keys: "e",
                    value:
                        "Informasi yang Anda berikan adalah akurat dan benar.",
                  ),

                  /// 4
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "4",
                    value: "Layanan Rapid Diagnostic Test Antigen (RDT-Ag)",
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value:
                        "Informasi yang Anda berikan untuk Layanan Rapid Diagnostic Test Antigen (RDT-Ag) akan Kami gunakan untuk proses pendaftaran dan pemesanan tes.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "Anda dapat memesankan Layanan Rapid Diagnostic Test Antigen (RDT-Ag) untuk orang lain. Pemesanan untuk pasien lain (bukan diri sendiri) dianggap sudah memiliki izin dari orang/pasien yang bersangkutan dan PT. Castellum Digital Indonesia atau Pihak JumpaDokter tidak terikat dalam penyalahgunaan data pihak lain dalam kasus dan/atau kondisi tersebut.",
                  ),

                  /// 5
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "5",
                    value: "Data Pengunjung",
                  ),
                  const TextSubHeadingsWithoutKeys(
                    value:
                        "Anda mengetahui dan menyetujui bahwa Platform akan mengumpulkan informasi tentang penggunaan, seperti (namun tidak terbatas pada) jumlah kunjungan, sumber pengunjung dan aktivitas pengunjung. Data ini kami kumpulkan dan kami gunakan dengan tujuan meningkatkan kepuasan Anda serta layanan Kami.",
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value:
                        "Kami dan Penyedia Layanan dapat melakukan Pemanfaatan Data Pribadi Anda untuk kegiatan bisnis dan operasional sesuai dengan tujuan diberikannya Data Pribadi tersebut, termasuk untuk:",
                  ),
                  const TextSubtitle(
                    keys: "i",
                    value:
                        "Menyediakan informasi kepada Anda dan Penyedia Layanan sesuai permintaan Anda berkaitan dengan Layanan Kami.",
                  ),
                  const TextSubtitle(
                    keys: "ii",
                    value:
                        "Menyediakan pembuatan resep dan/atau obat-obatan sesuai permintaan Anda berkaitan dengan layanan Kami pada layanan Homecare.",
                  ),
                  const TextSubtitle(
                    keys: "iii",
                    value:
                        "Mengembangkan, meningkatkan dan menyediakan produk dan layanan yang sesuai dengan kebutuhan Anda.",
                  ),
                  const TextSubtitle(
                    keys: "iv",
                    value: "Menanggapi pertanyaan, komentar dan masukan Anda.",
                  ),
                  const TextSubtitle(
                    keys: "v",
                    value:
                        "Memberikan informasi/mengirimkan e-mail dan/atau SMS berisi promosi secara berkala kepada Anda bila terdapat suatu penawaran dan/atau promosi atas produk-produk baru, penawaran khusus, atau informasi lain yang menurut Kami diperlukan oleh Anda.",
                  ),
                  const TextSubtitle(
                    keys: "vi",
                    value:
                        "Menggunakan dan mengungkapkan informasi ini jika diperlukan bagi tinjauan medis, jasa hukum, dan audit, meliputi penipuan dan deteksi penyalahgunaan dan program penyesuaian, serta perencanaan dan manajemen bisnis.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "Kami menjamin bahwa data dan informasi yang diberikan Anda bersifat rahasia dan tidak akan disebarluaskan kecuali untuk hal-hal yang telah dicantumkan dan Anda setujui dalam Kebijakan Privasi ini. Untuk mencegah akses tidak sah, Kami melakukan tindakan pengamanan fisik, elektronik, dan prosedur manajerial untuk melindungi informasi Anda.",
                  ),
                  const TextSubHeadings(
                    keys: "c",
                    value:
                        "Informasi kesehatan Anda hanya akan digunakan sehubungan dengan pelayanan Platform dan hal-hal yang telah dicantumkan dan Anda setujui dalam Kebijakan Privasi ini dan Kami hanya akan mengumpulkan informasi yang dibutuhkan untuk menjalankan pelayanan dalam Platform.",
                  ),

                  /// 6
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "6",
                    value: "Koneksi Anda Ke Platform Lain",
                  ),
                  const TextSubHeadingsWithoutKeys(
                    value:
                        "Platform dapat memuat tautan menuju platform milik pihak ketiga (“Platform Pihak Ketiga”) dan konten pihak ketiga (“Konten Pihak Ketiga”). Untuk keamanan Anda, Anda perlu mempelajari dan membaca dengan hati-hati kebijakan penanganan informasi pribadi yang berlaku di Platform Pihak Ketiga dan/atau Konten Pihak Ketiga.",
                  ),

                  /// 7
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "7",
                    value: "Hukum Yang Berlaku",
                  ),
                  const TextSubHeadingsWithoutKeys(
                    value:
                        "Kebijakan Privasi ini diatur berdasarkan hukum Negara Republik Indonesia dan Anda diwajibkan tunduk kepada semua peraturan yang berlaku di Republik Indonesia.",
                  ),
                  // 8
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "8",
                    value: "Upaya Pengamanan",
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value:
                        "Kami akan berupaya memastikan bahwa informasi yang Anda berikan kepada Kami aman dan tidak dapat digunakan oleh pihak-pihak yang tidak bertanggung jawab. Untuk keamanan data Anda, Kami sangat menyarankan agar Anda selalu memperbarui Platform dan perangkat lunak anda serta tidak mengungkapkan kata sandi anda kepada pihak manapun.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "Anda dengan ini setuju bahwa Kami dapat menyimpan Data Pribadi pada server yang terletak di pusat data yang ditunjuk oleh Kami. Pemanfaatan Data Pribadi sehubungan dengan penggunaan Platform akan terus diatur oleh Kebijakan Privasi ini sesuai dengan peraturan perundangan-undangan yang berlaku di Republik Indonesia.",
                  ),

                  ///9
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "9",
                    value: "Hubungi Kami",
                  ),
                  const TextSubHeadingsWithoutKeys(
                    value:
                        "Hukum privasi Indonesia memberikan individu hak untuk mengakses, mengubah, dan menghapus informasi pribadi mereka. Jika Anda   ingin mengubah atau menghapus informasi yang kami simpan mengenai Anda, silakan hubungi kami di bawah ini.",
                  ),
                  const TextSubHeadingsWithoutKeys(
                    value:
                        "Kami akan menginformasikan kepada Anda secara tertulis apabila terdapat kegagalan untuk melindungi kerahasiaan informasi pribadi Anda dalam sistem elektronik kami, sesuai yang diwajibkan oleh hukum yang berlaku.",
                  ),
                  const TextSubHeadingsWithoutKeys(
                      value:
                          "Jika Anda memiliki pertanyaan apapun mengenai Kebijakan Privasi ini, silakan kirimkan email kepada kami di  infodokter@jumpadokter.com atau call center Kami di  +62811-6562-201."),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextHeadings extends StatelessWidget {
  const TextHeadings({
    Key? key,
    required this.keys,
    required this.value,
  }) : super(key: key);

  final String? keys;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$keys. $value",
      style: AppTheme.subtitle.copyWith(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
    );
  }
}

class TextSubHeadings extends StatelessWidget {
  const TextSubHeadings({
    Key? key,
    required this.keys,
    required this.value,
  }) : super(key: key);

  final String? keys;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 10,
      leading: Text(
        "$keys",
        style: AppTheme.subtitle.copyWith(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
      title: Text(
        "$value",
        style: AppTheme.subtitle.copyWith(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
    );
  }
}

class TextSubHeadingsWithoutKeys extends StatelessWidget {
  const TextSubHeadingsWithoutKeys({
    Key? key,
    required this.value,
  }) : super(key: key);

  final String? value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "$value",
        style: AppTheme.subtitle.copyWith(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
    );
  }
}

class TextSubtitle extends StatelessWidget {
  const TextSubtitle({
    Key? key,
    required this.keys,
    required this.value,
  }) : super(key: key);

  final String? keys;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingOnly(left: 30),
      child: ListTile(
        minLeadingWidth: 10,
        leading: Text(
          "$keys",
          style: AppTheme.subtitle.copyWith(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
        title: Text(
          "$value",
          style: AppTheme.subtitle.copyWith(
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
