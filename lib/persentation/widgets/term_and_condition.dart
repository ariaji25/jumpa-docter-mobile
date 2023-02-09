import 'package:flutter/material.dart';
import 'package:jd_mobile/common/resources/colors.dart';
import 'package:jd_mobile/common/theme/theme.dart';

import '../../common/extensions/padding_ext.dart';
import '../pages/global/components/sub_title.dart';
import '../pages/global/components/text_heading.dart';
import '../pages/global/components/text_sub_heading.dart';

bottomSheetTermAndConditionWidget(BuildContext context) {
  return showModalBottomSheet(
    enableDrag: true,
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return const TermConditionWidget();
    },
  );
}

class TermConditionWidget extends StatelessWidget {
  const TermConditionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
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
              "SYARAT DAN KETENTUAN\nJUMPADOKTER",
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
                    "Selamat datang di JumpaDokter,",
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
                    "Dengan mengunduh, memasang, dan/atau menggunakan Platform JumpaDokter (sesuai yang didefinisikan di bawah ini), Anda menyetujui bahwa Anda telah membaca, memahami, dan menyetujui Syarat dan Ketentuan (“Syarat dan Ketentuan”) ini.",
                    textAlign: TextAlign.justify,
                    style: AppTheme.subtitle.copyWith(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Syarat dan Ketentuan ini menandakan perjanjian hukum antara Anda dan JumpaDokter dan berlaku untuk kunjungan Anda ke dan penggunaan Anda atas Platform dan Layanan kami (sesuai yang didefinisikan di bawah ini). Namun, harap diperhatikan bahwa syarat, batasan, dan kebijakan privasi tambahan dapat berlaku.",
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
                    "Jika Anda tidak menyetujui Syarat dan Ketentuan ini, jangan mengakses dan/atau menggunakan Platform dan/atau Layanan ini.",
                    textAlign: TextAlign.justify,
                    style: AppTheme.subtitle.copyWith(
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                  // 1
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "1",
                    value: "KETENTUAN UMUM",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value:
                        "Semua referensi di bawah Syarat dan Ketentuan ini untuk “JumpaDokter” atau “kami” merujuk ke PT [**] dan badan-badan yang terkait (“JumpaDokter”), dan semua referensi untuk “Pelanggan” atau “Anda” merujuk ke pengguna Platform dan/atau Layanan yang berwenang.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "“latform” berarti (a) versi web dan seluler dari situs web yang dioperasikan dan/atau dimiliki oleh JumpaDokter; dan (b) aplikasi seluler yang disediakan oleh JumpaDokter dari waktu ke waktu, termasuk versi Android dan iOS.",
                  ),
                  const TextSubHeadings(
                    keys: "c",
                    value:
                        "Jenis-jenis Layanan yang dapat diakses melalui Platform adalah sebagai berikut:",
                  ),
                  const TextSubtitle(
                    keys: "i",
                    value: "Homecare, yang meliputi namun tidak terbatas pada:",
                  ),
                  const TextChildSubtitle(
                    keys: "a",
                    value: "Layanan Perawatan Pasca Operasi;",
                  ),
                  const TextChildSubtitle(
                    keys: "b",
                    value: "Layanan Perawatan Luka;",
                  ),
                  const TextChildSubtitle(
                    keys: "c",
                    value: "Layanan Perawatan untuk Lansia;",
                  ),
                  const TextChildSubtitle(
                    keys: "d",
                    value: "Layanan Perawatan untuk Pendamping;",
                  ),
                  const TextChildSubtitle(
                    keys: "e",
                    value: "Layanan Perawatan Baby Care;",
                  ),
                  const TextChildSubtitle(
                    keys: "f",
                    value: "Layanan SWAB Ag dan/atau PCR; dan",
                  ),
                  const TextChildSubtitle(
                    keys: "g",
                    value: "Layanan umum (dasar/rawat jalan);",
                  ),
                  const TextSubtitle(
                    keys: "ii",
                    value: "Artikel Kesehatan; dan",
                  ),
                  const TextSubtitle(
                    keys: "iii",
                    value:
                        "layanan lain apa pun yang dapat kami tambahkan dari waktu ke waktu, (masing-masing disebut “Layanan” dan secara kolektif disebut “Layanan-Layanan”).",
                  ),
                  const TextSubHeadings(
                    keys: "d",
                    value:
                        "Platform berperan sebagai platform perantara yang menghubungkan Anda dengan penyedia layanan kesehatan, yaitu dokter, tenaga kesehatan lain serta laboratorium klinik (“Penyedia Layanan”).",
                  ),
                  const TextSubHeadings(
                      keys: "e",
                      value:
                          "Platform memperbolehkan Anda untuk mengirimkan permintaan Layanan kepada Penyedia Layanan. Penyedia Layanan, sesuai kebijaksanaan tunggal mereka, dapat menerima atau menolak permintaan Anda atas Layanan yang diminta."),
                  const TextSubHeadings(
                    keys: "f",
                    value:
                        "Platform dan Layanan bukan merupakan praktik pengobatan atau praktik layanan medis, perawatan, atau layanan kesehatan profesional lainnya. Anda sebaiknya meminta saran dokter atau penyedia layanan kesehatan lainnya yang berkualifikasi mengenai pertanyaan apa pun terkait kondisi kesehatan atau medis Anda. Jika Anda memiliki atau menduga bahwa Anda memiliki masalah kesehatan atau kondisi medis tertentu, segera hubungi ahli kesehatan yang berkualifikasi.",
                  ),
                  const TextSubHeadings(
                    keys: "g",
                    value:
                        "Kami adalah perusahaan teknologi, bukan penyedia layanan kesehatan, dan kami tidak menyediakan layanan kesehatan. Kami tidak mempekerjakan Penyedia Layanan, dan kami tidak bertanggung jawab atas tindakan, kecerobohan, kelalaian, dan/atau kelengahan Penyedia Layanan. Platform merupakan layanan informasi dan komunikasi online yang disediakan oleh JumpaDokter.",
                  ),
                  // 2
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "2",
                    value: "AKSES KE PLATFORM DAN LAYANAN",
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value: "Anda setuju untuk:",
                  ),
                  const TextSubtitle(
                    keys: "i",
                    value:
                        "mengakses Platform dan/atau menggunakan Layanan hanya untuk tujuan yang sah dan dengan cara yang sah, setiap saat, dan juga setuju untuk melakukan aktivitas apa pun terkait Layanan atau Platform dengan itikad baik;",
                  ),
                  const TextSubtitle(
                    keys: "ii",
                    value:
                        "mematuhi semua dan panduan, pemberitahuan, peraturan operasional, kebijakan, dan instruksi apa pun terkait penggunaan Layanan dan/atau akses ke Platform, sekaligus amendemen apa pun yang diterbitkan oleh kami dari waktu ke waktu; dan",
                  ),
                  const TextSubtitle(
                    keys: "iii",
                    value:
                        "menjamin agar informasi atau data apa pun yang Anda publikasikan atau tampilkan di Platform terkait Layanan bersifat akurat.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "Akses ke area-area Platform yang terlindungi oleh kata sandi dan penggunaan Layanan terbatas hanya untuk Pelanggan dengan akun JumpaDokter. Anda tidak dapat memperoleh atau berusaha memperoleh akses yang tidak sah ke bagian-bagian Platform dan/atau Layanan ini maupun ke informasi lain yang terlindungi di Platform, melalui cara apa pun yang secara sengaja tidak kami sediakan untuk penggunaan khusus Anda.",
                  ),
                  const TextSubHeadings(
                    keys: "c",
                    value:
                        "Dengan mengakses Platform dan/atau menggunakan Layanan, Anda menyatakan dan menjamin bahwa Anda adalah individu yang secara hukum berhak untuk memasuki perjanjian yang mengikat di bawah hukum Republik Indonesia, dalam Syarat dan Ketentuan berikut ini, dan bahwa Anda berusia minimal 21 tahun atau sudah menikah dan tidak sedang di bawah perwalian. \n\nJika Anda berusia di bawah 21 tahun dan tidak menikah, Anda menyatakan dan menjamin bahwa Anda telah memperoleh izin dari orang tua atau wali hukum Anda, kecuali Anda menyatakan sebaliknya. Dengan memberikan persetujuan, orang tua atau wali hukum Anda setuju untuk bertanggung jawab atas:",
                  ),
                  const TextSubtitle(
                    keys: "i",
                    value:
                        "semua tindakan Anda terkait akses ke dan penggunaan Platform dan/atau Layanan;",
                  ),
                  const TextSubtitle(
                    keys: "ii",
                    value:
                        "(biaya apa pun terkait penggunaan Anda atas Layanan apa pun; dan",
                  ),
                  const TextSubtitle(
                    keys: "iii",
                    value: "kepatuhan Anda terhadap Syarat dan Ketentuan ini.",
                  ),
                  const TextSubHeadings(
                    keys: "",
                    value:
                        "Jika Anda tidak memperoleh izin dari orang tua atau wali hukum, Anda harus berhenti mengakses Platform dan/atau menggunakan Layanan.",
                  ),
                  const TextSubHeadings(
                    keys: "d",
                    value:
                        "Anda menyatakan akan menggunakan Platform ini hanya untuk tujuan yang dimaksudkan, yaitu untuk memperoleh Layanan.",
                  ),
                  const TextSubHeadings(
                    keys: "e",
                    value:
                        "Anda akan merahasiakan dan tidak akan menyalahgunakan informasi yang Anda terima dari penggunaan Platform. Anda akan memperlakukan Penyedia Layanan dengan hormat dan tidak akan melakukan perilaku atau aktivitas tidak sah, mengancam, atau melecehkan saat menggunakan Layanan.",
                  ),
                  const TextSubHeadings(
                    keys: "f",
                    value:
                        "Anda memahami dan setuju bahwa penggunaan Anda atas Platform juga harus mematuhi Kebijakan Privasi kami, seperti yang mungkin diamendemen dari waktu ke waktu.",
                  ),
                  const TextSubHeadings(
                    keys: "g",
                    value:
                        "Dengan memberikan informasi kepada kami, Anda menyatakan bahwa Anda berhak untuk memberikan informasi kepada kami untuk digunakan dan dibagikan dengan Penyedia Layanan dan bahwa informasi tersebut akurat, terkini, dan lengkap.",
                  ),
                  const TextSubHeadings(
                    keys: "h",
                    value:
                        "Terkait penggunaan Anda atas Platform atau Layanan, atau selama interaksi Anda dengan JumpaDokter, Pelanggan lain, Penyedia Layanan, atau pihak ketiga lain apa pun melalui Platform, Anda dilarang:",
                  ),
                  const TextSubtitle(
                    keys: "i",
                    value:
                        "melanggar Syarat dan Ketentuan, Kebijakan Privasi, atau kebijakan lain apa pun yang ada di Platform ini;",
                  ),
                  const TextSubtitle(
                    keys: "ii",
                    value:
                        "melanggar hukum, peraturan, atau hak pihak ketiga mana pun;",
                  ),
                  const TextSubtitle(
                    keys: "iii",
                    value:
                        "melanggar hak cipta, paten, merek dagang, rahasia dagang, hak kekayaan intelektual apa pun, hak publisitas atau privasi dari JumpaDokter atau pihak ketiga mana pun;",
                  ),
                  const TextSubtitle(
                    keys: "iv",
                    value:
                        "melakukan tindakan yang mencemarkan, memfitnah, mengancam, atau melecehkan;",
                  ),
                  const TextSubtitle(
                    keys: "v",
                    value:
                        "memberikan informasi yang salah, palsu, tidak akurat, atau menyesatkan;",
                  ),
                  const TextSubtitle(
                    keys: "vi",
                    value:
                        "menolak secara tidak wajar untuk bekerja sama dalam penyelidikan yang dilakukan oleh JumpaDokter atau memberikan konfirmasi mengenai identitas Anda atau informasi lain yang diminta oleh JumpaDokter;",
                  ),
                  const TextSubtitle(
                    keys: "vii",
                    value: "menggunakan proxy yang menganonimkan;",
                  ),
                  const TextSubtitle(
                    keys: "viii",
                    value:
                        "mengontrol akun pelanggan yang terhubung dengan cara apa pun ke akun lain yang telah atau diduga melakukan aktivitas apa pun yang dilarang di bawah Syarat dan Ketentuan ini;",
                  ),

