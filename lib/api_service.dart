import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> calculatePrice(XFile image) async {
  var request = http.MultipartRequest('POST', Uri.parse(''));

  request.files.add(await http.MultipartFile.fromPath('image', image.path));

  var response = await request.send();
  if (response.statusCode == 200) {
    return jsonDecode(await response.stream.bytesToString());
  } else {
    throw Exception('Failed to calculate price');
  }
}
