import 'package:flutter/material.dart';
import 'produk_screen.dart';
import 'notifikasi_screen.dart';
import 'akun_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final Color primaryBlue = const Color(0xFF0000FF);
  final Color darkBlue = const Color(0xFF00008B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(130),
        child: Container(
          color: darkBlue,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            bottom: 12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(Icons.person, color: darkBlue),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "IAKN COMMERCE",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Username",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      const Icon(Icons.shopping_cart, color: Colors.white, size: 28),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: const Text(
                            "3",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Cari produk di IAKN Ambon...",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: Icon(Icons.tune, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Banner
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.campaign, color: primaryBlue),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "INFO KAMPUS TERKINI",
                              style: TextStyle(
                                color: primaryBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const Text(
                              "Bazar Dies Natalis dibuka di Gedung...",
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: darkBlue,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Text(
                          "Cek",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),

                // Categories Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Kategori Pilihan",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Geser >",
                        style: TextStyle(color: primaryBlue, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Categories Horizontal List
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCategoryItem(Icons.handshake, "Jasa/Layanan"),
                      _buildCategoryItem(Icons.design_services, "Desain Grafis"),
                      _buildCategoryItem(Icons.chair, "Minimalis"),
                      _buildCategoryItem(Icons.menu_book, "Buku/Ilmiah"),
                      _buildCategoryItem(Icons.computer, "Tek. Edukasi"),
                    ],
                  ),
                ),

                // Promo Banner
                Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.greenAccent,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              "DIES NATALIS EXPO",
                              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Diskon 35%",
                            style: TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Pekan Inovasi & Kewirausahaan\nMahasiswa",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Karya orisinal sivitas akademika IAKN\nAmbon: literatur teologi, media ajar,...",
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.local_offer, size: 16, color: darkBlue),
                        label: Text("Klaim Voucher", style: TextStyle(color: darkBlue)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          minimumSize: const Size(0, 36),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                      ),
                    ],
                  ),
                ),

                // Flash Sale Header
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.local_fire_department, color: Colors.red, size: 20),
                      const SizedBox(width: 4),
                      const Text(
                        "Flash Sale Dies Natalis",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      const Spacer(),
                      _buildTimerBox("04"),
                      const Text(
                        " : ",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      _buildTimerBox("15"),
                      const Text(
                        " : ",
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                      _buildTimerBox("29"),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Flash Sale Horizontal List
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildFlashSaleCard("Hoodie Dies Natalis", "Rp 99rb", "165rb", "-40%"),
                      _buildFlashSaleCard("Tumbler Edisi Ambon", "Rp 45rb", "90rb", "-50%"),
                      _buildFlashSaleCard("Miniature Ambon", "Rp 50rb", "100rb", "-50%"),
                    ],
                  ),
                ),

                // Popular Products Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Produk Terpopuler Kampus",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Karya unggulan mahasiswa dan dosen",
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const ProdukScreen()),
                          );
                        },
                        child: Text(
                          "Lihat\nSemua >",
                          style: TextStyle(color: primaryBlue, fontSize: 12),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Lightweight performant SliverGrid (lazily rendered, no shrinkWrap jank)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.64,
              ),
              delegate: SliverChildListDelegate([
                _buildProductCard(
                  "Buku Ilmiah",
                  "Antropologi Musik Maluku & Nusantara",
                  "Oleh: Prodi Musik Gereja",
                  "Rp 85.000",
                  4.9,
                  120,
                ),
                _buildProductCard(
                  "Jasa Grafis",
                  "Desain Banner & Publikasi Acara...",
                  "Kreatif Lab Mahasiswa",
                  "Rp 50.000",
                  4.8,
                  85,
                ),
                _buildProductCard(
                  "Alat Musik",
                  "Tifa Maluku Kayu Ukir Asli",
                  "Bengkel Seni Kampus",
                  "Rp 350.000",
                  5.0,
                  25,
                ),
                _buildProductCard(
                  "Tek. Edukasi",
                  "Media Belajar Interaktif PAUD...",
                  "Laboratorium FKIP IAKN",
                  "Rp 125.000",
                  4.9,
                  42,
                ),
              ]),
            ),
          ),

          // Guarantee Banner
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.verified_user, color: primaryBlue, size: 36),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jaminan Kualitas Akademik",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        Text(
                          "Setiap transaksi mendukung langsung dana beasiswa dan riset kreatif mahasiswa IAKN Ambon.",
                          style: TextStyle(fontSize: 11, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: primaryBlue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProdukScreen()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NotifikasiScreen()),
            );
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AkunScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Produk"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: "Notifikasi"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Akun"),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: primaryBlue.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: primaryBlue),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildTimerBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildFlashSaleCard(String title, String price, String oldPrice, String discount) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 95,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: const Center(child: Icon(Icons.image, color: Colors.grey)),
              ),
              Positioned(
                top: 4,
                left: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    discount,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyle(
                    color: primaryBlue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  oldPrice,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductCard(
    String tag,
    String title,
    String author,
    String price,
    double rating,
    int reviews,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 110,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                ),
                child: const Center(child: Icon(Icons.image, color: Colors.grey)),
              ),
              Positioned(
                top: 4,
                left: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          // Bounded Expanded avoids the unbounded Spacer assertion completely
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 12),
                          const SizedBox(width: 2),
                          Text(
                            "$rating",
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " ($reviews)",
                            style: const TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        author,
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          color: primaryBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: primaryBlue,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 14),
                      ),
                    ],
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
