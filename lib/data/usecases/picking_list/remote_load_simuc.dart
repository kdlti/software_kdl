import 'package:flutter/material.dart';
import '../../../../../../data/http/http.dart';
import '../../../../../../domain/helpers/helpers.dart';
import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';
import '../../models/picking_list/model_picking_list.dart';


class RemoteLoadSimucPickingList implements LoadSimucs {
  final String url;
  final HttpClient httpClient;

  RemoteLoadSimucPickingList({
    required this.url,
    required this.httpClient,
  });

  @override
 Future<List<EntitySimucsPiclingList>> loadSimucs(String doc, BuildContext context) async {
  try {
    final httpResponse = await httpClient.request(
      url: url,
      method: 'post',
      body: {'ar_id': int.parse(doc)},
    );

    if (httpResponse is List) {
      if (httpResponse.every((item) => item is Map<String, dynamic>)) {
        final simucEntities = httpResponse
            .map((json) => ModelPickingList.fromJson(json).toEntity())
            .toList();
        return simucEntities;
      } else {
        throw Exception("Itens inválidos na resposta do servidor: $httpResponse");
      }
    } else {
      throw Exception("Resposta inválida do servidor: $httpResponse");
    }
  } on HttpError catch (error) {
    _showAlertDialog(context);
    throw error == HttpError.forbidden
        ? DomainError.accessDenied
        : DomainError.unexpected;
  }
}

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text('A Peça não existe no Documento informado!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
