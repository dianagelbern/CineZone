import 'package:localstorage/localstorage.dart';

class LocalStorageRepository {
  late LocalStorage localStorage;

  LocalStorageRepository(String storageKey)
      : localStorage = LocalStorage(storageKey);

  Future setToken(String key, dynamic value) async {
    await localStorage.ready;

    return localStorage.setItem(key, value);
  }

  Future getToken(String key) async {
    await localStorage.ready;

    return localStorage.getItem(key);
  }
}
