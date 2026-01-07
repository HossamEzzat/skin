import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/prediction_model.dart';
import 'prediction_remote_data_source.dart';

class PredictionRemoteDataSourceImpl implements PredictionRemoteDataSource {
  final http.Client client;

  PredictionRemoteDataSourceImpl({required this.client});

  @override
  Future<PredictionModel> predictBurn(File image) async {
    return await _predict("http://192.168.1.120:5000/burnpred", image);
  }

  @override
  Future<PredictionModel> predictSkinCancer(File image) async {
    return await _predict("http://192.168.1.120:5000/predict", image);
  }

  Future<PredictionModel> _predict(String url, File image) async {
    final uri = Uri.parse(url);
    final request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        return PredictionModel.fromJson(json.decode(responseData));
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}