                  const TextSubtitle(
                    keys: "ix",
                    value:
                        "menggunakan Platform sebagai sarana untuk menyebarkan iklan dan materi lain apa pun yang tidak diinginkan kepada pihak ketiga, mengirimkan surat berantai atau skema piramida, atau memublikasikan konten yang sama lebih dari sekali (spam);",
                  ),
                  const TextSubtitle(
                    keys: "x",
                    value:
                        "menggunakan Platform, akun Anda, atau Layanan dengan cara yang mengakibatkan atau dapat mengakibatkan keluhan, perselisihan, tuntutan, denda, penalti, dan tanggung jawab lain kepada JumpaDokter, Pelanggan lain, Penyedia Layanan, atau pihak ketiga;",
                  ),
                  const TextSubtitle(
                    keys: "xi",
                    value:
                        "mengambil tindakan apa pun yang memaksakan beban berat yang tidak wajar atau tidak proporsional ke infrastruktur kami atau tindakan lain yang dapat mengakibatkan risiko atau masalah material untuk infrastruktur kami;",
                  ),

                  const TextSubtitle(
                    keys: "xii",
                    value:
                        "menyebarkan virus, trojan horse, worm, atau teknologi pemrograman komputer lain yang dapat membahayakan Platform, kepentingan, atau properti apa pun dari Pelanggan lain, Penyedia Layanan, dan pihak ketiga mana pun, termasuk pengguna lain di Platform dan Layanan;",
                  ),
                  const TextSubtitle(
                    keys: "xiii",
                    value:
                        "berusaha memperoleh akses yang tidak sah ke atau mengganggu atau menghalangi sistem atau jaringan komputer lain yang terhubung ke Platform atau Layanan;",
                  ),
                  const TextSubtitle(
                    keys: "xiv",
                    value:
                        "menyebarkan atau mempromosikan materi tidak senonoh, pornografi, atau menyinggung atau materi lain yang bertentangan dengan kebijakan publik dan/atau hukum atau peraturan apapun yang berlaku;",
                  ),

