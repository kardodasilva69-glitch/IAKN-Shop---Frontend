import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'produk_screen.dart';
import 'notifikasi_screen.dart';
import 'login_screen.dart';

class AkunScreen extends StatelessWidget {
  const AkunScreen({super.key});

  final Color primaryBlue = const Color(0xFF0000FF);
  final Color darkBlue = const Color(0xFF00008B);

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.logout, color: Colors.red),
              SizedBox(width: 8),
              Text("Konfirmasi Keluar", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          content: const Text("Apakah Anda yakin ingin keluar dari akun IAKN Commerce?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text("Batal", style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Keluar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          color: darkBlue,
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            right: 16,
            bottom: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "PROFIL SAYA",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "Kelola akun & transaksi kampus",
                    style: TextStyle(color: Colors.white70, fontSize: 11),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Membuka pengaturan profil"),
                      duration: Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.settings_outlined, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          // Profile Header Card
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.all(16),
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundColor: darkBlue.withValues(alpha: 0.1),
                            child: Icon(Icons.person, size: 40, color: darkBlue),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: primaryBlue,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(Icons.camera_alt, size: 12, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  "Mahasiswa IAKN",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.verified, size: 16, color: Colors.blue),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              "NIM: 202301048 • @mahasiswa_iakn",
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 11),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.green.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.green.shade200),
                              ),
                              child: Text(
                                "Mahasiswa Aktif (Seni Musik)",
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.green.shade800,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1),
                  const SizedBox(height: 12),

                  // Wallet & Points Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildWalletItem(
                        icon: Icons.account_balance_wallet_outlined,
                        iconColor: primaryBlue,
                        title: "Saldo Pay",
                        value: "Rp 245.000",
                        onTap: () {},
                      ),
                      Container(height: 30, width: 1, color: Colors.grey.shade200),
                      _buildWalletItem(
                        icon: Icons.stars_rounded,
                        iconColor: Colors.amber.shade700,
                        title: "Koin Kampus",
                        value: "1.250",
                        onTap: () {},
                      ),
                      Container(height: 30, width: 1, color: Colors.grey.shade200),
                      _buildWalletItem(
                        icon: Icons.confirmation_number_outlined,
                        iconColor: Colors.orange,
                        title: "Voucher",
                        value: "3 Aktif",
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

          // Order Status Section
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              elevation: 0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Pesanan Saya",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                      Text(
                        "Riwayat >",
                        style: TextStyle(color: primaryBlue, fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildOrderStatus(Icons.payment, "Belum Bayar", badge: 1),
                      _buildOrderStatus(Icons.inventory_2_outlined, "Diproses"),
                      _buildOrderStatus(Icons.local_shipping_outlined, "Dikirim", badge: 1),
                      _buildOrderStatus(Icons.assignment_turned_in_outlined, "Selesai"),
                      _buildOrderStatus(Icons.star_outline, "Beri Nilai", badge: 2),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

          // Menu Sections Header
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 8),
              child: Text(
                "Aktivitas & Fitur Kampus",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
              ),
            ),
          ),

          // Menu Group 1: Activity
          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              elevation: 0,
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.storefront_outlined,
                    iconColor: primaryBlue,
                    title: "Buka Stan / Jual Produk Mahasiswa",
                    subtitle: "Daftarkan karya seni, buku, atau jasa Anda",
                    isHighlight: true,
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 56),
                  _buildMenuItem(
                    icon: Icons.favorite_border,
                    iconColor: Colors.pink,
                    title: "Wishlist Produk Favorit",
                    subtitle: "5 barang tersimpan",
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 56),
                  _buildMenuItem(
                    icon: Icons.history,
                    iconColor: Colors.teal,
                    title: "Riwayat Transaksi Lengkap",
                    subtitle: "Daftar struk belanja dan tiket bazar",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // Menu Group 2: Settings & Info
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 18, bottom: 8),
              child: Text(
                "Pengaturan & Bantuan",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              elevation: 0,
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  _buildMenuItem(
                    icon: Icons.location_on_outlined,
                    iconColor: Colors.deepOrange,
                    title: "Alamat Pengiriman",
                    subtitle: "Gedung FKIP / Asrama / Kost Ambon",
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 56),
                  _buildMenuItem(
                    icon: Icons.lock_outline,
                    iconColor: Colors.indigo,
                    title: "Keamanan & Ganti Password",
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 56),
                  _buildMenuItem(
                    icon: Icons.support_agent_outlined,
                    iconColor: Colors.blue,
                    title: "Pusat Bantuan SISFO IAKN",
                    subtitle: "Layanan kendala akun & pesanan",
                    onTap: () {},
                  ),
                  const Divider(height: 1, indent: 56),
                  _buildMenuItem(
                    icon: Icons.info_outline,
                    iconColor: Colors.grey,
                    title: "Tentang IAKN Commerce",
                    subtitle: "Versi 1.0.1 (Stable)",
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          // Logout Button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: () => _showLogoutDialog(context),
                  icon: const Icon(Icons.logout, color: Colors.red, size: 18),
                  label: const Text(
                    "Keluar dari Akun",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red.shade200),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    backgroundColor: Colors.red.shade50.withValues(alpha: 0.3),
                  ),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3, // Highlight Akun
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
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NotifikasiScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Produk"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: "Notifikasi"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Akun"),
        ],
      ),
    );
  }

  Widget _buildWalletItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: iconColor),
                const SizedBox(width: 4),
                Text(title, style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderStatus(IconData icon, String label, {int badge = 0}) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.blue.shade50.withValues(alpha: 0.6),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: darkBlue, size: 20),
            ),
            if (badge > 0)
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                  child: Text(
                    "$badge",
                    style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.black87)),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    bool isHighlight = false,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        leading: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600,
            color: isHighlight ? darkBlue : Colors.black87,
          ),
        ),
        subtitle: subtitle != null
            ? Text(subtitle, style: TextStyle(fontSize: 11, color: Colors.grey.shade600))
            : null,
        trailing: const Icon(Icons.chevron_right, size: 18, color: Colors.grey),
      ),
    );
  }
}
