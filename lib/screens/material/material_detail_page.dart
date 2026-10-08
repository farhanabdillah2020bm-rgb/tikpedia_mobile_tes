import 'package:flutter/material.dart';

class MaterialDetailPage extends StatefulWidget {
  final Map<String, dynamic> material;

  const MaterialDetailPage({
    super.key,
    required this.material,
  });

  @override
  State<MaterialDetailPage> createState() => _MaterialDetailPageState();
}

class _MaterialDetailPageState extends State<MaterialDetailPage> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    final material = widget.material;

    final Color color = material['color'] as Color;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'Detail Materi',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(
              material: material,
              color: color,
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    material: material,
                    color: color,
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Pengertian TIK',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF111827),
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    'Teknologi Informasi dan Komunikasi atau TIK '
                    'merupakan teknologi yang digunakan untuk mengolah, '
                    'menyimpan, mengambil, dan menyampaikan informasi '
                    'kepada orang lain.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.7,
                      color: Color(0xFF4B5563),
                    ),
                  ),

                  const SizedBox(height: 20),

                  _buildSection(
                    title: 'Manfaat TIK',
                    icon: Icons.lightbulb_outline_rounded,
                    color: color,
                    children: const [
                      'Mempermudah komunikasi.',
                      'Membantu proses pembelajaran.',
                      'Mempermudah pencarian informasi.',
                      'Meningkatkan produktivitas.',
                    ],
                  ),

                  const SizedBox(height: 20),

                  _buildSection(
                    title: 'Contoh Penggunaan TIK',
                    icon: Icons.devices_rounded,
                    color: color,
                    children: const [
                      'Menggunakan komputer untuk mengerjakan tugas.',
                      'Menggunakan internet untuk mencari informasi.',
                      'Melakukan pembelajaran secara online.',
                      'Berkomunikasi menggunakan aplikasi pesan.',
                    ],
                  ),

                  const SizedBox(height: 25),

                  _buildXPCard(color),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: isCompleted
                          ? null
                          : () {
                              setState(() {
                                isCompleted = true;
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Materi selesai! +20 XP 🎉',
                                  ),
                                ),
                              );
                            },
                      icon: Icon(
                        isCompleted
                            ? Icons.check_circle_rounded
                            : Icons.check_rounded,
                      ),
                      label: Text(
                        isCompleted
                            ? 'Materi Sudah Selesai'
                            : 'Tandai Selesai',
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader({
    required Map<String, dynamic> material,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        20,
        25,
        20,
        28,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              material['icon'] as IconData,
              color: Colors.white,
              size: 40,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            material['category'] as String,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            material['title'] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            material['description'] as String,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required Map<String, dynamic> material,
    required Color color,
  }) {
    return Row(
      children: [
        Expanded(
          child: _InfoItem(
            icon: Icons.access_time_rounded,
            title: 'Durasi',
            value: material['duration'] as String,
            color: color,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _InfoItem(
            icon: Icons.star_rounded,
            title: 'Reward',
            value: '+20 XP',
            color: color,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _InfoItem(
            icon: Icons.signal_cellular_alt_rounded,
            title: 'Level',
            value: 'Mudah',
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<String> children,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 23,
              ),

              const SizedBox(width: 8),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          ...children.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Color(0xFF4B5563),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildXPCard(Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withOpacity(0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.star_rounded,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reward Belajar',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF6B7280),
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  '+20 XP',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: Color(0xFF9CA3AF),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _InfoItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            size: 20,
            color: color,
          ),

          const SizedBox(height: 6),

          Text(
            title,
            style: const TextStyle(
              fontSize: 10,
              color: Color(0xFF9CA3AF),
            ),
          ),

          const SizedBox(height: 3),

          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}