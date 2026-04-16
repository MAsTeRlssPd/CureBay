import 'package:flutter_onnxruntime/flutter_onnxruntime.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class OnnxService {
  final OnnxRuntime _onnxRuntime = OnnxRuntime();
  OnnxModel? _model;

  Future<void> init() async {
    // Copy model from assets to a temp file (flutter_onnxruntime needs a file path)
    final rawAssetFile = await rootBundle.load('assets/xgboost_disease_model.onnx');
    final bytes = rawAssetFile.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final modelFile = File('${tempDir.path}/xgboost_disease_model.onnx');
    await modelFile.writeAsBytes(bytes, flush: true);

    _model = await _onnxRuntime.createSession(modelFile.path);
  }

  Future<Map<String, dynamic>> predict(List<double> features) async {
    if (_model == null) throw Exception("ONNX Session not initialized");

    // Build input map matching model's expected input
    final inputData = {
      'float_input': features,
    };

    final result = await _model!.run(inputData);
    return result;
  }

  void dispose() {
    _model?.close();
  }
}
