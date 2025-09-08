import 'package:edu_writer_ai/app_theme/colors.dart';
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import 'main_navigation.dart';

// Content Type Model
class ContentType {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String route;

  const ContentType({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
  });
}

// Content Types Data
final List<ContentType> _contentTypes = [
  const ContentType(
    title: 'Essay',
    description: 'Academic and creative essays',
    icon: Icons.article_outlined,
    color: AppColors.literature,
    route: '/essay',
  ),
  const ContentType(
    title: 'Paragraph',
    description: 'Well-structured paragraphs',
    icon: Icons.format_align_left,
    color: AppColors.secondary,
    route: '/paragraph',
  ),
  const ContentType(
    title: 'Letter',
    description: 'Formal and informal letters',
    icon: Icons.email_outlined,
    color: AppColors.languages,
    route: '/letter',
  ),
  const ContentType(
    title: 'Email',
    description: 'Professional email writing',
    icon: Icons.mark_email_unread_outlined,
    color: AppColors.primary,
    route: '/email',
  ),
  const ContentType(
    title: 'Dialog',
    description: 'Conversational dialogues',
    icon: Icons.chat_bubble_outline,
    color: AppColors.arts,
    route: '/dialog',
  ),
  const ContentType(
    title: 'Application',
    description: 'Job and academic applications',
    icon: Icons.description_outlined,
    color: AppColors.history,
    route: '/application',
  ),
  const ContentType(
    title: 'Story',
    description: 'Creative story completion',
    icon: Icons.auto_stories_outlined,
    color: AppColors.mathematics,
    route: '/story',
  ),
  const ContentType(
    title: 'Report',
    description: 'Research and project reports',
    icon: Icons.assessment_outlined,
    color: AppColors.science,
    route: '/report',
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.transparent),
          title: const Text(
            "Edu Writer AI",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: AppColors.background,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
      ),
      drawer: const AppDrawer(),
      body: const HomePageContent(),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome Section
          _buildWelcomeSection(),
          const SizedBox(height: 24),

          // Content Categories Grid
          _buildContentGrid(context),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.primaryGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create Academic Content',
            style: TextStyle(
              color: AppColors.textOnDark,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Generate high-quality academic content with AI assistance',
            style: TextStyle(
              color: AppColors.textOnDark.withOpacity(0.9),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentGrid(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Choose Content Type',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        // Content Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemCount: _contentTypes.length,
          itemBuilder: (context, index) {
            final contentType = _contentTypes[index];
            return _buildContentCard(context, contentType);
          },
        ),
      ],
    );
  }

  Widget _buildContentCard(BuildContext context, ContentType contentType) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(16),
      elevation: 4, // shadow
      child: InkWell(
        hoverColor: AppColors.primary.withOpacity(0.1),
        splashColor: AppColors.primary.withOpacity(0.1),
        onTap: () {
          // Navigate to content generation page
          _navigateToContentGeneration(context, contentType);
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon container
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: contentType.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    contentType.icon,
                    size: 32,
                    color: contentType.color,
                  ),
                ),
                const SizedBox(height: 12),

                // Title
                Text(
                  contentType.title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // Description
                Text(
                  contentType.description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToContentGeneration(
      BuildContext context, ContentType contentType) {
    // Navigate to main navigation with selected category
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainNavigation(
          initialCategory: contentType.title,
        ),
      ),
    );
  }
}
