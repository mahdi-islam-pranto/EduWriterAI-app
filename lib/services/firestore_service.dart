import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/generated_content.dart';

class FirestoreService {
  static final FirestoreService _instance = FirestoreService._internal();
  factory FirestoreService() => _instance;
  FirestoreService._internal();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'generated_content';

  // Save generated content to Firestore
  Future<String> saveGeneratedContent(GeneratedContent content) async {
    try {
      final docRef = await _firestore
          .collection(_collectionName)
          .add(content.toFirestore());
      
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to save content: $e');
    }
  }

  // Get all generated content ordered by creation date (newest first)
  Future<List<GeneratedContent>> getAllGeneratedContent() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .orderBy('created_at', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => GeneratedContent.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch content: $e');
    }
  }

  // Get generated content by ID
  Future<GeneratedContent?> getGeneratedContentById(String id) async {
    try {
      final docSnapshot = await _firestore
          .collection(_collectionName)
          .doc(id)
          .get();

      if (docSnapshot.exists) {
        return GeneratedContent.fromFirestore(docSnapshot);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch content: $e');
    }
  }

  // Delete generated content by ID
  Future<void> deleteGeneratedContent(String id) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(id)
          .delete();
    } catch (e) {
      throw Exception('Failed to delete content: $e');
    }
  }

  // Get generated content by category
  Future<List<GeneratedContent>> getGeneratedContentByCategory(String category) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('category', isEqualTo: category)
          .orderBy('created_at', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => GeneratedContent.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch content by category: $e');
    }
  }

  // Get generated content by subject
  Future<List<GeneratedContent>> getGeneratedContentBySubject(String subject) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('subject', isEqualTo: subject)
          .orderBy('created_at', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => GeneratedContent.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch content by subject: $e');
    }
  }

  // Get content count
  Future<int> getContentCount() async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .get();
      
      return querySnapshot.docs.length;
    } catch (e) {
      throw Exception('Failed to get content count: $e');
    }
  }

  // Stream of all generated content (for real-time updates)
  Stream<List<GeneratedContent>> streamAllGeneratedContent() {
    return _firestore
        .collection(_collectionName)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => GeneratedContent.fromFirestore(doc))
            .toList());
  }

  // Update generated content
  Future<void> updateGeneratedContent(String id, Map<String, dynamic> updates) async {
    try {
      await _firestore
          .collection(_collectionName)
          .doc(id)
          .update(updates);
    } catch (e) {
      throw Exception('Failed to update content: $e');
    }
  }

  // Search content by topic
  Future<List<GeneratedContent>> searchContentByTopic(String searchTerm) async {
    try {
      final querySnapshot = await _firestore
          .collection(_collectionName)
          .where('topic', isGreaterThanOrEqualTo: searchTerm)
          .where('topic', isLessThanOrEqualTo: '$searchTerm\uf8ff')
          .orderBy('topic')
          .orderBy('created_at', descending: true)
          .get();

      return querySnapshot.docs
          .map((doc) => GeneratedContent.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to search content: $e');
    }
  }
}
