import 'dart:convert';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://card-collection-psi.vercel.app';


String tokenUsuario = '';

class ApiService {
  static Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $tokenUsuario',
  };

  //autenticar

  static Future<Map<String, dynamic>> login(String email, String senha) async {
    final res = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': senha}),
    );
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> cadastrar(
    String nome,
    String email,
    String senha,
  ) async {
    final res = await http.post(
      Uri.parse('$baseUrl/cadastro'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': nome, 'email': email, 'password': senha}),
    );
    return jsonDecode(res.body);
  }

  //Coleções

  static Future<List<dynamic>> getColecoes() async {
    final res = await http.get(
      Uri.parse('$baseUrl/collection'),
      headers: _headers,
    );
    final body = jsonDecode(res.body);
    if (body is List) return body;
    return [];
  }

  static Future<Map<String, dynamic>> criarColecao(String nome) async {
    final res = await http.post(
      Uri.parse('$baseUrl/collection'),
      headers: _headers,
      body: jsonEncode({'nameCollection': nome}),
    );
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> editarColecao(
    String collectionId,
    String novoNome,
  ) async {
    final res = await http.put(
      Uri.parse('$baseUrl/collection'),
      headers: _headers,
      body: jsonEncode({
        'collectionId': collectionId,
        'nameCollection': novoNome,
      }),
    );
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> deletarColecao(
    String collectionId,
  ) async {
    final res = await http.delete(
      Uri.parse('$baseUrl/collection'),
      headers: _headers,
      body: jsonEncode({'collectionId': collectionId}),
    );
    return jsonDecode(res.body);
  }

  //Cartas

  static Future<Map<String, dynamic>> buscarCarta(String nome) async {
    final nomeEncoded = Uri.encodeComponent(nome);
    final res = await http.get(
      Uri.parse('$baseUrl/collection/card/add/$nomeEncoded'),
      headers: _headers,
    );
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> adicionarCarta(
    String nome,
    String collectionId,
    String set,
    int qtd,
  ) async {
    final nomeEncoded = Uri.encodeComponent(nome);
    final res = await http.post(
      Uri.parse('$baseUrl/collection/card/add/$nomeEncoded'),
      headers: _headers,
      body: jsonEncode({'collectionId': collectionId, 'set': set, 'qtd': qtd}),
    );
    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> deletarCarta(
    String collectionId,
    String set,
    String cardId,
  ) async {
    final res = await http.delete(
      Uri.parse('$baseUrl/collection/card'),
      headers: _headers,
      body: jsonEncode({
        'collectionId': collectionId,
        'set': set,
        'cardId': cardId,
      }),
    );
    return jsonDecode(res.body);
  }
}
