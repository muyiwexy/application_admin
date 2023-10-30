import 'dart:convert';

import 'package:application_admin/models/document_model.dart';
import 'package:application_admin/utils/app_constants.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

class ClientProvider with ChangeNotifier {
  final client = Client()
      .setEndpoint(Appconstants.endpoint)
      .setProject(Appconstants.projectId);
  // Add methods and properties as needed.
}

class AccountProvider with ChangeNotifier {
  final Account account;
  AccountProvider(Client client) : account = Account(client);

  Future createAccountSession({
    required String email,
    required String password,
  }) async {
    try {
      await account.createEmailSession(email: email, password: password);
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }
}

class DatabaseProvider with ChangeNotifier {
  final Databases databases;
  final Functions functions;
  DatabaseProvider(Client client)
      : databases = Databases(client),
        functions = Functions(client);

  List<DocumentModel>? _documentModel;
  List<DocumentModel>? get documentModel => _documentModel;
  void _setDocumentModel(List<DocumentModel> documentModel) {
    _documentModel = documentModel;
    notifyListeners();
  }

  Future getDocument() async {
    try {
      final request = await databases.listDocuments(
        databaseId: Appconstants.databaseId,
        collectionId: Appconstants.collectionId,
      );

      final setter = request.documents
          .map((documents) => DocumentModel.fromMap(documents.data))
          .toList();

      _setDocumentModel(setter);
      print("done");
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  void sendNotification(String token) async {
    try {
      final Map<String, dynamic> requestBody = {
        'deviceToken': token,
        'message': {
          'title': 'Notification Title',
          'body': 'Notification Body',
        },
      };

      final result = await functions.createExecution(
        functionId: Appconstants.functionId,
        body: jsonEncode(requestBody),
        path: '/',
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(result.responseBody);
      print(result.responseStatusCode);
    } catch (e) {
      print(e);
    }
  }
}
