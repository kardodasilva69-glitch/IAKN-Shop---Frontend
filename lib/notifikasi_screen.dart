import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'produk_screen.dart';
import 'akun_screen.dart';

class NotifikasiScreen extends StatefulWidget {
  const NotifikasiScreen({super.key});

  @override
  State<NotifikasiScreen> createState() => _NotifikasiScreenState();
}

class _NotifikasiScreenState extends State<NotifikasiScreen> {
  final Color primaryBlue = const Color(0xFF0000FF);
  final Color darkBlue = const Color(0xFF00008B);

  String _selectedCategory = "Semua";

  final List<Map<String, dynamic>> _notifications = [
    {
      "id": "1",
      "category": "Transaksi",
      "title": "Pesanan Sedang Dikirim",
      "desc": "Paket 'Tifa Maluku Kayu Ukir Asli' Anda sedang dalam perjalanan oleh kurir kampus.",
      "time": "10 menit yang lalu",
      "isUnread": true,
      "icon": Icons.local_shipping_outlined,
      "iconColor": Colors.blue,
      "dateGroup": "Hari Ini",
    },
    {
      "id": "2",
      "category": "Promo & Diskon",
      "title": "Voucher Dies Natalis Tersedia!",
      "desc": "Klaim voucher diskon 35% untuk semua produk buku teologi & literatur ilmiah hari ini.",
      "time": "1 jam yang lalu",
      "isUnread": true,
      "icon": Icons.local_offer_outlined,
      "iconColor": Colors.orange,
      "dateGroup": "Hari Ini",
    },
    {
      "id": "3",
      "category": "Info Kampus",
      "title": "Bazar Kampus Telah Dibuka",
      "desc": "Kunjungi stan pameran kewirausahaan mahasiswa di Gedung Auditorium IAKN Ambon.",
      "time": "4 jam yang lalu",
      "isUnread": true,
      "icon": Icons.campaign_outlined,
      "iconColor": Colors.purple,
      "dateGroup": "Hari Ini",
    },
    {
      "id": "4",
      "category": "Transaksi",
      "title": "Pembayaran Berhasil",
      "desc": "Pembayaran untuk 'Antropologi Musik Maluku' sebesar Rp 85.000 telah terverifikasi.",
      "time": "Kemarin, 14:20",
      "isUnread": false,
      "icon": Icons.check_circle_outline,
      "iconColor": Colors.green,
      "dateGroup": "Minggu Ini",
    },
    {
      "id": "5",
      "category": "Promo & Diskon",
      "title": "Flash Sale Dimulai!",
      "desc": "Dapatkan Hoodie Dies Natalis seharga Rp 99rb sebelum kehabisan kuota flash sale.",
      "time": "2 hari yang lalu",
      "isUnread": false,
      "icon": Icons.local_fire_department_outlined,
      "iconColor": Colors.red,
      "dateGroup": "Minggu Ini",
    },
    {
      "id": "6",
      "category": "Info Kampus",
      "title": "Pembaruan Aplikasi v1.0.1",
      "desc": "Peningkatan performa rendering sliver dan pengoptimalan scrolling telah diterapkan.",
      "time": "3 hari yang lalu",
      "isUnread": false,
      "icon": Icons.system_update_outlined,
      "iconColor": Colors.teal,
      "dateGroup": "Minggu Ini",
    },
  ];

  void _markAllAsRead() {
    setState(() {
      for (var item in _notifications) {
        item["isUnread"] = false;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Semua notifikasi telah ditandai dibaca."),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredNotifications = _selectedCategory == "Semua"
        ? _notifications
        : _notifications.where((n) => n["category"] == _selectedCategory).toList();

    final unreadCount = _notifications.where((n) => n["isUnread"] == true).length;

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
                          "NOTIFIKASI",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "Pembaruan aktivitas & info kampus",
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _markAllAsRead,
                    tooltip: "Tandai semua dibaca",
                    icon: const Icon(Icons.done_all, color: Colors.white, size: 24),
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
                    hintText: "Cari riwayat notifikasi...",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
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
          // Filter Chips Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 14.0, bottom: 8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                primary: false,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildFilterChip("Semua", badge: unreadCount > 0 ? "$unreadCount" : null),
                    _buildFilterChip("Transaksi"),
                    _buildFilterChip("Promo & Diskon"),
                    _buildFilterChip("Info Kampus"),
                  ],
                ),
              ),
            ),
          ),

          // Content List
          if (filteredNotifications.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.notifications_off_outlined, size: 64, color: Colors.grey.shade400),
                    const SizedBox(height: 12),
                    Text(
                      "Tidak ada notifikasi",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Kategori '$_selectedCategory' saat ini belum memiliki pesan baru.",
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = filteredNotifications[index];
                    final bool showHeader = index == 0 ||
                        item["dateGroup"] != filteredNotifications[index - 1]["dateGroup"];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (showHeader)
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0, bottom: 8.0, left: 4.0),
                            child: Text(
                              item["dateGroup"],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: darkBlue,
                              ),
                            ),
                          ),
                        _buildNotificationCard(item),
                      ],
                    );
                  },
                  childCount: filteredNotifications.length,
                ),
              ),
            ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // Highlight Notifikasi
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
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ProdukScreen()),
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
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notifikasi"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Akun"),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, {String? badge}) {
    final bool isSelected = _selectedCategory == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? darkBlue : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            if (badge != null) ...[
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : primaryBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    color: isSelected ? darkBlue : Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> item) {
    final bool isUnread = item["isUnread"] == true;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      color: isUnread ? Colors.blue.shade50.withValues(alpha: 0.5) : Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isUnread ? Colors.blue.shade200 : Colors.grey.shade200,
        ),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            item["isUnread"] = false;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Badge
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: (item["iconColor"] as Color).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  item["icon"] as IconData,
                  color: item["iconColor"] as Color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),

              // Notification Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            item["title"],
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        if (isUnread)
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(top: 4, left: 6),
                            decoration: BoxDecoration(
                              color: primaryBlue,
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item["desc"],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item["time"],
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
