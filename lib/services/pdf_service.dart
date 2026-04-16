import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  /// Generates a patient assessment PDF document.
  static pw.Document generateAssessmentPdf({
    required String patientName,
    required int age,
    required String gender,
    required Map<String, dynamic> vitals,
    required List<String> symptoms,
    required List<Map<String, dynamic>> predictions,
    required String riskLevel,
  }) {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Curebay Assessment Report',
                        style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold)),
                    pw.Text('CONFIDENTIAL',
                        style: pw.TextStyle(fontSize: 10, color: PdfColors.red)),
                  ],
                ),
              ),
              pw.SizedBox(height: 10),

              // Patient Info
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey400),
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Patient Information',
                        style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.Divider(),
                    pw.Row(children: [
                      pw.Text('Name: $patientName'),
                      pw.SizedBox(width: 40),
                      pw.Text('Age: $age'),
                      pw.SizedBox(width: 40),
                      pw.Text('Gender: $gender'),
                    ]),
                  ],
                ),
              ),
              pw.SizedBox(height: 14),

              // Vitals
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.grey400),
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Vitals',
                        style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.Divider(),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: vitals.entries
                          .map((e) => pw.Text('${e.key}: ${e.value}'))
                          .toList(),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 14),

              // Symptoms
              pw.Text('Reported Symptoms',
                  style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 6),
              pw.Wrap(
                spacing: 8,
                runSpacing: 4,
                children: symptoms
                    .map((s) => pw.Container(
                          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: pw.BoxDecoration(
                            color: PdfColors.teal50,
                            borderRadius: pw.BorderRadius.circular(4),
                          ),
                          child: pw.Text(s.replaceAll('_', ' '), style: const pw.TextStyle(fontSize: 10)),
                        ))
                    .toList(),
              ),
              pw.SizedBox(height: 20),

              // Risk Badge
              pw.Container(
                width: double.infinity,
                padding: const pw.EdgeInsets.all(12),
                color: riskLevel == 'Emergency'
                    ? PdfColors.red100
                    : riskLevel == 'Urgent'
                        ? PdfColors.orange100
                        : PdfColors.green100,
                child: pw.Text(
                  'RISK LEVEL: ${riskLevel.toUpperCase()}',
                  style: pw.TextStyle(
                    fontSize: 16,
                    fontWeight: pw.FontWeight.bold,
                    color: riskLevel == 'Emergency'
                        ? PdfColors.red900
                        : riskLevel == 'Urgent'
                            ? PdfColors.orange900
                            : PdfColors.green900,
                  ),
                  textAlign: pw.TextAlign.center,
                ),
              ),
              pw.SizedBox(height: 14),

              // Predictions Table
              pw.Text('Top Predictions',
                  style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 6),
              pw.Table.fromTextArray(
                headers: ['Rank', 'Condition', 'Confidence'],
                data: predictions
                    .asMap()
                    .entries
                    .map((e) => [
                          '${e.key + 1}',
                          e.value['disease'],
                          '${(e.value['confidence'] * 100).toStringAsFixed(1)}%',
                        ])
                    .toList(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellAlignment: pw.Alignment.centerLeft,
              ),
              pw.SizedBox(height: 20),

              // Referral note
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.teal),
                  borderRadius: pw.BorderRadius.circular(4),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('Referral Note',
                        style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 6),
                    pw.Text(
                      'This patient has been assessed using the Curebay offline diagnostic tool. '
                      'Based on the reported symptoms and vitals, the primary suspected condition is '
                      '${predictions.isNotEmpty ? predictions[0]['disease'] : 'Unknown'}. '
                      'Please conduct confirmatory diagnostics at the nearest health center.',
                      style: const pw.TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ),
              pw.Spacer(),
              pw.Text(
                'Generated by Curebay App | ${DateTime.now().toIso8601String().split('T')[0]}',
                style: pw.TextStyle(fontSize: 8, color: PdfColors.grey),
              ),
            ],
          );
        },
      ),
    );

    return pdf;
  }
}
