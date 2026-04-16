import 'package:flutter/material.dart';

class EpidemicScreen extends StatefulWidget {
  const EpidemicScreen({Key? key}) : super(key: key);

  @override
  State<EpidemicScreen> createState() => _EpidemicScreenState();
}

class _EpidemicScreenState extends State<EpidemicScreen> {
  // Mock village data for epidemic detection
  final List<Map<String, dynamic>> _villages = [
    {
      'name': 'Balangir Village',
      'population': 420,
      'threshold': 5,
      'cases': 7,
      'symptoms': ['Fever', 'Chills', 'Joint Pain', 'Headache'],
      'days': 5,
      'status': 'OUTBREAK',
      'suspectedDisease': 'Malaria',
    },
    {
      'name': 'Koraput Block A',
      'population': 1200,
      'threshold': 12,
      'cases': 4,
      'symptoms': ['Watery Stools', 'Vomiting', 'Abdominal Pain'],
      'days': 3,
      'status': 'WATCH',
      'suspectedDisease': 'Cholera',
    },
    {
      'name': 'Malkangiri Ward 3',
      'population': 680,
      'threshold': 7,
      'cases': 2,
      'symptoms': ['Cough', 'Fever', 'Weight Loss'],
      'days': 14,
      'status': 'NORMAL',
      'suspectedDisease': 'TB',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
        title: const Text('Epidemic Tracker', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Queued alert for PHC doctor. Will send when online.'), backgroundColor: Colors.teal),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Alert Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.red.shade600, Colors.red.shade800]),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.red.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Active Outbreak Alert', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('1 village exceeds threshold. Alert queued for PHC.', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Explanation Card
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              color: Colors.amber.shade50,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Colors.amber.shade800, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Threshold = population ÷ 100 (min 5). If X+ patients in same village have overlapping symptoms within 7 days → outbreak flagged.',
                        style: TextStyle(fontSize: 12, color: Colors.amber.shade900, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Village Cards
            ..._villages.map((v) => _buildVillageCard(v)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildVillageCard(Map<String, dynamic> village) {
    final status = village['status'] as String;
    Color statusColor;
    IconData statusIcon;
    switch (status) {
      case 'OUTBREAK':
        statusColor = Colors.red;
        statusIcon = Icons.error;
        break;
      case 'WATCH':
        statusColor = Colors.orange;
        statusIcon = Icons.visibility;
        break;
      default:
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
    }

    final cases = village['cases'] as int;
    final threshold = village['threshold'] as int;
    final progress = (cases / threshold).clamp(0.0, 1.0);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: status == 'OUTBREAK' ? BorderSide(color: Colors.red.shade200, width: 1.5) : BorderSide.none,
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(statusIcon, color: statusColor, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(village['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
                  child: Text(status, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Stats Row
            Row(
              children: [
                _buildStat('Population', '${village['population']}', Icons.people_outline),
                _buildStat('Cases', '$cases', Icons.sick_outlined),
                _buildStat('Threshold', '$threshold', Icons.flag_outlined),
                _buildStat('Window', '${village['days']}d', Icons.schedule),
              ],
            ),
            const SizedBox(height: 12),

            // Progress Bar
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey.shade200,
                      valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                      minHeight: 8,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text('$cases/$threshold', style: TextStyle(fontWeight: FontWeight.w600, color: statusColor, fontSize: 13)),
              ],
            ),
            const SizedBox(height: 12),

            // Suspected Disease
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Icon(Icons.coronavirus_outlined, color: statusColor, size: 18),
                  const SizedBox(width: 8),
                  Text('Suspected: ', style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                  Text('${village['suspectedDisease']}', style: TextStyle(fontWeight: FontWeight.w600, color: statusColor)),
                  const Spacer(),
                  Text('Symptoms: ', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                  Text('${(village['symptoms'] as List).length}', style: const TextStyle(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Symptom Chips
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: (village['symptoms'] as List<String>).map((s) =>
                Chip(
                  label: Text(s, style: const TextStyle(fontSize: 11)),
                  backgroundColor: statusColor.withOpacity(0.08),
                  side: BorderSide.none,
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 16, color: Colors.grey.shade500),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
        ],
      ),
    );
  }
}
