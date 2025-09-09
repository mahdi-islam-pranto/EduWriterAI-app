import 'package:cloud_firestore/cloud_firestore.dart';

class GeneratedContent {
  final String id;
  final String topic;
  final String category;
  final String subject;
  final String grade;
  final String content;
  final String length;
  final int wordCount;
  final String tone;
  final String additionalInfo;
  final DateTime createdAt;

  GeneratedContent({
    required this.id,
    required this.topic,
    required this.category,
    required this.subject,
    required this.grade,
    required this.content,
    required this.length,
    required this.wordCount,
    required this.tone,
    required this.additionalInfo,
    required this.createdAt,
  });

  // Create GeneratedContent from Firestore document
  factory GeneratedContent.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return GeneratedContent(
      id: doc.id,
      topic: data['topic'] ?? '',
      category: data['category'] ?? '',
      subject: data['subject'] ?? '',
      grade: data['grade'] ?? '',
      content: data['content'] ?? '',
      length: data['length'] ?? '',
      wordCount: data['word_count'] ?? 0,
      tone: data['tone'] ?? '',
      additionalInfo: data['additional_info'] ?? '',
      createdAt: (data['created_at'] as Timestamp).toDate(),
    );
  }

  // Convert GeneratedContent to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'topic': topic,
      'category': category,
      'subject': subject,
      'grade': grade,
      'content': content,
      'length': length,
      'word_count': wordCount,
      'tone': tone,
      'additional_info': additionalInfo,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }

  // Create GeneratedContent from API request data and generated content
  factory GeneratedContent.fromApiData({
    required Map<String, dynamic> requestData,
    required String generatedContent,
  }) {
    return GeneratedContent(
      id: '', // Will be set by Firestore
      topic: requestData['topic'] ?? '',
      category: requestData['category'] ?? '',
      subject: requestData['subject'] ?? '',
      grade: requestData['grade'] ?? '',
      content: generatedContent,
      length: requestData['length'] ?? '',
      wordCount: requestData['word_count'] ?? 0,
      tone: requestData['tone'] ?? '',
      additionalInfo: requestData['additional_info'] ?? '',
      createdAt: DateTime.now(),
    );
  }

  // Get formatted date string
  String get formattedDate {
    return '${createdAt.day}/${createdAt.month}/${createdAt.year}';
  }

  // Get formatted time string
  String get formattedTime {
    final hour = createdAt.hour.toString().padLeft(2, '0');
    final minute = createdAt.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  // Get formatted date and time string
  String get formattedDateTime {
    return '$formattedDate at $formattedTime';
  }

  // Get title for display (topic + category)
  String get displayTitle {
    return topic.isNotEmpty ? topic : category.toUpperCase();
  }

  // Get subtitle for display
  String get displaySubtitle {
    return '$category • $subject • Grade $grade';
  }

  // Get content preview (first 100 characters)
  String get contentPreview {
    if (content.length <= 100) return content;
    return '${content.substring(0, 100)}...';
  }
}
