import 'package:flutter/material.dart';
import 'material_detail_page.dart';

class MaterialsPage extends StatelessWidget {
  const MaterialsPage({super.key});

  static const List<Map<String, dynamic>> materials = [
    {
      'id': 1,
      'title': 'Pengertian TIK',
      'description':
          'Mengenal Teknologi Informasi dan Komunikasi serta manfaatnya dalam kehidupan.',
      'category': 'Dasar TIK',
      'duration': '10 Menit',
      'icon': Icons.computer_rounded,
      'color': Color(0xFF2563EB),
      'progress': 1.0,
    },
    {
      'id': 2,
      'title': 'Perangkat Keras Komputer',
      'description':
          'Mempelajari berbagai perangkat keras komputer dan fungsi masing-masing.',
      'category': 'Hardware',
      'duration': '15 Menit',
      'icon': Icons.desktop_windows_rounded,
      'color': Color(0xFF7C3AED),
      'progress': 0.65,
    },
    {
      'id': 3,
      'title': 'Perangkat Lunak',
      'description':
          'Mengenal software, sistem operasi, aplikasi, dan jenis-jenis perangkat lunak.',
      'category': 'Software',
      'duration': '15 Menit',
      'icon': Icons.apps_rounded,
      'color': Color(0xFF059669),
      'progress': 0.3,
    },
    {
      'id': 4,
      'title': 'Internet dan Jaringan',
      'description':
          'Memahami internet, jaringan komputer, dan cara menggunakannya dengan aman.',
      'category': 'Internet',
      'duration': '20 Menit',
      'icon': Icons.wifi_rounded,
      'color': Color(0xFFEA580C),
      'progress': 0.0,
    },
    {
      'id': 5,
      'title': 'Keamanan Digital',
      'description':
          'Belajar menjaga data pribadi dan menggunakan teknologi secara aman.',
      'category': 'Keamanan',
      'duration': '15 Menit',
      'icon': Icons.security_rounded,
      'color': Color(0xFFDC2626),
      'progress': 0.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text(
          'Materi TIK',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildHeader(),

          const SizedBox(height: 20),

          _buildSearchBar(),

          const SizedBox(height: 20),

          const Text(
            'Daftar Materi',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF111827),
            ),
          ),

          const SizedBox(height: 14),

          ...materials.map(
            (material) => _MaterialCard(
              material: material,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MaterialDetailPage(
                      material: material,
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2563EB),
            Color(0xFF3B82F6),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),

          const SizedBox(width: 15),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Belajar TIK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Pelajari materi dan tingkatkan kemampuanmu!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Cari materi...',
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Color(0xFF6B7280),
        ),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.tune_rounded),
        ),
      ),
    );
  }
}

class _MaterialCard extends StatelessWidget {
  final Map<String, dynamic> material;
  final VoidCallback onTap;

  const _MaterialCard({
    required this.material,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = material['color'] as Color;
    final double progress = material['progress'] as double;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 58,
                    height: 58,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(
                      material['icon'] as IconData,
                      color: color,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          material['category'] as String,
                          style: TextStyle(
                            fontSize: 12,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          material['title'] as String,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF111827),
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          material['description'] as String,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            height: 1.4,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF9CA3AF),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                children: [
                  const Icon(
                    Icons.access_time_rounded,
                    size: 15,
                    color: Color(0xFF9CA3AF),
                  ),

                  const SizedBox(width: 5),

                  Text(
                    material['duration'] as String,
                    style: const TextStyle(
                      fontSize: 11,
                      color: Color(0xFF6B7280),
                    ),
                  ),

                  const Spacer(),

                  Text(
                    '${(progress * 100).round()}%',
                    style: TextStyle(
                      fontSize: 11,
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 7),

              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: const Color(0xFFE5E7EB),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}