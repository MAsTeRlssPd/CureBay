import 'package:flutter/material.dart';

class DrugDatabaseScreen extends StatefulWidget {
  const DrugDatabaseScreen({Key? key}) : super(key: key);

  @override
  State<DrugDatabaseScreen> createState() => _DrugDatabaseScreenState();
}

class _DrugDatabaseScreenState extends State<DrugDatabaseScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  final List<String> _categories = ['All', 'Antimalarials', 'Antibiotics', 'Analgesics', 'ORS/Fluids', 'Antiparasitics', 'Respiratory'];

  final List<Map<String, dynamic>> _drugs = [
    {
      'name': 'Chloroquine',
      'category': 'Antimalarials',
      'indication': 'Uncomplicated P. vivax malaria',
      'adultDose': '600mg base on day 1, then 300mg on days 2 & 3',
      'childDose': '10mg/kg day 1, then 5mg/kg days 2 & 3',
      'route': 'Oral',
      'warning': 'Contraindicated in retinal disease. Monitor for visual disturbances.',
      'inKit': true,
    },
    {
      'name': 'Artemether-Lumefantrine (ACT)',
      'category': 'Antimalarials',
      'indication': 'Uncomplicated P. falciparum malaria',
      'adultDose': '80/480mg twice daily for 3 days',
      'childDose': 'Weight-based: 5-14kg: 20/120mg; 15-24kg: 40/240mg; 25-34kg: 60/360mg',
      'route': 'Oral (take with fatty food)',
      'warning': 'Do not use in first trimester of pregnancy.',
      'inKit': true,
    },
    {
      'name': 'Paracetamol',
      'category': 'Analgesics',
      'indication': 'Fever, mild-moderate pain',
      'adultDose': '500-1000mg every 4-6 hours (max 4g/day)',
      'childDose': '10-15mg/kg every 4-6 hours (max 5 doses/day)',
      'route': 'Oral',
      'warning': 'Hepatotoxic in overdose. Do not exceed max daily dose.',
      'inKit': true,
    },
    {
      'name': 'ORS (Oral Rehydration Salts)',
      'category': 'ORS/Fluids',
      'indication': 'Dehydration from diarrhea, vomiting',
      'adultDose': '200-400ml after each loose stool',
      'childDose': '<2yr: 50-100ml per stool; 2-10yr: 100-200ml per stool',
      'route': 'Oral',
      'warning': 'Dissolve 1 packet in 1 litre of clean water. Use within 24 hours.',
      'inKit': true,
    },
    {
      'name': 'Zinc Tablets',
      'category': 'ORS/Fluids',
      'indication': 'Acute diarrhea in children (adjunct to ORS)',
      'adultDose': 'N/A — pediatric use',
      'childDose': '<6mo: 10mg/day for 14 days; >6mo: 20mg/day for 14 days',
      'route': 'Oral (dissolve in breast milk or water)',
      'warning': 'Continue even after diarrhea stops. Complete the 14-day course.',
      'inKit': true,
    },
    {
      'name': 'Amoxicillin',
      'category': 'Antibiotics',
      'indication': 'Pneumonia, ear infections, UTI',
      'adultDose': '500mg three times daily for 5-7 days',
      'childDose': '25-50mg/kg/day in 3 divided doses',
      'route': 'Oral',
      'warning': 'Check for penicillin allergy. Rash = stop immediately.',
      'inKit': true,
    },
    {
      'name': 'Cotrimoxazole',
      'category': 'Antibiotics',
      'indication': 'Typhoid, UTI, respiratory infections',
      'adultDose': '960mg (800/160) twice daily for 5 days',
      'childDose': '6wk-5mo: 120mg; 6mo-5yr: 240mg; 6-12yr: 480mg — twice daily',
      'route': 'Oral',
      'warning': 'Not for neonates <6 weeks. Ensure adequate fluid intake.',
      'inKit': true,
    },
    {
      'name': 'Metronidazole',
      'category': 'Antiparasitics',
      'indication': 'Amoebiasis, giardiasis, anaerobic infections',
      'adultDose': '400mg three times daily for 5-7 days',
      'childDose': '7.5mg/kg three times daily for 5-7 days',
      'route': 'Oral',
      'warning': 'Avoid alcohol during treatment and 48 hours after.',
      'inKit': true,
    },
    {
      'name': 'Albendazole',
      'category': 'Antiparasitics',
      'indication': 'Roundworm, hookworm, whipworm',
      'adultDose': '400mg single dose',
      'childDose': '1-2yr: 200mg single dose; >2yr: 400mg single dose',
      'route': 'Oral (chewable)',
      'warning': 'Not recommended in pregnancy (first trimester).',
      'inKit': true,
    },
    {
      'name': 'Salbutamol Inhaler',
      'category': 'Respiratory',
      'indication': 'Acute bronchospasm, asthma, wheezing',
      'adultDose': '2 puffs (200mcg) as needed, max 8 puffs/day',
      'childDose': '1-2 puffs via spacer as needed',
      'route': 'Inhalation',
      'warning': 'Shake well before use. Use spacer for children.',
      'inKit': false,
    },
    {
      'name': 'Iron + Folic Acid',
      'category': 'All',
      'indication': 'Iron deficiency anemia, pregnancy supplementation',
      'adultDose': '1 tablet (100mg Fe + 0.5mg FA) daily',
      'childDose': '6-59mo: IFA syrup 20mg Fe + 0.1mg FA daily',
      'route': 'Oral',
      'warning': 'Take on empty stomach. May cause black stools (normal).',
      'inKit': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredDrugs {
    return _drugs.where((drug) {
      final matchesSearch = drug['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          drug['indication'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' || drug['category'] == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.purple.shade700,
        foregroundColor: Colors.white,
        title: const Text('Drug Database', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          Center(child: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
              child: Text('${_drugs.length} drugs', style: const TextStyle(fontSize: 12)),
            ),
          )),
        ],
      ),
      body: Column(
        children: [
          // Search
          Container(
            color: Colors.purple.shade700,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search drugs or conditions...',
                hintStyle: TextStyle(color: Colors.purple.shade200),
                prefixIcon: Icon(Icons.search, color: Colors.purple.shade200),
                filled: true,
                fillColor: Colors.white.withOpacity(0.15),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ),

          // Category Chips
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: _categories.map((cat) {
                final selected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat, style: TextStyle(fontSize: 12, color: selected ? Colors.white : Colors.purple.shade700)),
                    selected: selected,
                    selectedColor: Colors.purple.shade600,
                    backgroundColor: Colors.purple.shade50,
                    side: BorderSide.none,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                  ),
                );
              }).toList(),
            ),
          ),

          // Drug List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredDrugs.length,
              itemBuilder: (context, index) => _buildDrugCard(_filteredDrugs[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrugCard(Map<String, dynamic> drug) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Colors.white,
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.purple.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.medication, color: Colors.purple.shade600, size: 22),
        ),
        title: Row(
          children: [
            Expanded(child: Text(drug['name'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15))),
            if (drug['inKit'] == true)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(4)),
                child: Text('IN KIT', style: TextStyle(color: Colors.green.shade700, fontSize: 9, fontWeight: FontWeight.bold)),
              ),
          ],
        ),
        subtitle: Text(drug['indication'], style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        children: [
          const Divider(),
          const SizedBox(height: 4),
          _buildDoseRow(Icons.person, 'Adult Dose', drug['adultDose']),
          const SizedBox(height: 10),
          _buildDoseRow(Icons.child_care, 'Child Dose', drug['childDose']),
          const SizedBox(height: 10),
          _buildDoseRow(Icons.local_hospital, 'Route', drug['route']),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.warning_amber, size: 16, color: Colors.amber.shade800),
                const SizedBox(width: 8),
                Expanded(child: Text(drug['warning'], style: TextStyle(fontSize: 12, color: Colors.amber.shade900, height: 1.3))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDoseRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.purple.shade400),
        const SizedBox(width: 8),
        SizedBox(width: 80, child: Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w500))),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 13, height: 1.3))),
      ],
    );
  }
}
