/// Maps spoken Hindi/Odia/English keywords to symptom checkbox keys.
/// Used by VoskService to auto-select symptoms from voice transcription.

class SymptomKeywordMap {
  static const Map<String, String> hindiToSymptom = {
    // Hindi keywords
    'bukhar': 'Fever',
    'bukhaar': 'Fever',
    'thand': 'Chills',
    'thandi': 'Chills',
    'khansi': 'Cough',
    'khasi': 'Cough',
    'sir dard': 'Headache',
    'sar dard': 'Headache',
    'ulti': 'Vomiting',
    'dast': 'Watery_Stools',
    'loose motion': 'Watery_Stools',
    'pet dard': 'Abdominal_Pain',
    'jodo mein dard': 'Joint_Pain',
    'jodon ka dard': 'Joint_Pain',
    'thakan': 'Fatigue',
    'kamzori': 'Weakness',
    'saans': 'Shortness_of_Breath',
    'saans phoolna': 'Shortness_of_Breath',
    'seene mein dard': 'Chest_Pain',
    'chhati dard': 'Chest_Pain',
    'daane': 'Rash',
    'khujli': 'Itching',
    'pasina': 'Sweats',
    'vajan kam': 'Weight_Loss',
    'balgam': 'Sputum',
    'pila rang': 'Pallor',
    'pyaas': 'Polydipsia',
    'peshab': 'Polyuria',
    'baar baar peshab': 'Polyuria',
    'maaspeshi dard': 'Muscle_Pain',
    
    // English keywords (fallback)
    'fever': 'Fever',
    'cough': 'Cough',
    'cold': 'Common Cold',
    'headache': 'Headache',
    'vomiting': 'Vomiting',
    'diarrhea': 'Watery_Stools',
    'stomach pain': 'Abdominal_Pain',
    'joint pain': 'Joint_Pain',
    'tired': 'Fatigue',
    'fatigue': 'Fatigue',
    'weakness': 'Weakness',
    'breathless': 'Shortness_of_Breath',
    'chest pain': 'Chest_Pain',
    'rash': 'Rash',
    'itching': 'Itching',
    'sweating': 'Sweats',
    'weight loss': 'Weight_Loss',
    'phlegm': 'Sputum',
    'pale': 'Pallor',
    'thirsty': 'Polydipsia',
    'frequent urination': 'Polyuria',
    'muscle pain': 'Muscle_Pain',
    'body pain': 'Muscle_Pain',
    'chills': 'Chills',
  };

  /// Parses a raw transcription string and returns a Set of matched symptom keys.
  static Set<String> parseTranscript(String transcript) {
    final lower = transcript.toLowerCase();
    final matched = <String>{};

    for (final entry in hindiToSymptom.entries) {
      if (lower.contains(entry.key)) {
        matched.add(entry.value);
      }
    }
    return matched;
  }
}
