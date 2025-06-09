import 'package:cloud_firestore/cloud_firestore.dart';

class LanguageRepository {
  final FirebaseFirestore _firestore;

  LanguageRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> saveLanguagePreference(String languageCode) async {
    await _firestore.collection('settings').doc('language').set({
      'code': languageCode,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<String> getLanguagePreference() async {
    final doc = await _firestore.collection('settings').doc('language').get();
    return (doc.exists == true) ? (doc.data()?['code'] ?? 'en') : 'en';
  }

  
}