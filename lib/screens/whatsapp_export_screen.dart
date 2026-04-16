import 'package:flutter/material.dart';

class WhatsAppExportScreen extends StatelessWidget {
  const WhatsAppExportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final report = _generateReport();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
        title: const Text('WhatsApp Export', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Connection Status
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.orange.shade200),
              ),
              child: Row(
                children: [
                  Icon(Icons.wifi_off, color: Colors.orange.shade700, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Currently offline. The message will be queued and sent automatically when connectivity returns.',
                      style: TextStyle(fontSize: 12, color: Colors.orange.shade900, height: 1.3),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Recipient
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Send To', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        backgroundColor: Colors.green.shade100,
                        child: Icon(Icons.person, color: Colors.green.shade700),
                      ),
                      title: const Text('Dr. Priya Sharma', style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: const Text('PHC Balangir • +91 98765 43210'),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(6)),
                        child: Text('Nearest PHC', style: TextStyle(fontSize: 11, color: Colors.green.shade700)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Report Preview
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Patient Report', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(6)),
                          child: Text('EMERGENCY', style: TextStyle(fontSize: 11, color: Colors.red.shade700, fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Text(
                        report,
                        style: const TextStyle(fontSize: 13, fontFamily: 'monospace', height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Send Button
            SizedBox(
              height: 56,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 2,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('📱 Report queued for WhatsApp delivery!'),
                      backgroundColor: Colors.green.shade600,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
                icon: const Icon(Icons.send, size: 20),
                label: const Text('Send via WhatsApp', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 48,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  side: const BorderSide(color: Colors.blueGrey),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Report copied to clipboard'), backgroundColor: Colors.blueGrey),
                  );
                },
                icon: const Icon(Icons.copy, size: 18),
                label: const Text('Copy Report Text'),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  String _generateReport() {
    return '''🏥 CUREBAY PATIENT REPORT
━━━━━━━━━━━━━━━━━━━━━━━
📅 Date: 15-Jul-2026, 3:45 PM
👤 ASHA Worker: Sunita Devi
📍 Location: Balangir Village, Odisha

👨‍⚕️ PATIENT DETAILS
Name: Ram Prasad
Age: 42 | Gender: Male | Wt: 58kg

🌡️ VITALS
Temp: 39.0°C (HIGH ⚠️)
BP: 110/70 mmHg
SpO2: 96%
HR: 98 BPM

🤒 SYMPTOMS
✓ Fever (5 days)
✓ Chills
✓ Joint Pain
✓ Headache

🔬 AI TRIAGE RESULT
⚠️ Risk Level: EMERGENCY
• Malaria — 85% confidence
• Typhoid — 10%
• Dengue — 5%

💊 INITIAL CARE GIVEN
• Paracetamol 500mg administered
• ORS started
• Patient hydrated

📋 RECOMMENDATION
→ IMMEDIATE referral to PHC
→ RDT for Malaria at PHC
→ Blood culture if Typhoid suspected
━━━━━━━━━━━━━━━━━━━━━━━
Sent from CureBay ASHA App''';
  }
}
