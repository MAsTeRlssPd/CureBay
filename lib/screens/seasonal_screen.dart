import 'package:flutter/material.dart';

class SeasonalRiskScreen extends StatelessWidget {
  const SeasonalRiskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text('Seasonal Risk Map', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Current Context
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.indigo.shade600, Colors.indigo.shade800]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.gps_fixed, color: Colors.white70, size: 18),
                      SizedBox(width: 8),
                      Text('Current Location & Season', style: TextStyle(color: Colors.white70, fontSize: 13)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text('📍 Odisha • July 2026', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Monsoon season — Peak vector-borne disease risk', style: TextStyle(color: Colors.indigo.shade200, fontSize: 13)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _buildContextChip('🌧️ Monsoon', Colors.blue),
                      const SizedBox(width: 8),
                      _buildContextChip('🦟 High Vector', Colors.red),
                      const SizedBox(width: 8),
                      _buildContextChip('💧 Waterlogging', Colors.orange),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // How it works
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              color: Colors.indigo.shade50,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Icon(Icons.auto_awesome, color: Colors.indigo.shade700, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Same symptoms → different probabilities based on where you are and what month it is. The model auto-adjusts.',
                        style: TextStyle(fontSize: 12, color: Colors.indigo.shade900, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Disease Risk Table
            const Text('Disease Prior Probabilities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Adjusted for Odisha, July', style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
            const SizedBox(height: 12),
            _buildDiseaseRiskCard('Malaria', 0.72, '↑ 3.2x', Colors.red, 'Peak monsoon, stagnant water breeding grounds. Odisha is endemic zone.'),
            _buildDiseaseRiskCard('Dengue', 0.48, '↑ 2.1x', Colors.orange, 'Aedes mosquito breeding peaks in July-September. Urban + peri-urban risk.'),
            _buildDiseaseRiskCard('Typhoid', 0.35, '↑ 1.5x', Colors.amber.shade700, 'Contaminated water supply risk increases during floods.'),
            _buildDiseaseRiskCard('Cholera', 0.28, '↑ 1.8x', Colors.blue.shade700, 'Waterborne pathogen. Flooding and poor sanitation.'),
            _buildDiseaseRiskCard('Respiratory Infection', 0.12, '↓ 0.4x', Colors.teal, 'Low in summer monsoon. Peaks December-February.'),
            _buildDiseaseRiskCard('TB', 0.10, '—', Colors.grey, 'Year-round endemic. No significant seasonal variation.'),

            const SizedBox(height: 24),

            // Regional Comparison
            const Text('Regional Comparison', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildRegionRow('Odisha (current)', 'Malaria', 0.72, Colors.red),
                    const Divider(height: 20),
                    _buildRegionRow('Uttar Pradesh', 'Respiratory Inf.', 0.15, Colors.teal),
                    const Divider(height: 20),
                    _buildRegionRow('Rajasthan', 'Dengue', 0.55, Colors.orange),
                    const Divider(height: 20),
                    _buildRegionRow('West Bengal', 'Cholera', 0.40, Colors.blue),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  static Widget _buildContextChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildDiseaseRiskCard(String disease, double risk, String multiplier, Color color, String reason) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 8, height: 8,
                  decoration: BoxDecoration(color: color, shape: BoxShape.circle),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(disease, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15))),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: multiplier.contains('↑') ? Colors.red.shade50 : (multiplier.contains('↓') ? Colors.green.shade50 : Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(multiplier, style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.bold,
                    color: multiplier.contains('↑') ? Colors.red.shade700 : (multiplier.contains('↓') ? Colors.green.shade700 : Colors.grey.shade600),
                  )),
                ),
                const SizedBox(width: 10),
                Text('${(risk * 100).toInt()}%', style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: risk,
                backgroundColor: Colors.grey.shade100,
                valueColor: AlwaysStoppedAnimation<Color>(color.withOpacity(0.7)),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 8),
            Text(reason, style: TextStyle(fontSize: 12, color: Colors.grey.shade600, height: 1.3)),
          ],
        ),
      ),
    );
  }

  Widget _buildRegionRow(String region, String topDisease, double risk, Color color) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(region, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text('Top: $topDisease', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: risk,
              backgroundColor: Colors.grey.shade100,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text('${(risk * 100).toInt()}%', style: TextStyle(fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }
}
