import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: CustomScrollView(
        slivers: [
          // Gradient App Bar
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: Colors.teal.shade700,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.teal.shade800, Colors.teal.shade500],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.health_and_safety, color: Colors.white, size: 28),
                            ),
                            const SizedBox(width: 12),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('CureBay', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                                Text('ASHA Health Assistant', style: TextStyle(color: Colors.white70, fontSize: 13)),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.location_on, color: Colors.amber.shade300, size: 16),
                              const SizedBox(width: 6),
                              const Text('📍 Odisha Region • July 2026', style: TextStyle(color: Colors.white, fontSize: 12)),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade400,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text('HIGH RISK', style: TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Quick Stats
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _buildStatCard('Today', '3', 'Patients', Icons.person, Colors.blue),
                  const SizedBox(width: 12),
                  _buildStatCard('Week', '18', 'Patients', Icons.people, Colors.teal),
                  const SizedBox(width: 12),
                  _buildStatCard('Alerts', '1', 'Active', Icons.warning_amber, Colors.orange),
                ],
              ),
            ),
          ),

          // Feature Grid
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Diagnostic Tools', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  _buildFeatureCard(
                    context,
                    icon: Icons.add_circle_outline,
                    title: 'New Assessment',
                    subtitle: 'Start a patient diagnosis with vitals & symptoms',
                    color: Colors.teal,
                    route: '/input',
                  ),
                  const SizedBox(height: 10),
                  _buildFeatureCard(
                    context,
                    icon: Icons.analytics_outlined,
                    title: 'Epidemic Tracker',
                    subtitle: 'Detect outbreaks from village-level symptom clusters',
                    color: Colors.red.shade600,
                    route: '/epidemic',
                    badge: '1 Alert',
                  ),
                  const SizedBox(height: 10),
                  _buildFeatureCard(
                    context,
                    icon: Icons.map_outlined,
                    title: 'Seasonal Risk Map',
                    subtitle: 'Disease probabilities based on GPS + current month',
                    color: Colors.indigo,
                    route: '/seasonal',
                  ),
                  const SizedBox(height: 20),

                  const Text('Reference & Tools', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildMiniCard(context, Icons.medication_outlined, 'Drug Database', 'Dosage reference', Colors.purple, '/drugs')),
                      const SizedBox(width: 10),
                      Expanded(child: _buildMiniCard(context, Icons.monitor_heart_outlined, 'Vitals Guide', 'How to check', Colors.pink, '/vitals-guide')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(child: _buildMiniCard(context, Icons.history, 'Patient History', 'Past records', Colors.blueGrey, '/history')),
                      const SizedBox(width: 10),
                      Expanded(child: _buildMiniCard(context, Icons.share, 'WhatsApp Export', 'Send report', Colors.green, '/whatsapp')),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, String unit, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: color.withOpacity(0.08), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            Text('$unit', style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
            Text(label, style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(BuildContext context, {
    required IconData icon, required String title, required String subtitle,
    required Color color, required String route, String? badge,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.pushNamed(context, route),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                        if (badge != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                            child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey.shade400, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMiniCard(BuildContext context, IconData icon, String title, String subtitle, Color color, String route) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => Navigator.pushNamed(context, route),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(height: 10),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              const SizedBox(height: 2),
              Text(subtitle, style: TextStyle(color: Colors.grey.shade500, fontSize: 11)),
            ],
          ),
        ),
      ),
    );
  }
}
