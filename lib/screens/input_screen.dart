import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  // Mock symptoms
  final List<String> _symptoms = [
    "Fever", "Chills", "Sweats", "Cough", "Sputum", "Weight_Loss", "Watery_Stools", 
    "Abdominal_Pain", "Vomiting", "Headache", "Joint_Pain", "Muscle_Pain", "Rash", 
    "Fatigue", "Weakness", "Pallor", "Shortness_of_Breath", "Chest_Pain", 
    "Polydipsia", "Polyuria", "Itching"
  ];
  final Map<String, bool> _selectedSymptoms = {};

  final TextEditingController _ageCtrl = TextEditingController();
  final TextEditingController _weightCtrl = TextEditingController();
  final TextEditingController _tempCtrl = TextEditingController();
  final TextEditingController _sysBpCtrl = TextEditingController();
  final TextEditingController _diaBpCtrl = TextEditingController();
  final TextEditingController _spo2Ctrl = TextEditingController();
  final TextEditingController _hrCtrl = TextEditingController();
  
  bool _isListening = false;
  String _assistantText = "Listening...";

  @override
  void initState() {
    super.initState();
    for (var sym in _symptoms) {
      _selectedSymptoms[sym] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Light greyish blue
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal.shade700,
        foregroundColor: Colors.white,
        title: const Text('New Assessment', style: TextStyle(fontWeight: FontWeight.w600)),
        actions: [
          IconButton(
            icon: const Icon(Icons.history_outlined),
            onPressed: () => Navigator.pushNamed(context, '/history'),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100), // Padding for fab
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Location Context Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: Colors.teal.shade50,
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.teal.shade700, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "📍 Odisha Region • High Malaria Risk Season",
                          style: TextStyle(color: Colors.teal.shade900, fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Patient Vitals Card
                      const Text("Patient Vitals & Demographics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                      const SizedBox(height: 12),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(child: _buildTextField(_ageCtrl, 'Age', Icons.calendar_today)),
                                  const SizedBox(width: 12),
                                  Expanded(child: _buildTextField(_weightCtrl, 'Weight (kg)', Icons.monitor_weight_outlined)),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(child: _buildTextField(_tempCtrl, 'Temp (°C)', Icons.thermostat)),
                                  const SizedBox(width: 12),
                                  Expanded(child: _buildTextField(_spo2Ctrl, 'SpO2 (%)', Icons.air)),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Expanded(child: _buildTextField(_sysBpCtrl, 'Sys BP', Icons.favorite_border)),
                                  const SizedBox(width: 12),
                                  Expanded(child: _buildTextField(_diaBpCtrl, 'Dia BP', Icons.favorite_border)),
                                ],
                              ),
                              const SizedBox(height: 12),
                              _buildTextField(_hrCtrl, 'Heart Rate (BPM)', Icons.monitor_heart_outlined),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Symptoms
                      const Text("Symptoms", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _symptoms.map((sym) {
                          final isSelected = _selectedSymptoms[sym]!;
                          return FilterChip(
                            label: Text(sym.replaceAll("_", " ")),
                            selected: isSelected,
                            selectedColor: Colors.teal.shade100,
                            checkmarkColor: Colors.teal.shade700,
                            backgroundColor: Colors.white,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.teal.shade900 : Colors.black87,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: isSelected ? Colors.teal : Colors.grey.shade300)
                            ),
                            onSelected: (bool selected) {
                              setState(() {
                                _selectedSymptoms[sym] = selected;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal.shade600,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 2,
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Analyzing vitals and processing symptoms..."),
                                backgroundColor: Colors.teal,
                                duration: Duration(seconds: 1),
                              ),
                            );
                            Future.delayed(const Duration(seconds: 1), () {
                              Navigator.pushNamed(context, '/results');
                            });
                          },
                          child: const Text('Run Diagnostics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _simulateAssistant();
        },
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.mic),
        label: const Text("Voice Assistant"),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20, color: Colors.grey.shade600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      keyboardType: TextInputType.number,
    );
  }

  void _simulateAssistant() {
    setState(() {
      _isListening = true;
      _assistantText = "Listening...";
    });

    _showAssistantBottomSheet();

    // After 2 seconds, simulate transcription
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _assistantText = "Patient has high fever (39°C), chills, and joint pain...";
      });
      
      // Select the symptoms automatically
      Future.delayed(const Duration(seconds: 1), () {
        if (!mounted) return;
        setState(() {
          _selectedSymptoms["Fever"] = true;
          _selectedSymptoms["Chills"] = true;
          _selectedSymptoms["Joint_Pain"] = true;
          _tempCtrl.text = "39.0";
          _assistantText = "Auto-filled: Fever, Chills, Joint Pain. Temp set to 39.0°C.";
        });
      });
    });
  }

  void _showAssistantBottomSheet() {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            // Internal timer to update modal state when parent changes
            return Container(
              padding: const EdgeInsets.all(24),
              height: 320,
              child: Column(
                children: [
                  Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
                  const SizedBox(height: 20),
                  const _PulseIcon(),
                  const SizedBox(height: 20),
                  Text(
                    _isListening ? "Smart Assistant" : "Processing...",
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                  ),
                  const SizedBox(height: 12),
                  Container(
                    height: 80,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200)
                    ),
                    child: Center(
                      child: Text(
                        _assistantText, 
                        textAlign: TextAlign.center, 
                        style: TextStyle(
                          color: Colors.teal.shade900, 
                          fontStyle: FontStyle.italic,
                          fontSize: 15
                        )
                      ),
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                      ),
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.check),
                      label: const Text("Apply & Close"),
                    ),
                  )
                ],
              ),
            );
          }
        );
      }
    ).then((_) {
      setState(() { _isListening = false; });
    });
  }
}

class _PulseIcon extends StatefulWidget {
  const _PulseIcon({Key? key}) : super(key: key);

  @override
  State<_PulseIcon> createState() => _PulseIconState();
}

class _PulseIconState extends State<_PulseIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut)),
      child: const Icon(Icons.mic, size: 48, color: Colors.teal),
    );
  }
}
