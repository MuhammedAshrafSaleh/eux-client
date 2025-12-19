// lib/features/tracking/data/services/tracking_service.dart

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class TrackingService {
  static const String _baseUrl =
      'https://demoopenapi.ijtms-eg.com/webopenplatformapi/api/logistics/trace';
  static const String _apiAccount = '866958120939696147';
  static const String _privateKey = '29535fad70ca4688aaa5b462320eb096';

  /// Generate digest signature
  String _generateDigest(String bizContent, String timestamp) {
    final data = bizContent + timestamp + _privateKey;
    final bytes = utf8.encode(data);
    final digest = md5.convert(bytes);
    return base64.encode(digest.bytes);
  }

  /// Track order by billCode
  Future<TrackingResponse> trackOrder(String billCode) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final bizContent = json.encode({'billCodes': billCode});
      final digest = _generateDigest(bizContent, timestamp);

      print('🔵 Tracking: $billCode');
      print('🔵 Timestamp: $timestamp');
      print('🔵 Digest: $digest');

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'apiAccount': _apiAccount,
          'digest': digest,
          'timestamp': timestamp,
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'bizContent': bizContent},
      );

      print('📥 Status: ${response.statusCode}');
      print('📥 Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        return TrackingResponse.fromJson(jsonResponse);
      } else {
        throw Exception('Failed: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error: $e');
      throw Exception('Tracking error: $e');
    }
  }
}

// Models
class TrackingResponse {
  final String code;
  final String msg;
  final List<TrackingData> data;

  TrackingResponse({required this.code, required this.msg, required this.data});

  bool get isSuccess => code == '1';

  factory TrackingResponse.fromJson(Map<String, dynamic> json) {
    return TrackingResponse(
      code: json['code']?.toString() ?? '',
      msg: json['msg']?.toString() ?? '',
      data:
          (json['data'] as List?)
              ?.map((e) => TrackingData.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class TrackingData {
  final String billCode;
  final List<TrackingDetail> details;

  TrackingData({required this.billCode, required this.details});

  factory TrackingData.fromJson(Map<String, dynamic> json) {
    return TrackingData(
      billCode: json['billCode']?.toString() ?? '',
      details:
          (json['details'] as List?)
              ?.map((e) => TrackingDetail.fromJson(e))
              .toList() ??
          [],
    );
  }
}

class TrackingDetail {
  final String scanTime;
  final String desc;
  final String scanType;
  final String scanNetworkCity;
  final String scanNetworkProvince;

  TrackingDetail({
    required this.scanTime,
    required this.desc,
    required this.scanType,
    required this.scanNetworkCity,
    required this.scanNetworkProvince,
  });

  factory TrackingDetail.fromJson(Map<String, dynamic> json) {
    return TrackingDetail(
      scanTime: json['scanTime']?.toString() ?? '',
      desc: json['desc']?.toString() ?? '',
      scanType: json['scanType']?.toString() ?? '',
      scanNetworkCity: json['scanNetworkCity']?.toString() ?? '',
      scanNetworkProvince: json['scanNetworkProvince']?.toString() ?? '',
    );
  }
}