                  const TextSubtitle(
                    keys: "xv",
                    value:
                        "akibat tindakan atau kelalaian Anda, melakukan apa pun yang dapat menyebabkan kami kehilangan layanan apa pun dari penyedia layanan internet, pemroses pembayaran, atau penyedia kami lainnya.",
                  ),
                  const TextSubtitle(
                    keys: "xvi",
                    value:
                        "mengganggu penggunaan dan kenyamanan pengguna lain atas Platform atau Layanan; atau",
                  ),
                  const TextSubtitle(
                    keys: "xvii",
                    value:
                        "memfasilitasi aktivitas ilegal, tidak sah, atau penipuan berbentuk apa pun.",
                  ),
                  const TextSubHeadings(
                    keys: "i",
                    value:
                        "Jika kami memiliki alasan untuk menduga bahwa Anda terlibat dalam aktivitas apa pun yang dilarang, sesuai yang ditetapkan dalam Pasal 2 huruf (h) di atas, kami dapat, tanpa tanggung jawab kepada Anda, mengambil tindakan berikut:",
                  ),
                  const TextSubtitle(
                    keys: "i",
                    value:
                        "melaporkan aktivitas mencurigakan atau ilegal apa pun ke otoritas yang relevan;",
                  ),
                  const TextSubtitle(
                    keys: "ii",
                    value: "membatalkan atau menolak transaksi apa pun;",
                  ),
                  const TextSubtitle(
                    keys: "iii",
                    value: "menangguhkan atau menutup akun Pelanggan Anda;",
                  ),
                  const TextSubtitle(
                    keys: "iv",
                    value:
                        "menerapkan, sesuai kebijaksanaan tunggal kami, prosedur pencegahan dan deteksi serta menolak pelaksanaan transaksi apabila ada dasar untuk menduga bahwa akun Pelanggan digunakan atau mungkin digunakan untuk tujuan yang ilegal, tidak sah, atau penipuan; atau",
                  ),
                  const TextSubtitle(
                    keys: "v",
                    value:
                        "mengambil langkah lebih lanjut sesuai yang dianggap perlu oleh JumpaDokter, sesuai kebijaksanaan tunggal kami, termasuk mengambil langkah hukum terhadap Anda.",
                  ),
                  const TextSubHeadings(
                    keys: "j",
                    value:
                        "Apabila terjadi penangguhan akun Pelanggan Anda, kami akan menginformasikan penangguhan kepada Anda, ketika memungkinkan, dan memberikan Anda kesempatan untuk meminta pemulihan akses jika dan saat sesuai. Pemulihan akses apa pun merupakan kebijaksanaan JumpaDokter dan harus mematuhi kebijakan dan prosedur JumpaDokter sekaligus hukum yang berlaku.",
                  ),
                  const TextSubHeadings(
                    keys: "k",
                    value:
                        "Apabila terjadi penangguhan akun Pelanggan Anda, kami akan menginformasikan penangguhan kepada Anda, ketika memungkinkan, dan memberikan Anda kesempatan untuk meminta pemulihan akses jika dan saat sesuai. Pemulihan akses apa pun merupakan kebijaksanaan JumpaDokter dan harus mematuhi kebijakan dan prosedur JumpaDokter sekaligus hukum yang berlaku.",
                  ),
                  // 3
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "3",
                    value: "PENGGUNAAN UMUM LAYANAN",
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value: "Homecare",
                  ),
                  const TextSubtitle(
                    keys: "i",
                    value:
                        "“Homecare” adalah Layanan yang disediakan oleh dokter atau Penyedia Layanan lainnya di Platform untuk membuat Janjian Kunjungan antara Pelanggan dengan Penyedia Layanan melalui Platform.",
                  ),
                  const TextSubtitle(
                    keys: "ii",
                    value:
                        "Dengan menggunakan Layanan ini, Anda menyetujui bahwa:",
                  ),
                  const TextChildSubtitle(
                    keys: "a",
                    value:
                        "Layanan ini tidak akan digunakan dalam kondisi darurat, termasuk tetapi tidak terbatas pada kondisi medis apa pun yang membutuhkan penanganan cepat atau pemeriksaan fisik oleh dokter;",
                  ),
                  const TextChildSubtitle(
                    keys: "b",
                    value:
                        "Layanan ini tidak akan digunakan untuk memperoleh dispensasi pengobatan dari dokter dalam bentuk apa pun;",
                  ),
                  const TextChildSubtitle(
                    keys: "c",
                    value:
                        "Tanggung jawab JumpaDokter hanyalah menyediakan teknologi yang memfasilitasi komunikasi dan pembuatan Janji Kunjungan antara Anda dan Penyedia Layanan.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value: "Artikel Kesehatan",
                  ),
                  const TextSubHeadings(
                    keys: "",
                    value:
                        "Konten artikel-artikel kesehatan yang ditawarkan oleh JumpaDokter di Platform hanya bersifat umum dan digunakan untuk mengedukasi konsumen layanan kesehatan dan medis. Bagian mana pun dalam konten sebaiknya tidak dianggap atau digunakan sebagai pengganti untuk saran, diagnosis, atau perawatan medis.",
                  ),
                  const TextSubHeadings(
                    keys: "c",
                    value: "Pendaftaran dan Informasi Akun",
                  ),
                  const TextSubtitle(
                    keys: "i",
                    value:
                        "Proses pendaftaran mewajibkan Anda untuk memberikan informasi pribadi yang akurat, terkini, dan lengkap, yang mungkin kami minta dari Anda dari waktu ke waktu, termasuk tetapi tidak terbatas pada nama, alamat, nomor telepon, tanggal lahir, dan alamat email kepada kami. Apabila terdapat perubahan apa pun dalam informasi Anda, harap memberi tahu JumpaDokter secepat mungkin.",
                  ),
                  const TextSubtitle(
                    keys: "ii",
                    value:
                        "Kami dapat meminta informasi atau dokumentasi tambahan kapan pun untuk memverifikasi identitas, umur, dan/atau memverifikasi detail bank atau debit, kredit, fasilitas prabayar Anda, seperti kartu yang didaftarkan kepada kami. Anda menyetujui bahwa Anda akan memberikan informasi dan/atau dokumentasi dengan cepat kepada kami sesuai permintaan. Jika Anda tidak memberikan informasi dan/atau dokumentasi dengan cepat, kami dapat, tanpa tanggung jawab kepada Anda, membatasi penggunaan Anda atas Layanan atau menangguhkan atau menutup akun Anda.",
                  ),
                  const TextSubtitle(
                    keys: "iii",
                    value:
                        "Hanya Anda yang dapat menggunakan akun Anda sendiri, dan Anda berusaha untuk tidak memberikan wewenang kepada pihak lain untuk menggunakan identitas atau akun Anda. Anda tidak boleh mengalihkan atau memindahkan akun Anda ke pihak lain. Anda harus menjaga agar kata sandi akun dan identifikasi apa pun yang kami berikan kepada Anda tetap aman dan rahasia.\n\nApabila kata sandi Anda diungkapkan ke pihak ketiga mana pun dan pengungkapan tersebut mengakibatkan penggunaan akun atau identitas secara ilegal, perintah yang diberikan dari penggunaan secara ilegal atau tidak sah tersebut akan tetap dianggap sebagai perintah yang valid, kecuali Anda dapat menunjukkan bahwa pengungkapan tersebut tidak disebabkan oleh tindakan, kecerobohan, kelalaian, dan/atau kelengahan Anda.",
                  ),
                  const TextSubtitle(
                    keys: "iv",
                    value:
                        "Semua data pribadi yang diberikan kepada JumpaDokter akan dikumpulkan, ditangani, disimpan, dan diproses sesuai dengan Kebijakan Privasi JumpaDokter. Dengan menerima Syarat dan Ketentuan ini, Anda juga setuju untuk memberikan izin sesuai yang dibutuhkan di bawah Kebijakan Privasi kami.",
                  ),
                  const TextSubtitle(
                    keys: "v",
                    value:
                        "Anda bertanggung jawab sepenuhnya untuk menjaga agar nama pengguna dan kata sandi Anda di Platform dan Layanan tetap aman. Anda dianjurkan untuk mengubah kata sandi secara rutin, dan kami tidak akan bertanggung jawab atas pengungkapan atau penggunaan tidak sah apa pun dari nama pengguna atau kata sandi Anda, yang disebabkan oleh tindakan, kecerobohan, kelalaian, dan/atau kelengahan Anda. Jika nama pengguna dan kata sandi Anda telah diretas, Anda harus segera menginformasikan kepada JumpaDokter secara tertulis.",
                  ),
                  const TextSubtitle(
                    keys: "vi",
                    value:
                        "Penggunaan nama pengguna atau kata sandi apa pun di Platform akan dianggap sebagai penggunaan Layanan. Informasi, data, atau komunikasi apa pun yang dipublikasikan, dikirimkan,  atau diterbitkan selama periode Anda masuk dengan nama pengguna dan kata sandi (baik secara sah maupun tidak sah) akan dianggap dipublikasikan, dikirimkan, atau diterbitkan oleh  Anda.\n\nAnda akan bertanggung jawab sepenuhnya atas pengiriman, pemberitahuan, atau komunikasi apa pun dan setuju untuk mengganti rugi dan membebaskan JumpaDokter dari kerugian, kerusakan, pengeluaran, dan/atau tanggung jawab atas tindakan yang disebabkan oleh penggunaan nama pengguna dan kata sandi Anda di Platform, kecuali Anda dapat menunjukkan bahwa penggunaan tersebut tidak disebabkan oleh tindakan, kecerobohan, kelalaian, dan/atau kelengahan Anda.",
                  ),
                  const TextSubHeadings(
                    keys: "d",
                    value: "pembayaran",
                  ),
                  const TextSubtitle(
                    keys: "i",
                    value:
                        "Pengunduhan dan/atau penggunaan Platform bersifat bebas biaya. Kami dapat membebankan biaya untuk akses ke fitur-fitur tertentu yang ditawarkan melalui Platform. Namun, koneksi internet dibutuhkan untuk mengakses Platform dan/atau menggunakan Layanan, dan biaya terkait apa pun (seperti pengeluaran kuota) yang disebabkan oleh akses Anda ke Platform dan/atau penggunaan Layanan merupakan tanggung jawab eksklusif Anda dan ditanggung sepenuhnya oleh Anda.",
                  ),
                  const TextSubtitle(
                    keys: "ii",
                    value:
                        "Pembayaran terhadap akses pada fitur-fitur berbayar mungkin akan tersedia di Platform dari waktu ke waktu, sekaligus pajak dan biaya transaksi terkait apa pun yang mungkin, dapat dibebankan melalui rencana langganan berbayar yang akan Anda ambil atau pembayaran satu waktu kepada:",
                  ),
                  const TextChildSubtitle(
                    keys: "a",
                    value: "JumpaDokter",
                  ),
                  const TextChildSubtitle(
                    keys: "b",
                    value: "Penyedia Layanan yang relevan; atau",
                  ),
                  const TextChildSubtitle(
                    keys: "c",
                    value:
                        "penyedia pembayaran pihak ketiga (sebagaimana berlaku).",
                  ),
                  const TextSubtitle(
                    keys: "",
                    value:
                        "Biaya yang berlaku untuk fitur-fitur berbayar apa pun dapat dilihat di Platform, dan biaya-biaya tersebut dapat diperbarui dari waktu ke waktu. Kami akan membantu Penyedia Layanan menghitung biaya yang berlaku berdasarkan penggunaan Layanan yang relevan dan menginformasikan besar biayanya kepada Anda atas nama Penyedia Layanan. Anda setuju untuk membayar secara penuh Layanan yang diberikan kepada Anda oleh Penyedia Layanan.",
                  ),
                  const TextSubtitle(
                    keys: "iii",
                    value:
                        "JumpaDokter dan penyedia pembayaran pihak ketiga kami akan memiliki akses ke preferensi metode pembayaran dan detail alamat penagihan Anda saat Anda melakukan pembayaran.\n\nKami tidak bertanggung jawab atas pelanggaran privasi atau keamanan apa pun yang timbul akibat atau terkait proses pembayaran apa pun oleh penyedia pihak ketiga. JumpaDokter dapat  menyimpan detail kartu kredit atau metode pembayaran online lainnya yang mungkin Anda gunakan.",
                  ),
                  const TextSubHeadings(
                    keys: "e",
                    value: "Ketersediaan Layanan",
                  ),
                  const TextSubHeadings(
                    keys: "",
                    value:
                        "JumpaDokter dapat, dari waktu ke waktu, dan tanpa memberikan alasan atau pemberitahuan apa pun sebelumnya kepada Anda, meningkatkan, mengubah, menangguhkan, atau menghentikan ketentuan dari, atau menghapus, baik sebagian maupun keseluruhan, Platform atau Layanan apa pun dan tidak bertanggung jawab apabila peningkatan, perubahan, penangguhan, atau penghapusan apa pun mencegah Anda mengakses Platform atau bagian Layanan mana pun.",
                  ),
                  // 4
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "4",
                    value: "TAUTAN KE SITUS WEB PIHAK KETIGA",
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value:
                        "Platform memiliki tautan-tautan ke situs-situs lain yang dioperasikan oleh pihak ketiga, termasuk tetapi tidak terbatas pada, situs-situs pihak ketiga yang mungkin menampilkan merek dagang JumpaDokter. Tautan-tautan ini tersedia untuk kemudahan Anda dan hanya digunakan untuk memberikan akses ke situs-situs pihak ketiga ini dan tidak untuk tujuan lain.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "JumpaDokter tidak menjamin atau memberikan pernyataan apa pun tentang isi, kualitas, fungsi, keakuratan, keselarasan untuk tujuan khusus, kelayakan barang dagangan, atau pernyataan lain apa pun tentang situs pihak ketiga mana pun dan kontennya. Tautan ke situs pihak ketiga di Platform tidak menandakan sponsor, dukungan (endorsement), persetujuan, atau tanggung jawab untuk situs pihak ketiga mana pun.\n\nJumpaDokter tidak memberikan pernyataan atau jaminan apa pun untuk produk atau layanan apa pun yang ditawarkan di situs pihak ketiga mana pun. Ketentuan penggunaan dan kebijakan privasi dari situs pihak ketiga dapat berbeda jauh dari ketentuan penggunaan dan pemberitahuan hukum yang berlaku untuk penggunaan Anda atas Platform atau Layanan.\n\nSilakan meninjau ketentuan penggunaan dari semua situs pihak ketiga yang relevan untuk informasi selengkapnya mengenai syarat dan ketentuan yang berlaku untuk penggunaan Anda atas situs-situs tersebut.",
                  ),
                  // 5
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "5",
                    value: "TANPA JAMINAN",
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value:
                        "Kami tidak memberikan pernyataan, jaminan, atau garansi atas keandalan, ketepatan waktu, kualitas, kesesuaian, ketersediaan, keakuratan, atau kelengkapan Layanan dan/atau Platform, termasuk tetapi tidak terbatas untuk, Layanan yang diperoleh oleh atau dari Penyedia Layanan melalui penggunaan Platform.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "Sejauh yang diizinkan oleh hukum yang berlaku, kami tidak memberikan pernyataan atau menjamin bahwa:",
                  ),
                  const TextSubtitle(
                    keys: "i",
                    value:
                        "penggunaan Layanan dan/atau Platform akan aman, tepat waktu, tidak terganggu, atau bebas dari kesalahan, atau beroperasi dengan baik dengan perangkat keras, perangkat lunak, sistem, atau data apa pun;",
                  ),
                  const TextSubtitle(
                    keys: "ii",
                    value:
                        "Layanan akan memenuhi persyaratan atau harapan Anda;",
                  ),
                  const TextSubtitle(
                    keys: "iii",
                    value:
                        "data apa pun yang disimpan bersifat akurat atau andal;",
                  ),
                  const TextSubtitle(
                    keys: "iv",
                    value:
                        "kualitas produk, layanan, informasi, atau materi lain apa pun yang Anda beli atau peroleh melalui Platform akan memenuhi persyaratan atau harapan Anda;",
                  ),
                  const TextSubtitle(
                    keys: "v",
                    value:
                        "kesalahan atau kecacatan di Platform akan diperbaiki; atau",
                  ),
                  const TextSubtitle(
                    keys: "vi",
                    value:
                        "aplikasi atau server yang menyusun Platform bebas dari virus atau komponen berbahaya lainnya.",
                  ),
                  const TextSubHeadings(
                    keys: "c",
                    value:
                        "Layanan-layanan diberikan kepada Anda sebagaimana adanya. Sejauh yang diizinkan oleh hukum yang berlaku, semua ketentuan, pernyataan, dan jaminan, baik tersirat maupun tersurat, sah atau tidak, termasuk tetapi tidak terbatas pada, jaminan produk dagang yang tersirat, keselarasan untuk tujuan khusus, atau ketiadaan pelanggaran atas hak pihak ketiga, dengan ini dikecualikan dan disangkal hingga batas tertinggi dan maksimal. Anda menyatakan dan menyetujui bahwa seluruh risiko yang timbul akibat penggunaan Anda atas Platform dan Layanan tetap dan mutlak merupakan tanggung jawab Anda, dan Anda tidak akan meminta jaminan apa pun kepada JumpaDokter.",
                  ),
                  // 6
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "6",
                    value: "PENGECUALIAN TANGGUNG JAWAB",
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value:
                        "Kami tidak bertanggung jawab atas cedera, kematian, kerusakan, atau kerugian apa pun yang dialami oleh Anda akibat praktik Penyedia Layanan atau pihak ketiga lain apa pun. Kami juga tidak bertanggung jawab atas pelanggaran atau tindakan kriminal apa pun yang dilakukan oleh Penyedia Layanan mana pun selama melaksanakan Layanan. Penyedia Layanan hanyalah mitra kerja kami, bukan karyawan, agen, atau perwakilan kami.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "Kami mengambil langkah-langkah teknis dan keamanan yang sesuai dan wajar untuk menjaga agar Platform tetap aman dan bebas dari virus dan kesalahan. Namun, meskipun teknologi ini efektif, tidak ada sistem keamanan yang tidak dapat ditembus. Dengan demikian, kami tidak dapat menjamin keamanan basis data kami maupun menjamin bahwa informasi yang Anda berikan tidak akan dihadang saat dikirimkan kepada kami. Kami akan menginformasikan kepada Anda secara tertulis apabila terdapat pelanggaran keamanan data yang melibatkan informasi pribadi Anda.",
                  ),
                  const TextSubHeadings(
                    keys: "c",
                    value:
                        "Platform dapat mengalami pembatasan, penundaan, dan masalah lain terkait penggunaan internet dan komunikasi elektronik, termasuk kecacatan perangkat yang digunakan oleh Anda atau Penyedia Layanan, tidak terhubung, di luar jangkauan, tidak aktif, atau tidak berfungsi. Kami tidak bertanggung jawab atas penundaan, kegagalan pengiriman, kerusakan, atau kerugian apa pun akibat masalah-masalah tersebut.",
                  ),
                  const TextSubHeadings(
                    keys: "d",
                    value:
                        "JumpaDokter dan/atau pemberi lisensi, afiliasi, dan masing-masing anggota, pejabat, direktur, komisaris, karyawan, pengacara, dan agennya (“Penerima Ganti Rugi”) tidak akan bertanggung jawab kepada Anda atas kerugian, biaya, pengeluaran (termasuk biaya dan pengeluaran hukum), kerusakan, penalti, atau jumlah pembayaran apa pun atau bagaimana pun yang disebabkan (apa pun bentuk tindakannya), secara langsung atau tidak langsung, terkait:",
                  ),
                  const TextSubtitle(
                    keys: "i",
                    value:
                        "akses, penggunaan, dan/atau ketidakmampuan apa pun untuk menggunakan Platform atau Layanan;",
                  ),
                  const TextSubtitle(
                    keys: "ii",
                    value:
                        "ketergantungan terhadap data atau informasi apa pun yang tersedia melalui Platform dan/atau Layanan;",
                  ),
                  const TextSubtitle(
                    keys: "iii",
                    value:
                        "kegagalan, kesalahan, kelalaian, gangguan, penundaan sistem, server, atau koneksi apa pun dalam pengiriman, virus komputer atau kode, program agen atau macros yang berbahaya, menghancurkan, atau merusak lainnya; dan",
                  ),
                  const TextSubtitle(
                    keys: "iv",
                    value:
                        "penggunaan apa pun atas atau akses ke situs web atau halaman web lain apa pun yang tertaut ke Platform; bahkan jika kami, pejabat, agen, atau karyawan kami mungkin sudah disarankan atau mengantisipasi kemungkinan yang sama.",
                  ),
                  // 7
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "7",
                    value: "GANTI RUGI",
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value:
                        "Anda setuju untuk melindungi, memberikan ganti rugi, dan membebaskan kami dan pihak mana pun yang menerima ganti rugi dari dan terhadap semua dan tuntutan, biaya, kerusakan, kerugian, tanggung jawab, dan pengeluaran (termasuk biaya pengacara) apa pun yang timbul akibat atau terkait:",
                  ),
                  const TextSubtitle(
                    keys: "i",
                    value:
                        "penggunaan Anda atas Layanan dan/atau Platform, transaksi Anda dengan Penyedia Layanan, penyedia pihak ketiga, mitra, pengiklan, dan/atau sponsor;",
                  ),
                  const TextSubtitle(
                    keys: "ii",
                    value:
                        "pelanggaran Anda atas ketentuan apa pun dalam Syarat dan Ketentuan ini atau hukum atau peraturan apa pun yang berlaku, baik yang dirujuk di sini maupun tidak;",
                  ),
                  const TextSubtitle(
                    keys: "iii",
                    value:
                        "pelanggaran Anda atas hak pihak ketiga apa pun, termasuk Penyedia Layanan yang menyediakan Layanan melalui Platform; atau",
                  ),
                  const TextSubtitle(
                    keys: "iv",
                    value: "penggunaan atau penyalahgunaan Anda atas Platform.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "Kewajiban perlindungan dan ganti rugi ini akan tetap berlaku setelah Syarat dan Ketentuan serta penggunaan Anda atas Platform dan/atau Layanan berakhir.",
                  ),
                  // 8
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "8",
                    value: "HAK DAN KEKAYAAN INTELEKTUAL",
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value:
                        "Hak kekayaan intelektual dalam dan terhadap Platform dan materi JumpaDokter dimiliki, dilisensi, atau dikontrol oleh kami, pemilik lisensi kami, atau Penyedia Layanan kami (sesuai yang relevan). Kami berhak untuk menggunakan hak kekayaan intelektual kami sejauh yang diizinkan oleh hukum.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "Bagian atau bagian-bagian dari Platform atau materi JumpaDokter yang tidak boleh direproduksi, direkayasa balik (reverse engineer), didekompilasi, diotak-atik, dipisahkan, diubah, didistribusikan, dipublikasikan ulang, ditampilkan, disiarkan, dipranala (hyperlink), disalin (mirror), di-frame (framing), dipindahkan, atau dikirimkan dengan cara atau metode apa pun atau disimpan dalam sistem pemulihan informasi atau dipasang di server, sistem, atau peralatan apa pun tanpa izin tertulis dari kami sebelumnya dari pemilik hak cipta yang relevan.\n\nIzin hanya akan diberikan kepada Anda untuk mengunduh, mencetak, atau menggunakan materi JumpaDokter untuk penggunaan pribadi dan nonkomersial, dengan catatan Anda tidak mengubah materi JumpaDokter dan bahwa kami atau pemilik hak cipta yang relevan tetap memegang semua hak cipta dan hak kekayaan intelektual lain yang terdapat dalam materi JumpaDokter.",
                  ),
                  const TextSubHeadings(
                    keys: "c",
                    value:
                        "Bagian mana pun dalam Platform dan Syarat dan Ketentuan ini tidak akan dianggap sebagai memberikan, berdasarkan implikasinya maupun tidak, lisensi atau hak apa pun untuk menggunakan (termasuk, sebagai meta tag atau ‘hot’ link ke situs web lain apa pun) merek dagang apa pun yang ditampilkan di Platform JumpaDokter, tanpa izin tertulis dari kami (atau pemilik merek dagang lain apa pun yang berlaku dan relevan).",
                  ),
                  const TextSubHeadings(
                    keys: "d",
                    value:
                        "Anda memberikan kami lisensi noneksklusif untuk menggunakan materi atau informasi yang Anda kirimkan di Platform dan/atau berikan kepada kami, termasuk tetapi tidak terbatas pada pertanyaan, ulasan, komentar, dan saran.\n\nSaat memublikasikan komentar atau ulasan di Platform, Anda juga memberikan kami hak untuk menggunakan nama yang dikirimkan atau nama pengguna Anda sehubungan dengan ulasan, komentar, dan konten lain.\n\nAnda tidak boleh menggunakan alamat email palsu, berpura-pura menjadi orang lain selain diri sendiri, atau menyesatkan kami atau pihak ketiga mengenai asal-usul kiriman apa pun yang Anda berikan. Kami dapat memublikasikan, menghapus, atau mengedit kiriman Anda sesuai kebijaksanaan tunggal kami.",
                  ),
                  // 9
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "9",
                    value: "PENGHENTIAN",
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value:
                        "Anda tidak berkewajiban untuk menggunakan Platform dan/atau Layanan dan dapat memilih untuk berhenti menggunakannya kapan pun dengan membatalkan akun Anda dan berhenti mengakses Platform, sehingga menonaktifkan penggunaan Anda atas Layanan.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "Kami berhak untuk segera menangguhkan, membatasi, atau menghentikan penggunaan Anda atas Platform dan/atau Layanan jika kami menduga Anda telah melanggar ketentuan apa pun dalam Syarat dan Ketentuan ini atau hukum dan peraturan yang berlaku.",
                  ),
                  const TextSubHeadings(
                    keys: "c",
                    value:
                        "JumpaDokter dan semua Pelanggan setuju untuk mengabaikan ketentuan-ketentuan dalam Pasal 1266 Kitab Undang-Undang Hukum Perdata, sejauh yang dibutuhkan oleh keputusan atau persetujuan pengadilan untuk mengakhiri Syarat dan Ketentuan ini dan ketentuan-ketentuan dalam Pasal 1267 Kitab Undang-Undang Hukum Perdata.",
                  ),
                  // 10
                  const SizedBox(
                    height: 10,
                  ),
                  const TextHeadings(
                    keys: "10",
                    value: "PENGHENTIAN",
                  ),
                  const TextSubHeadings(
                    keys: "a",
                    value:
                        "Pengabaian atau pelepasan atau kegagalan untuk menuntut pelanggaran dari ketentuan mana pun dari Syarat dan Ketentuan ini atau untuk melaksanakan hak apa pun yang ditentukan oleh Syarat dan Ketentuan ini atau hukum yang berlaku, tidak akan dianggap menandakan pengabaian perihal pelanggaran selanjutnya atas ketentuan mana pun di sini.",
                  ),
                  const TextSubHeadings(
                    keys: "b",
                    value:
                        "Syarat dan Ketentuan ini telah disiapkan dalam bahasa Inggris dan Indonesia, keduanya akan mengikat Anda dan kami. Apabila terdapat ketidakonsistenan antara versi bahasa Indonesia dan bahasa Inggris, versi bahasa Inggris akan berlaku.",
                  ),
                  const TextSubHeadings(
                    keys: "c",
                    value:
                        "Jika ketentuan apa pun di bawah Syarat dan Ketentuan ini dianggap ilegal, tidak valid, atau tidak dapat dilaksanakan, secara keseluruhan atau sebagian, di bawah pemberlakuan atau peraturan hukum, ketentuan atau bagian dari ketentuan tersebut, sejauh itu, dianggap bukan merupakan bagian dari Syarat dan Ketentuan ini, tetapi kelegalan, keabsahan, dan kemampuan pelaksanaan dari sisa Syarat dan Ketentuan ini tidak akan terpengaruh.",
                  ),
                  const TextSubHeadings(
                    keys: "d",
                    value:
                        "Segala sengketa yang berkaitan dengan Ketentuan Penggunaan ini, diselesaikan secara musyawarah untuk mufakat atau melalui Badan Arbitrase Nasional Indonesia (BANI), sesuai dengan prosedur yang berlaku di BANI. Apabila kedua belah pihak tidak sepakat untuk menyelesaikannya sengketa di BANI, maka sengketa akan diselesaikan melalui Pengadilan Negeri setempat [**].",
                  ),
                  const TextSubHeadings(
                    keys: "e",
                    value:
                        "Syarat dan Ketentuan ini dapat diubah dari waktu ke waktu. Perubahan apa pun terhadap Syarat dan Ketentuan ini akan dipublikasikan di Platform. Penggunaan Platform secara berkelanjutan menandakan persetujuan dan penerimaan Anda terhadap perubahan tersebut.",
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TextChildSubtitle extends StatelessWidget {
  const TextChildSubtitle({
    Key? key,
    required this.keys,
    required this.value,
  }) : super(key: key);

  final String? keys;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingOnly(left: 60),
      child: ListTile(
        minLeadingWidth: 10,
        leading: Text(
          "$keys)",
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
