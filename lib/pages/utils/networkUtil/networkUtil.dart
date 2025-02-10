
import 'dart:io';

import 'package:dio/dio.dart' as DioDio show Dio;
import 'package:dio/io.dart';


class Networkutil {
   static DioDio.Dio getDio(){
      DioDio.Dio dio = DioDio.Dio();
      // 忽略所有证书错误（仅用于开发和测试）
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
      return dio;
  }
}