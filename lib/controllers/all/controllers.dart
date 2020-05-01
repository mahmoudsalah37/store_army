import 'dart:async';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

//const String domin = 'http://mahmmoudahmed-001-site2.ftempurl.com';
const String domin = 'https://localhost:44317';
html.File file;
String namePageFile;
int idFile;
const Map<String, String> _headers = {
  // 'X-Requested-With': 'XMLHttpRequest',
  'Access-Controle-Allow-Origin': '*'
};
/*Data*/
//Get all data
int counter = 0;
Future<String> getData(String strPath) async {
  final http.Response response =
      await http.get('$domin/api/$strPath', headers: {
    'Access-Control-Allow-Origin': '*',
  });
  if (response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to load post');
  }
}

//Add data
Future<http.Response> postData(
    String strPath, Map<String, dynamic> mapData) async {
  http.Response response = await http
      .post('$domin/api/$strPath',
          headers: {
            'Access-Control-Allow-Origin': '*',
          },
          body: mapData)
      .catchError((onError) {
    print(onError.toString());
  });
  return response;
}

//Update data
Future<http.Response> putData(
    String strPath, Map<String, dynamic> mapData) async {
  http.Response response = await http
      .put('$domin/api/$strPath/${mapData["id"].toString()}',
          headers: {
            'Access-Control-Allow-Origin': '*',
          },
          body: mapData)
      .catchError((onError) => print);

  return response;
}



//Delete data
Future<bool> deleteData(String strPath, List<int> ids) async {
  bool done = false;
  String query = '';
  ids.forEach((id) => query = '${query}ids=$id&');
  await http
      .delete(
    '$domin/api/$strPath?$query',
  )
      .whenComplete(() {
    done = true;
  }).catchError((onError) {
    done = false;
    print(onError.toString());
  });
  return done;
}


String numberValidator(String value) {
  if (value == null) {
    return null;
  }
  final n = num.tryParse(value);
  if (n == null) {
    return 'not a valid number';
  }
  return null;
}
