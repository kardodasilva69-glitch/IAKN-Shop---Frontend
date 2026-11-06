import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'notifikasi_screen.dart';
import 'akun_screen.dart';
import 'keranjang_screen.dart';
import 'detail_produk_screen.dart';
import 'fullscreen_image_viewer.dart';

class ProdukScreen extends StatefulWidget {
  const ProdukScreen({super.key});

  @override
  State<ProdukScreen> createState() => _ProdukScreenState();
}

class _ProdukScreenState extends State<ProdukScreen> {
  final Color primaryBlue = const Color(0xFF0000FF);
  final Color darkBlue = const Color(0xFF00008B);

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  String _selectedCategory = "Semua";
  String _selectedSort = "Terbaru";

  // Set ID produk yang difavoritkan
  final Set<String> _favoriteProductIds = {"prod_1"};

  final List<String> _categories = [
    "Semua",
    "Buku/Ilmiah",
    "Alat Musik",
    "Jasa/Layanan",
    "Merchandise",
    "Tek. Edukasi",
  ];

  // Daftar katalog produk IAKN Commerce
  final List<ProductItem> _allProducts = const [
    ProductItem(
      id: "prod_1",
      tag: "Handmade Kampus",
      tagColor: Colors.green,
      title: "Tifa Maluku Kayu Ukir Asli",
      author: "Galeri Seni Musik IAKN",
      category: "Alat Musik",
      price: "Rp 320.000",
      priceInt: 320000,
      rating: 4.9,
      reviews: 48,
      icon: Icons.music_note,
      iconColor: Colors.deepOrange,
      description:
          "Tifa tradisional khas Maluku dibuat handmade dari kayu pilihan dengan ukiran khas Ambon bernilai filosofis tinggi. Memiliki selaput membran kulit berkualitas tinggi yang menghasilkan dentuman akustik autentik untuk ibadah, pertunjukan musik gereja, maupun pentas seni etnik nusantara.",
      images: [
        "assets/images/produk/tifa_1.jpg",
        "assets/images/produk/tifa_2.jpg",
        "assets/images/produk/tifa_3.jpg",
      ],
    ),
    ProductItem(
      id: "prod_2",
      tag: "Karya Dosen",
      tagColor: Colors.blue,
      title: "Buku Teologi Kontekstual & Budaya Maluku",
      author: "Penulis: Dosen IAKN",
      category: "Buku/Ilmiah",
      price: "Rp 95.000",
      priceInt: 95000,
      rating: 5.0,
      reviews: 82,
      icon: Icons.menu_book,
      iconColor: Colors.blue,
      description:
          "Buku literatur komprehensif mengkaji dialog antara teologi Kristen dan kekayaan kearifan lokal budaya Maluku. Ditulis oleh akademisi dan dosen pakar IAKN Ambon sebagai rujukan perkuliahan dan wawasan kontekstual nusantara.",
    ),
    ProductItem(
      id: "prod_3",
      tag: "Layanan Kilat",
      tagColor: Colors.purple,
      title: "Jasa Translate Naskah Ilmiah & Abstrak",
      author: "Unit Bahasa Kampus",
      category: "Jasa/Layanan",
      price: "Rp 35.000",
      priceInt: 35000,
      rating: 4.9,
      reviews: 64,
      icon: Icons.translate,
      iconColor: Colors.purple,
      description:
          "Layanan penerjemahan profesional (Bahasa Indonesia - Inggris atau sebaliknya) untuk naskah jurnal, abstrak skripsi/tesis, artikel ilmiah, dan dokumen resmi universitas dengan akurasi tata bahasa akademis standar internasional.",
    ),
    ProductItem(
      id: "prod_4",
      tag: "Karya Mahasiswa",
      tagColor: Colors.green,
      title: "Gitar Akustik Custom Mahasiswa",
      author: "Prodi Pendidikan Seni",
      category: "Alat Musik",
      price: "Rp 750.000",
      priceInt: 750000,
      rating: 4.8,
      reviews: 19,
      icon: Icons.music_note,
      iconColor: Colors.green,
      description:
          "Gitar akustik pengerjaan tangan (custom-built) oleh mahasiswa jurusan Pendidikan Seni Musik IAKN Ambon. Dirancang khusus dengan intonasi presisi, kayu resonant pilihan, dan finishing halus.",
    ),
    ProductItem(
      id: "prod_5",
      tag: "Merchandise BEM",
      tagColor: Colors.pink,
      title: "Totebag Kanvas Motif Tenun Maluku",
      author: "BEM IAKN Ambon",
      category: "Merchandise",
      price: "Rp 45.000",
      priceInt: 45000,
      rating: 4.7,
      reviews: 53,
      icon: Icons.shopping_bag,
      iconColor: Colors.pink,
      description:
          "Tas totebag berbahan kanvas tebal dengan aksen motif tenun tradisional khas Maluku. Praktis untuk membawa buku kuliah, laptop kecil, dan perlengkapan harian kampus.",
    ),
    ProductItem(
      id: "prod_6",
      tag: "Lisensi Edu",
      tagColor: Colors.teal,
      title: "Software Pembelajaran Liturgi Digital",
      author: "Lab Komputer IAKN",
      category: "Tek. Edukasi",
      price: "Rp 150.000",
      priceInt: 150000,
      rating: 4.9,
      reviews: 31,
      icon: Icons.computer,
      iconColor: Colors.teal,
      description:
          "Aplikasi media ajar digital interaktif untuk simulasi liturgi dan musik gereja berbasis teknologi. Dikembangkan oleh tim laboratorium komputer untuk kebutuhan edukasi mahasiswa dan pelayan jemaat.",
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter & Pengurutan produk
  List<ProductItem> get _displayedProducts {
    List<ProductItem> list = _allProducts.where((product) {
      final query = _searchQuery.toLowerCase();
      final matchesSearch = _searchQuery.isEmpty ||
          product.title.toLowerCase().contains(query) ||
          product.author.toLowerCase().contains(query) ||
          product.tag.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query);

      final matchesCategory = _selectedCategory == "Semua" ||
          product.category.toLowerCase() == _selectedCategory.toLowerCase();

      return matchesSearch && matchesCategory;
    }).toList();

    // Sorting
    switch (_selectedSort) {
      case "Terlaris":
        list.sort((a, b) => b.reviews.compareTo(a.reviews));
        break;
      case "Harga Terendah":
        list.sort((a, b) => a.priceInt.compareTo(b.priceInt));
        break;
      case "Rating":
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case "Terbaru":
      default:
        // Urutan standar katalog
        break;
    }
    return list;
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        String tempCategory = _selectedCategory;
        String tempSort = _selectedSort;

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.tune, color: darkBlue, size: 22),
                            const SizedBox(width: 8),
                            Text(
                              "Filter & Urutkan Produk",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: darkBlue,
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            setModalState(() {
                              tempCategory = "Semua";
                              tempSort = "Terbaru";
                            });
                          },
                          child: const Text("Reset", style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                    const Divider(),
                    const SizedBox(height: 8),
                    const Text(
                      "Kategori Produk",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _categories.map((cat) {
                        final isSelected = tempCategory == cat;
                        return ChoiceChip(
                          label: Text(cat),
                          selected: isSelected,
                          selectedColor: primaryBlue,
                          backgroundColor: Colors.grey.shade100,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          onSelected: (selected) {
                            setModalState(() {
                              tempCategory = cat;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Urutkan Berdasarkan",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        "Terbaru",
                        "Terlaris",
                        "Harga Terendah",
                        "Rating",
                      ].map((sortOption) {
                        final isSelected = tempSort == sortOption;
                        return ChoiceChip(
                          label: Text(sortOption),
                          selected: isSelected,
                          selectedColor: darkBlue,
                          backgroundColor: Colors.grey.shade100,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          onSelected: (selected) {
                            setModalState(() {
                              tempSort = sortOption;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryBlue,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _selectedCategory = tempCategory;
                            _selectedSort = tempSort;
                          });
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Terapkan Filter",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _toggleFavorite(String productId, String title) {
    setState(() {
      if (_favoriteProductIds.contains(productId)) {
        _favoriteProductIds.remove(productId);
      } else {
        _favoriteProductIds.add(productId);
      }
    });

    final isFav = _favoriteProductIds.contains(productId);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFav
              ? "'$title' ditambahkan ke Favorit ❤️"
              : "'$title' dihapus dari Favorit",
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _addToCart(ProductItem product) {
    setState(() {
      CartManager.addItem(
        title: product.title,
        seller: product.author,
        category: product.category,
        price: product.priceInt,
        icon: product.icon,
        iconColor: product.iconColor,
      );
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.greenAccent, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "'${product.title}' ditambahkan ke keranjang!",
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: "Lihat",
          textColor: Colors.yellowAccent,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const KeranjangScreen()),
            ).then((_) {
              if (mounted) setState(() {});
            });
          },
        ),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayed = _displayedProducts;

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
                  const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(Icons.person, color: Color(0xFF00008B)),
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const KeranjangScreen()),
                      ).then((_) {
                        if (mounted) setState(() {});
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Stack(
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
                              child: Text(
                                "${CartManager.itemCount}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val.trim();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Cari produk di IAKN Ambon...",
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_searchQuery.isNotEmpty)
                          IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey, size: 20),
                            onPressed: () {
                              setState(() {
                                _searchController.clear();
                                _searchQuery = "";
                              });
                            },
                          ),
                        IconButton(
                          tooltip: "Filter & Urutkan",
                          icon: Icon(
                            Icons.tune,
                            color: (_selectedCategory != "Semua" || _selectedSort != "Terbaru")
                                ? primaryBlue
                                : Colors.grey,
                          ),
                          onPressed: _showFilterBottomSheet,
                        ),
                      ],
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
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
                // Header Katalog Produk
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Icon(Icons.shopping_bag, color: darkBlue),
                      const SizedBox(width: 8),
                      Text(
                        "Katalog Produk Kampus",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: darkBlue,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: primaryBlue.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "${displayed.length} Produk Tampil",
                          style: TextStyle(
                            color: darkBlue,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Category Chips interaktif
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: _categories.map((cat) {
                      return _buildChip(cat, isSelected: _selectedCategory == cat);
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 12),

                // Sort/Filter row interaktif
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      _buildSortChip(Icons.auto_awesome, "Terbaru", isSelected: _selectedSort == "Terbaru"),
                      _buildSortChip(Icons.trending_up, "Terlaris", isSelected: _selectedSort == "Terlaris"),
                      _buildSortChip(Icons.sell_outlined, "Harga Terendah", isSelected: _selectedSort == "Harga Terendah"),
                      _buildSortChip(Icons.star_outline, "Rating", isSelected: _selectedSort == "Rating"),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: _showFilterBottomSheet,
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: BoxDecoration(
                            color: (_selectedCategory != "Semua")
                                ? primaryBlue.withOpacity(0.08)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: (_selectedCategory != "Semua")
                                  ? primaryBlue
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Icon(
                            Icons.filter_list,
                            size: 16,
                            color: (_selectedCategory != "Semua")
                                ? primaryBlue
                                : Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),

          // Produk Grid — interaktif, terhubung ke DetailProdukScreen
          if (displayed.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.search_off, size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 12),
                      const Text(
                        "Produk tidak ditemukan",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Coba ubah filter kategori atau kata kunci pencarian Anda.",
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.58,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildProductCard(displayed[index]),
                  childCount: displayed.length,
                ),
              ),
            ),

          // Footer
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Semua produk aktif sivitas akademika telah ditampilkan."),
                            duration: Duration(seconds: 2),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      icon: Icon(Icons.keyboard_arrow_down, color: darkBlue),
                      label: Text(
                        "Tampilkan Lebih Banyak (${displayed.length})",
                        style: TextStyle(
                          color: darkBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue.withOpacity(0.08),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Menampilkan ${displayed.length} dari ${_allProducts.length} produk sivitas akademika",
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1,
        selectedItemColor: primaryBlue,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
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

  Widget _buildChip(String label, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? darkBlue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black54,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSortChip(IconData icon, String label, {bool isSelected = false}) {
    return GestureDetector(
      onTap: () => setState(() => _selectedSort = label),
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? primaryBlue.withOpacity(0.08) : Colors.transparent,
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: isSelected ? primaryBlue : Colors.black54),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? primaryBlue : Colors.black54,
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(ProductItem product) {
    final isFav = _favoriteProductIds.contains(product.id);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailProdukScreen(product: product),
          ),
        ).then((_) {
          if (mounted) setState(() {});
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Gambar produk atau icon placeholder (bisa ditekan untuk fullscreen viewer)
                GestureDetector(
                  onTap: () {
                    if (product.images.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FullscreenImageViewer(
                            images: product.images,
                            title: product.title,
                          ),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailProdukScreen(product: product),
                        ),
                      ).then((_) {
                        if (mounted) setState(() {});
                      });
                    }
                  },
                  child: Container(
                    height: 110,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: product.images.isNotEmpty
                          ? Colors.grey.shade100
                          : product.iconColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: product.images.isNotEmpty
                        ? ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                product.images[0],
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: 110,
                                errorBuilder: (context, error, stackTrace) => Center(
                                  child: Icon(product.icon, color: product.iconColor, size: 40),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Icon(product.icon, color: product.iconColor, size: 40),
                          ),
                  ),
                ),
                // Badge tag
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: product.tagColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      product.tag,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                // Tombol Favorit Interaktif
                Positioned(
                  top: 8,
                  right: 8,
                  child: InkWell(
                    onTap: () => _toggleFavorite(product.id, product.title),
                    borderRadius: BorderRadius.circular(12),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 12,
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        size: 14,
                        color: isFav ? Colors.red : Colors.grey,
                      ),
                    ),
                  ),
                ),
                // Badge jumlah foto jika ada > 1 gambar
                if (product.images.length > 1)
                  Positioned(
                    bottom: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.photo_library, size: 10, color: Colors.white),
                          const SizedBox(width: 3),
                          Text(
                            "${product.images.length}",
                            style: const TextStyle(
                              fontSize: 9,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
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
                              "${product.rating}",
                              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              " (${product.reviews})",
                              style: const TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.title,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(Icons.verified, size: 10, color: darkBlue),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                product.author,
                                style: const TextStyle(fontSize: 9, color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Harga", style: TextStyle(fontSize: 8, color: Colors.grey)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.price,
                              style: TextStyle(
                                color: darkBlue,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            InkWell(
                              onTap: () => _addToCart(product),
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: primaryBlue,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Icon(
                                  product.category == "Jasa/Layanan"
                                      ? Icons.assignment_turned_in
                                      : Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
