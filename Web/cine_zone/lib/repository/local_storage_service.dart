import 'package:cine_zone/repository/local_storage_repository.dart';
import 'package:flutter/cupertino.dart';

class LocalStorageService {
  LocalStorageService({required LocalStorageRepository localStorageRepository})
      : _localStorageRepository = localStorageRepository;

  LocalStorageRepository _localStorageRepository;

  Future<dynamic> getToken(String key) async {
    return await _localStorageRepository.getToken(key);
  }

  Future<void> setToken(String key, dynamic item) async {
    await _localStorageRepository.setToken(key, item);
  }
}
