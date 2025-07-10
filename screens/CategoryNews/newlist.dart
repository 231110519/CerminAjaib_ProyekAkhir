// screens/CategoryNews/newlist.dart

class News {
  final String title;
  final String description;
  final String localImagePath;

  News({
    required this.title,
    required this.description,
    required this.localImagePath,
  });
}

final List<News> newsList = [
  News(
    title: "Aksi Gizi Generasi Maju  ",
    description: "Wujudkan generasi maju bebas stunting dengan perilaku kayak protein hewani.",
    localImagePath: "assets/images/category/news/doktergizi1.jpg",
  ),
  News(
    title: "Gizi & Olahraga Terpadu",
    description: "Program gaya hidup sehat gabungkan nutrisi seimbang dan latihan fisik teratur.",
    localImagePath: "assets/images/category/news/doktergizi2.jpg",
  ),
  News(
    title: "Edukasi Gizi untuk Ibu Hamil Cegah Stunting",
    description: "Intervensi gizi sejak kehamilan kunci utama generasi bebas stunting.",
    localImagePath: "assets/images/category/news/doktergizi3.jpeg",
  ),
  News(
    title: "Kombinasi MPASI Tepat untuk Anak Usia 6-12 Bulan",
    description: "Pola makan bergizi seimbang fondasi pertumbuhan anak di masa emas.",
    localImagePath: "assets/images/category/news/doktergizi4.jpg",
  ),
  News(
    title: "Gaya Hidup Sehat Serta Olahraga Sehat",
    description: "5 rutinitas olahraga simpel yang bisa dilakukan di rumah untuk tubuh lebih bugar setiap hari.",
    localImagePath: "assets/images/category/news/gayahidup1.jpeg",
  ),
  News(
    title: "Gaya Hidup Sehat",
    description: "Mulai dari pola tidur hingga manajemen stres - langkah mudah hidup seimbang ala ahli gizi.",
    localImagePath: "assets/images/category/news/gayahidup2.jpeg",
  ),
  News(
    title: "Cara Hidup Sehat",
    description: "Tanpa diet ketat! Ubah kebiasaan kecil ini untuk metabolisme yang lebih baik dalam 30 hari.",
    localImagePath: "assets/images/category/news/gayahidup3.jpeg",
  ),
  News(
    title: "Pentingnya hidup sehat bersama keluarga",
    description: "de aktivitas seru yang bikin seluruh keluarga aktif tanpa gadget di akhir pekan.",
    localImagePath: "assets/images/category/news/gayahidup4.jpeg",
  ),
  News(
    title: "Semangat Atlet: Kunci Konsistensi Ala Greysia Polii.",
    description: "Belajar dari Greysia Polii, peraih emas Olimpiade, tentang pentingnya disiplin dan semangat pantang menyerah dalam rutinitas olahraga harian.",
    localImagePath: "assets/images/category/news/olahraga1.jpeg",
  ),
  News(
    title: "Menaklukkan Puncak: Inspirasi dari Pendaki Indonesia",
    description: "Dedy Zaqyah, pendaki muda Indonesia, menunjukkan bahwa mendaki gunung bukan sekadar hobi—tapi cara menjaga fisik dan mental tetap tangguh.",
    localImagePath: "assets/images/category/news/olahraga2.jpeg"
  ),
  News(
    title: "Fit Seperti Lindswell Kwok",
    description: "Atlet wushu kebanggaan Indonesia ini mengajarkan bahwa ketenangan, fleksibilitas, dan latihan rutin bisa membuat tubuh sehat dan jiwa tenang.",
    localImagePath: "assets/images/category/news/olahraga3.jpeg",
  ),
  News(
    title: "Latihan Harian Ala Jonatan Christie",
    description: "DJojo, atlet bulutangkis inspiratif, membagikan cara sederhana berolahraga di rumah untuk jaga stamina dan bentuk tubuh ideal.",
    localImagePath: "assets/images/category/news/olahraga4.jpg",
  ),
];
