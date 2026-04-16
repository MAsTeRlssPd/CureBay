import 'package:flutter/material.dart';

class VitalsGuideScreen extends StatelessWidget {
  const VitalsGuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.pink.shade600,
        foregroundColor: Colors.white,
        title: const Text('Vitals Guide', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Intro
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Colors.pink.shade400, Colors.pink.shade700]),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.school, color: Colors.white, size: 24),
                      SizedBox(width: 10),
                      Text('How to Check Vitals', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('Step-by-step guide for ASHA workers. Follow these instructions carefully for accurate readings.',
                    style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildVitalCard(
              number: '1',
              title: 'Body Temperature',
              icon: Icons.thermostat,
              color: Colors.red,
              equipment: 'Digital Thermometer',
              steps: [
                'Clean the thermometer tip with alcohol/water.',
                'Place under the patient\'s tongue (or armpit for children).',
                'Wait for the beep (usually 30-60 seconds).',
                'Read the display. Normal: 36.1°C to 37.2°C.',
                'Add 0.5°C if measuring from the armpit.',
              ],
              normalRange: '36.1–37.2°C',
              dangerSign: 'Above 39°C or below 35°C → Refer immediately',
            ),
            _buildVitalCard(
              number: '2',
              title: 'Blood Pressure (BP)',
              icon: Icons.favorite,
              color: Colors.blue,
              equipment: 'Digital BP Monitor (Cuff)',
              steps: [
                'Patient should sit quietly for 5 minutes before measurement.',
                'Wrap the cuff snugly around the upper left arm (2 fingers above elbow).',
                'The cuff tube should run down the inner arm.',
                'Press START. Keep the arm still and relaxed on a flat surface.',
                'Wait for the reading. Record both numbers (e.g., 120/80).',
              ],
              normalRange: 'Systolic: 90–120 mmHg\nDiastolic: 60–80 mmHg',
              dangerSign: 'Above 140/90 or below 90/60 → Refer',
            ),
            _buildVitalCard(
              number: '3',
              title: 'Pulse Oximetry (SpO2)',
              icon: Icons.air,
              color: Colors.teal,
              equipment: 'Fingertip Pulse Oximeter',
              steps: [
                'Clean the patient\'s finger. Remove nail polish if any.',
                'Clip the oximeter onto the index or middle finger.',
                'Wait 10-15 seconds for a stable reading.',
                'Read the SpO2 percentage and pulse rate on the display.',
                'Ensure the finger is warm — cold fingers give wrong readings.',
              ],
              normalRange: 'SpO2: 95–100%',
              dangerSign: 'Below 94% → Urgent referral. Below 90% → Emergency.',
            ),
            _buildVitalCard(
              number: '4',
              title: 'Heart Rate (Pulse)',
              icon: Icons.monitor_heart,
              color: Colors.purple,
              equipment: 'Fingers + Watch (or oximeter)',
              steps: [
                'Place two fingers (index + middle) on the patient\'s wrist.',
                'Find the pulse on the thumb side of the wrist.',
                'Count the beats for 30 seconds.',
                'Multiply by 2 to get beats per minute (BPM).',
                'Note if the rhythm feels regular or irregular.',
              ],
              normalRange: 'Adult: 60–100 BPM\nChild: 70–120 BPM',
              dangerSign: 'Below 50 or above 120 in adults → Refer',
            ),
            _buildVitalCard(
              number: '5',
              title: 'Respiratory Rate',
              icon: Icons.waves,
              color: Colors.indigo,
              equipment: 'Visual observation + Watch',
              steps: [
                'Do NOT tell the patient you are counting breaths.',
                'Watch the chest rise and fall.',
                'Count the number of full breaths in 60 seconds.',
                'One breath = one rise + one fall of the chest.',
                'Note if breathing looks labored or uses neck/rib muscles.',
              ],
              normalRange: 'Adult: 12–20/min\nChild: 20–30/min\nInfant: 30–50/min',
              dangerSign: 'Above 30 in adults → Respiratory distress',
            ),
            _buildVitalCard(
              number: '6',
              title: 'Weight',
              icon: Icons.monitor_weight,
              color: Colors.brown,
              equipment: 'Weighing Scale',
              steps: [
                'Place the scale on a flat, hard surface (not on a mat).',
                'Ask the patient to remove shoes and heavy clothing.',
                'Patient should stand still with weight evenly on both feet.',
                'Read the number when the display stabilizes.',
                'For infants: use a hanging spring scale with a cloth sling.',
              ],
              normalRange: 'Use BMI chart for age-appropriate ranges',
              dangerSign: 'Sudden weight loss >5% in 1 month → Investigate',
            ),
            const SizedBox(height: 20),

            // Emergency Reference
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.red.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.emergency, color: Colors.red.shade700, size: 22),
                      const SizedBox(width: 8),
                      Text('When to Refer IMMEDIATELY', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.red.shade800)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildDangerRow('Temperature > 39.5°C or < 35°C'),
                  _buildDangerRow('SpO2 < 90%'),
                  _buildDangerRow('BP > 180/110 or < 80/50'),
                  _buildDangerRow('Heart rate > 130 or < 40'),
                  _buildDangerRow('Breathing rate > 40 in adults'),
                  _buildDangerRow('Patient is unconscious or confused'),
                  _buildDangerRow('Severe bleeding or dehydration'),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalCard({
    required String number, required String title, required IconData icon,
    required Color color, required String equipment, required List<String> steps,
    required String normalRange, required String dangerSign,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text(number, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16))),
                ),
                const SizedBox(width: 10),
                Icon(icon, color: color, size: 22),
                const SizedBox(width: 8),
                Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16))),
              ],
            ),
            const SizedBox(height: 10),

            // Equipment
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(color: Colors.grey.shade50, borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Icon(Icons.build_outlined, size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 6),
                  Text('Equipment: ', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                  Text(equipment, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Steps
            ...steps.asMap().entries.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20, height: 20,
                    decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
                    child: Center(child: Text('${e.key + 1}', style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold))),
                  ),
                  const SizedBox(width: 8),
                  Expanded(child: Text(e.value, style: const TextStyle(fontSize: 13, height: 1.3))),
                ],
              ),
            )),
            const SizedBox(height: 8),

            // Normal Range + Danger
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('✅ Normal', style: TextStyle(fontSize: 10, color: Colors.green.shade700, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(normalRange, style: TextStyle(fontSize: 11, color: Colors.green.shade900)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('🚨 Danger', style: TextStyle(fontSize: 10, color: Colors.red.shade700, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 2),
                        Text(dangerSign, style: TextStyle(fontSize: 11, color: Colors.red.shade900)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDangerRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(Icons.arrow_right, color: Colors.red.shade600, size: 18),
          Expanded(child: Text(text, style: TextStyle(fontSize: 13, color: Colors.red.shade800))),
        ],
      ),
    );
  }
}
