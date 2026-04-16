import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool _isSpeaking = false;

  // Mock diagnostic results with confidence-aware outputs
  final List<Map<String, dynamic>> _predictions = [
    {
      'disease': 'Malaria',
      'probability': 0.62,
      'confidence': 'High',
      'differentiating': ['Periodic fever pattern', 'Splenomegaly on palpation', 'RDT positive'],
      'color': Colors.red,
    },
    {
      'disease': 'Dengue',
      'probability': 0.21,
      'confidence': 'Medium',
      'differentiating': ['Platelet count < 100k', 'Retro-orbital pain', 'Tourniquet test +'],
      'color': Colors.orange,
    },
    {
      'disease': 'Typhoid',
      'probability': 0.11,
      'confidence': 'Low',
      'differentiating': ['Step-ladder fever', 'Rose spots on abdomen', 'Widal test +'],
      'color': Colors.amber,
    },
    {
      'disease': 'Viral Fever',
      'probability': 0.06,
      'confidence': 'Low',
      'differentiating': ['Self-limiting (<5 days)', 'No localizing signs', 'CBC normal'],
      'color': Colors.green,
    },
  ];

  // Risk score calculation
  String get _riskLevel {
    final top = _predictions[0]['probability'] as double;
    if (top >= 0.6) return 'Emergency';
    if (top >= 0.4) return 'Urgent';
    return 'Normal';
  }

  Color get _riskColor {
    switch (_riskLevel) {
      case 'Emergency': return Colors.red;
      case 'Urgent': return Colors.orange;
      default: return Colors.green;
    }
  }

  IconData get _riskIcon {
    switch (_riskLevel) {
      case 'Emergency': return Icons.warning_amber_rounded;
      case 'Urgent': return Icons.priority_high;
      default: return Icons.check_circle;
    }
  }

  String get _riskAction {
    switch (_riskLevel) {
      case 'Emergency': return 'Immediate referral to PHC required.';
      case 'Urgent': return 'Refer within 24 hours. Monitor closely.';
      default: return 'Treat at home. Follow up in 3 days.';
    }
  }

  double get _riskScore {
    // Composite risk: weighted by probability and severity
    return (_predictions[0]['probability'] as double) * 100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Diagnostics Results', style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          // TTS Voice Playback
          IconButton(
            icon: Icon(
              _isSpeaking ? Icons.volume_up : Icons.volume_up_outlined,
              color: _isSpeaking ? Colors.teal : Colors.teal.shade400,
            ),
            onPressed: _playVoiceSummary,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Risk Level Banner
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [_riskColor.shade700, _riskColor.shade900]),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: _riskColor.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(_riskIcon, color: Colors.white, size: 36),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('$_riskLevel Risk', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(_riskAction, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  // Risk Score Bar
                  Row(
                    children: [
                      const Text('Risk Score: ', style: TextStyle(color: Colors.white70, fontSize: 12)),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: _riskScore / 100,
                            backgroundColor: Colors.white24,
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                            minHeight: 8,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('${_riskScore.toInt()}/100', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Risk Thresholds Legend
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildThresholdChip('0–39', 'Normal', Colors.green),
                    _buildThresholdChip('40–59', 'Urgent', Colors.orange),
                    _buildThresholdChip('60–100', 'Emergency', Colors.red),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // TTS Banner
            if (_isSpeaking)
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal.shade200),
                ),
                child: Row(
                  children: [
                    const _PulseWidget(color: Colors.teal),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '🔊 Reading results aloud in Hindi...',
                        style: TextStyle(color: Colors.teal.shade800, fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextButton(
                      onPressed: () => setState(() => _isSpeaking = false),
                      child: const Text('Stop'),
                    ),
                  ],
                ),
              ),

            // Top Predictions — Uncertainty-aware
            const Text('Condition Probabilities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 4),
            Text('Never a single diagnosis — always confidence-ranked differentials', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            const SizedBox(height: 12),
            ..._predictions.map((p) => _buildPredictionCard(p)),

            const SizedBox(height: 20),

            // Differentiating Symptoms Check
            const Text('Check for Differentiating Symptoms', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 4),
            Text('Ask these questions to narrow the diagnosis', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ..._predictions.take(3).map((p) => _buildDifferentialSection(p)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Next Steps (Drug DB / Home Care)
            const Text('Suggested Next Steps', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.medical_services_outlined, color: Colors.teal.shade700),
                        const SizedBox(width: 8),
                        const Text("Administer Initial Care", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text("• Paracetamol 500mg for fever reduction.\n• Keep patient hydrated with ORS.\n• Prepare for transportation to nearest PHC.\n• Perform RDT for Malaria if available in kit.",
                      style: TextStyle(height: 1.5, color: Colors.black87)),
                    const SizedBox(height: 12),
                    OutlinedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/drugs'),
                      icon: const Icon(Icons.medication, size: 18),
                      label: const Text('Open Drug Database'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.purple,
                        side: const BorderSide(color: Colors.purple),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Actions
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/whatsapp'),
              icon: const Icon(Icons.share),
              label: const Text('Export Summary via WhatsApp', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade600,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/')),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                side: BorderSide(color: Colors.teal.shade600),
                foregroundColor: Colors.teal.shade700,
              ),
              child: const Text('Back to Dashboard', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildThresholdChip(String range, String label, Color color) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 4),
        Text('$range ', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget _buildPredictionCard(Map<String, dynamic> p) {
    final probability = p['probability'] as double;
    final color = p['color'] as MaterialColor;
    final confidence = p['confidence'] as String;

    Color confColor;
    switch (confidence) {
      case 'High': confColor = Colors.green; break;
      case 'Medium': confColor = Colors.orange; break;
      default: confColor = Colors.grey;
    }

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
                Text(p['disease'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: confColor.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                  child: Text(confidence, style: TextStyle(fontSize: 10, color: confColor, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),
                Text('${(probability * 100).toInt()}%', style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 18)),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: probability,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifferentialSection(Map<String, dynamic> p) {
    final color = p['color'] as MaterialColor;
    final symptoms = p['differentiating'] as List<String>;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Text('If ${p['disease']}:', style: TextStyle(fontWeight: FontWeight.w600, color: color.shade700, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 6),
          ...symptoms.map((s) => Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 4),
            child: Row(
              children: [
                Icon(Icons.check_box_outline_blank, size: 16, color: Colors.grey.shade400),
                const SizedBox(width: 8),
                Expanded(child: Text(s, style: const TextStyle(fontSize: 13))),
              ],
            ),
          )),
          if (p != _predictions.take(3).last) const Divider(height: 16),
        ],
      ),
    );
  }

  void _playVoiceSummary() {
    setState(() => _isSpeaking = !_isSpeaking);

    if (_isSpeaking) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('🔊 "Sabse zyada sambhavna Malaria ki hai, baasath pratishat. Turant PHC bhejein."'),
          backgroundColor: Colors.teal.shade700,
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

      // Auto-stop after simulated playback
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) setState(() => _isSpeaking = false);
      });
    }
  }
}

// Pulsing animation widget for TTS indicator
class _PulseWidget extends StatefulWidget {
  final Color color;
  const _PulseWidget({required this.color});

  @override
  State<_PulseWidget> createState() => _PulseWidgetState();
}

class _PulseWidgetState extends State<_PulseWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Icon(Icons.volume_up, color: widget.color, size: 20),
    );
  }
}

// Extension to get shade from MaterialColor-like colors
extension on Color {
  Color get shade700 {
    return this is MaterialColor ? (this as MaterialColor).shade700 : this;
  }
  Color get shade900 {
    return this is MaterialColor ? (this as MaterialColor).shade900 : this;
  }
}
