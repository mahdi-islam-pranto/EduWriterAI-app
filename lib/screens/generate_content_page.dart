import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../app_theme/colors.dart';

class GenerateContentPage extends StatefulWidget {
  const GenerateContentPage({super.key});

  @override
  State<GenerateContentPage> createState() => _GenerateContentPageState();
}

class _GenerateContentPageState extends State<GenerateContentPage> {
  final _formKey = GlobalKey<FormState>();
  final _topicController = TextEditingController();
  final _additionalInfoController = TextEditingController();
  final _wordCountController = TextEditingController();

  // Dropdown values
  String? _selectedLength;
  String? _selectedTone;
  String? _selectedCategory;
  String? _selectedSubject;
  String? _selectedGrade;

  // Dropdown options
  final List<String> _lengthOptions = ['short', 'medium', 'long'];
  final List<String> _toneOptions = [
    'academic',
    'formal',
    'informal',
    'creative',
    'persuasive'
  ];
  final List<String> _categoryOptions = [
    'paragraph',
    'composition',
    'essay',
    'letter',
    'email',
    'dialog',
    'application',
    'completing story'
  ];
  final List<String> _subjectOptions = [
    'English',
    'Mathematics',
    'Science',
    'History',
    'Geography',
    'Literature',
    'Physics',
    'Chemistry',
    'Biology'
  ];
  final List<String> _gradeOptions = ['6', '7', '8', '9', '10', '11', '12'];

  bool _isGenerating = false;

  @override
  void dispose() {
    _topicController.dispose();
    _additionalInfoController.dispose();
    _wordCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          // Container(
          //   width: double.infinity,
          //   padding: const EdgeInsets.all(20),
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: AppColors.primaryGradient,
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //     ),
          //     borderRadius: BorderRadius.circular(16),
          //     boxShadow: [
          //       BoxShadow(
          //         color: AppColors.primary.withOpacity(0.3),
          //         blurRadius: 10,
          //         offset: const Offset(0, 4),
          //       ),
          //     ],
          //   ),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       const Text(
          //         'Generate Content',
          //         style: TextStyle(
          //           color: AppColors.textOnDark,
          //           fontSize: 24,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //       const SizedBox(height: 8),
          //       Text(
          //         'Create amazing academic content with AI assistance',
          //         style: TextStyle(
          //           color: AppColors.textOnDark.withOpacity(0.9),
          //           fontSize: 16,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(height: 24),

          // Form Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Provide Content Details',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Category Dropdown
                  _buildDropdownField(
                    label: 'Category *',
                    value: _selectedCategory,
                    items: _categoryOptions,
                    onChanged: (value) =>
                        setState(() => _selectedCategory = value),
                    hint: 'Select content category',
                  ),
                  const SizedBox(height: 16),

                  // Subject Dropdown
                  _buildDropdownField(
                    label: 'Subject *',
                    value: _selectedSubject,
                    items: _subjectOptions,
                    onChanged: (value) =>
                        setState(() => _selectedSubject = value),
                    hint: 'Select subject',
                  ),
                  const SizedBox(height: 16),

                  // Grade Dropdown
                  _buildDropdownField(
                    label: 'Grade *',
                    value: _selectedGrade,
                    items: _gradeOptions,
                    onChanged: (value) =>
                        setState(() => _selectedGrade = value),
                    hint: 'Select grade level',
                  ),
                  const SizedBox(height: 16),

                  // Topic Text Field
                  _buildTextField(
                    controller: _topicController,
                    label: 'Topic *',
                    hint: 'Enter the topic for your content',
                    maxLines: 2,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a topic';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Length Dropdown
                  _buildDropdownField(
                    label: 'Length *',
                    value: _selectedLength,
                    items: _lengthOptions,
                    onChanged: (value) =>
                        setState(() => _selectedLength = value),
                    hint: 'Select content length',
                  ),
                  const SizedBox(height: 16),

                  // Word Count Field
                  _buildTextField(
                    controller: _wordCountController,
                    label: 'Word Count',
                    hint: 'Enter approximate word count (optional)',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                  const SizedBox(height: 16),

                  // Tone Dropdown
                  _buildDropdownField(
                    label: 'Tone',
                    value: _selectedTone,
                    items: _toneOptions,
                    onChanged: (value) => setState(() => _selectedTone = value),
                    hint: 'Select tone (optional)',
                  ),
                  const SizedBox(height: 16),

                  // Additional Info Text Field
                  _buildTextField(
                    controller: _additionalInfoController,
                    label: 'Additional Information',
                    hint: 'Any additional instructions or context (optional)',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 32),

                  // Generate Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _isGenerating ? null : _generateContent,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.textOnDark,
                        elevation: 4,
                        shadowColor: AppColors.primary.withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isGenerating
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.textOnDark,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                const Text(
                                  'Generating...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.auto_awesome,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Generate Content',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.textSecondary.withOpacity(0.7),
              fontSize: 14,
            ),
            filled: true,
            fillColor: AppColors.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.border.withOpacity(0.3),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.border.withOpacity(0.3),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item.toUpperCase(),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
          validator: label.contains('*')
              ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select ${label.replaceAll('*', '').trim()}';
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.textSecondary.withOpacity(0.7),
              fontSize: 14,
            ),
            filled: true,
            fillColor: AppColors.surfaceVariant,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.border.withOpacity(0.3),
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: AppColors.border.withOpacity(0.3),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Future<void> _generateContent() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Check required fields
    if (_selectedCategory == null ||
        _selectedSubject == null ||
        _selectedGrade == null ||
        _selectedLength == null) {
      _showErrorSnackBar('Please fill in all required fields');
      return;
    }

    setState(() {
      _isGenerating = true;
    });

    try {
      // Prepare API body
      final apiBody = {
        "length": _selectedLength!,
        "word_count": _wordCountController.text.isNotEmpty
            ? int.tryParse(_wordCountController.text) ?? 300
            : 300,
        "tone": _selectedTone ?? "academic",
        "category": _selectedCategory!,
        "subject": _selectedSubject!,
        "grade": _selectedGrade!,
        "topic": _topicController.text.trim(),
        "additional_info": _additionalInfoController.text.trim(),
      };

      // TODO: Replace this with actual API call
      print('API Body: $apiBody');

      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Show success message
      _showSuccessSnackBar('Content generated successfully!');

      // TODO: Navigate to result page or show generated content
    } catch (e) {
      _showErrorSnackBar('Failed to generate content. Please try again.');
    } finally {
      setState(() {
        _isGenerating = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
