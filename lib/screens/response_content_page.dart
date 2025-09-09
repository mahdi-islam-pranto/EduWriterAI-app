import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';
import '../app_theme/colors.dart';

class GeneratedContentPage extends StatefulWidget {
  final Map<String, dynamic> requestData;

  const GeneratedContentPage({
    super.key,
    required this.requestData,
  });

  @override
  State<GeneratedContentPage> createState() => _GeneratedContentPageState();
}

class _GeneratedContentPageState extends State<GeneratedContentPage>
    with TickerProviderStateMixin {
  bool _isLoading = true;
  String? _generatedContent;
  String? _errorMessage;
  Map<String, dynamic>? _responseData;
  String? _lastDownloadedFilePath;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Setup fade-in animation
    _setupAnimations();
    // Make API call to generate content
    _generateContent();
  }

// Setup fade-in animation
  void _setupAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    // Dispose animation controller for performance
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _generateContent() async {
    try {
      // Make API call to generate content
      final response = await http.post(
        Uri.parse('http://114.130.69.239:7007/generate'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(widget.requestData),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        if (responseData['status'] == 'success') {
          setState(() {
            _responseData = responseData['AI_Response'] as Map<String, dynamic>;
            _generatedContent = _responseData!['generated_content'] as String;
            _isLoading = false;
          });
          _animationController.forward();
        } else {
          throw Exception('API returned error status');
        }
      } else {
        throw Exception(
            'HTTP ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            'Failed to generate content. Please try again.\nError: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: const Text(
          'Generated Content',
          style: TextStyle(
            color: AppColors.textOnDark,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.textOnDark,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        // if generated content is not null, show copy and share buttons at app bar
        actions: _generatedContent != null
            ? [
                IconButton(
                  icon: const Icon(
                    Icons.copy,
                    color: AppColors.textOnDark,
                  ),
                  onPressed: _copyToClipboard,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.picture_as_pdf,
                    color: AppColors.textOnDark,
                  ),
                  onPressed: _downloadAsPDF,
                ),
              ]
            : null,
      ),
      body: _isLoading
          ? _buildLoadingView()
          : _errorMessage != null
              ? _buildErrorView()
              : _buildContentView(),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated loading indicator
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                strokeWidth: 3,
              ),
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Generating Content...',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),

          Text(
            'AI is crafting your ${widget.requestData['category']} content',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Loading tips
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(
                  Icons.lightbulb_outline,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Did you know?',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Our AI considers your grade level, subject, and tone to create perfectly tailored academic content.',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(40),
              ),
              child: const Icon(
                Icons.error_outline,
                color: AppColors.error,
                size: 40,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Generation Failed',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _errorMessage!,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _errorMessage = null;
                });
                _generateContent();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.textOnDark,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContentView() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Content Info Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.check_circle,
                      color: AppColors.success,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Content Generated Successfully',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_responseData!['category']} • ${_responseData!['word_count']} words • ${_responseData!['tone']} tone',
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Generated Content Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Generated Content',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SelectableText(
                    _generatedContent!,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _copyToClipboard,
                        icon: const Icon(Icons.copy, size: 18),
                        label: const Text('Copy'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: AppColors.textOnDark,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _downloadAsPDF,
                        icon: const Icon(Icons.picture_as_pdf, size: 18),
                        label: const Text('Download PDF'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.textOnDark,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Show Open PDF button if a PDF has been downloaded
                if (_lastDownloadedFilePath != null) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _openPDF(_lastDownloadedFilePath!),
                      icon: const Icon(Icons.open_in_new, size: 18),
                      label: const Text('Open PDF'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.success,
                        foregroundColor: AppColors.textOnDark,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

// Copy to clipboard
  void _copyToClipboard() {
    if (_generatedContent != null) {
      Clipboard.setData(ClipboardData(text: _generatedContent!));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Content copied to clipboard'),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _downloadAsPDF() async {
    if (_generatedContent == null) return;

    try {
      // Request storage permission
      // request permission
      await Permission.storage.request();
      // Check if permission is granted
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
        if (!status.isGranted) {
          _showErrorSnackBar('Storage permission is required to download PDF');
          return;
        }
      }

      // Create PDF document
      final pdf = pw.Document();

      // Add page with content
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(32),
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header
                pw.Container(
                  padding: const pw.EdgeInsets.only(bottom: 20),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      bottom: pw.BorderSide(
                        color: PdfColors.grey400,
                        width: 1,
                      ),
                    ),
                  ),
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        'Generated Content',
                        style: pw.TextStyle(
                          fontSize: 24,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        '${_responseData!['category']} • ${_responseData!['word_count']} words • ${_responseData!['tone']} tone',
                        style: pw.TextStyle(
                          fontSize: 12,
                          color: PdfColors.grey600,
                        ),
                      ),
                      pw.SizedBox(height: 8),
                      pw.Text(
                        'Generated by Edu Writer AI',
                        style: pw.TextStyle(
                          fontSize: 10,
                          color: PdfColors.grey500,
                        ),
                      ),
                    ],
                  ),
                ),
                pw.SizedBox(height: 24),

                // Generated Content Title in center
                pw.Center(
                  child: pw.Text(
                    widget.requestData['topic'].toString(),
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

                // Content
                pw.Expanded(
                  child: pw.Text(
                    _generatedContent!,
                    style: pw.TextStyle(
                      fontSize: 12,
                      lineSpacing: 1.5,
                    ),
                    textAlign: pw.TextAlign.justify,
                  ),
                ),

                // Footer
                pw.Container(
                  padding: const pw.EdgeInsets.only(top: 20),
                  decoration: const pw.BoxDecoration(
                    border: pw.Border(
                      top: pw.BorderSide(
                        color: PdfColors.grey400,
                        width: 1,
                      ),
                    ),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(
                        'Topic: ${widget.requestData['topic']}',
                        style: pw.TextStyle(
                          fontSize: 10,
                          color: PdfColors.grey600,
                        ),
                      ),
                      pw.Text(
                        'Subject: ${widget.requestData['subject']} | Grade: ${widget.requestData['grade']}',
                        style: pw.TextStyle(
                          fontSize: 10,
                          color: PdfColors.grey600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      );

      // Get download directory
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory != null) {
        // Create filename with timestamp
        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final filename =
            'EduWriterAI_${_responseData!['category']}_$timestamp.pdf';
        final file = File('${directory.path}/$filename');

        // Write PDF to file
        await file.writeAsBytes(await pdf.save());

        // Store the file path for opening
        setState(() {
          _lastDownloadedFilePath = file.path;
        });

        // Show success message
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('PDF downloaded: $filename'),
              backgroundColor: AppColors.success,
              behavior: SnackBarBehavior.floating,
              action: SnackBarAction(
                label: 'Open',
                textColor: AppColors.textOnDark,
                onPressed: () => _openPDF(file.path),
              ),
            ),
          );
        }
      } else {
        throw Exception('Could not access storage directory');
      }
    } catch (e) {
      _showErrorSnackBar('Failed to download PDF: ${e.toString()}');
    }
  }

  Future<void> _openPDF(String filePath) async {
    try {
      final result = await OpenFile.open(filePath);

      if (result.type != ResultType.done) {
        // If opening failed, show error message
        String errorMessage;
        switch (result.type) {
          case ResultType.noAppToOpen:
            errorMessage =
                'No app found to open PDF files. Please install a PDF viewer.';
            break;
          case ResultType.permissionDenied:
            errorMessage = 'Permission denied to open the file.';
            break;
          case ResultType.fileNotFound:
            errorMessage =
                'PDF file not found. It may have been moved or deleted.';
            break;
          default:
            errorMessage = 'Failed to open PDF: ${result.message}';
        }

        if (mounted) {
          _showErrorSnackBar(errorMessage);
        }
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Error opening PDF: ${e.toString()}');
      }
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
}
