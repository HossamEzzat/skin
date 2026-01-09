import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../../../core/error/exceptions.dart';
import '../models/prediction_model.dart';
import 'prediction_remote_data_source.dart';

class PredictionRemoteDataSourceImpl implements PredictionRemoteDataSource {
  final http.Client client;

  PredictionRemoteDataSourceImpl({required this.client});

  static const _baseUrl = "http://192.168.1.119:8000";

  @override
  Future<PredictionModel> predictBurn(File image) async {
    return _predict("$_baseUrl/predict/skinburn", image);
  }

  @override
  Future<PredictionModel> predictSkinCancer(File image) async {
    return _predict("$_baseUrl/predict/skindisease", image);
  }

  Future<PredictionModel> _predict(String url, File image) async {
    final uri = Uri.parse(url);

    try {
      final request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('image', image.path));

      // ✅ Use injected client (clean architecture friendly)
      final streamedResponse = await client.send(request);
      final body = await streamedResponse.stream.bytesToString();

      if (streamedResponse.statusCode != 200) {
        throw ServerException();
      }

      final decoded = json.decode(body);

      // Normalize different backend response shapes into one model shape:
      final normalized = _normalizePredictionJson(decoded);

      return PredictionModel.fromJson(normalized);
    } catch (_) {
      throw ServerException();
    }
  }

  /// Ensures we always return:
  /// { "prediction": <String?>, "confidence": <double> }
  Map<String, dynamic> _normalizePredictionJson(dynamic decoded) {
    if (decoded is! Map<String, dynamic>) {
      throw ServerException();
    }

    // ✅ Case 0: Burn API: {burn_level, confidence}
    if (decoded.containsKey("burn_level") && decoded.containsKey("confidence")) {
      return {
        "prediction": decoded["burn_level"], // map burn_level -> prediction
        "confidence": (decoded["confidence"] as num).toDouble(),
      };
    }

    // Case 1: Skin disease simplified API: {prediction, confidence}
    if (decoded.containsKey("prediction") && decoded.containsKey("confidence")) {
      return {
        "prediction": decoded["prediction"],
        "confidence": (decoded["confidence"] as num).toDouble(),
      };
    }

    // Case 2: Old roboflow wrapper: {source, result: {predictions: [...]}}
    final result = decoded["result"];
    if (result is Map<String, dynamic>) {
      final preds = result["predictions"];
      if (preds is List && preds.isNotEmpty) {
        Map<String, dynamic> best = preds.first as Map<String, dynamic>;

        for (final p in preds) {
          final pm = p as Map<String, dynamic>;
          final current = (pm["confidence"] as num?)?.toDouble() ?? 0.0;
          final bestConf = (best["confidence"] as num?)?.toDouble() ?? 0.0;
          if (current > bestConf) best = pm;
        }

        return {
          "prediction": best["class"], // roboflow uses "class"
          "confidence": ((best["confidence"] as num?) ?? 0).toDouble(),
        };
      }
    }

    // If predictions empty or unexpected structure
    return {"prediction": "Unknown", "confidence": 0.0};
  }
}
