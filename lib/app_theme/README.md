# Educational App Color Palette

A comprehensive, professional color system designed specifically for educational applications targeting school and college students.

## 🎨 Color Philosophy

This color palette is built around principles of:
- **Trust & Professionalism**: Deep blues convey reliability and academic authority
- **Accessibility**: All colors meet WCAG AA contrast standards
- **Educational Context**: Semantic colors for grades, subjects, and progress
- **Student-Friendly**: Vibrant but not overwhelming, suitable for extended study sessions

## 🏗️ Color Structure

### Brand Colors
- **Primary**: `AppColors.brandPrimary` - Deep blue for main branding
- **Secondary**: `AppColors.brandSecondary` - Vibrant blue for interactions
- **Tertiary**: `AppColors.brandTertiary` - Light blue for subtle accents

### Semantic Colors
- **Success**: Green tones for completed assignments, correct answers
- **Warning**: Amber tones for deadlines, attention needed
- **Error**: Red tones for incorrect answers, failed submissions
- **Info**: Sky blue for tips and additional information

### Theme-Specific Colors
Each theme (light/dark) has its own set of:
- Background colors (primary, surface, variants)
- Text colors (primary, secondary, tertiary)
- Interactive element colors
- Border and divider colors

## 📚 Educational-Specific Colors

### Subject Colors
```dart
AppColors.subjectMath      // Red - Mathematics
AppColors.subjectScience   // Green - Science subjects
AppColors.subjectLanguage  // Purple - Language arts
AppColors.subjectHistory   // Amber - History/Social studies
AppColors.subjectArt       // Pink - Creative subjects
```

### Progress Colors
```dart
AppColors.progressBeginner     // Red - 0-40%
AppColors.progressIntermediate // Amber - 40-70%
AppColors.progressAdvanced     // Green - 70-90%
AppColors.progressExpert       // Blue - 90%+
```

### Grade Colors
```dart
AppColors.gradeA  // Green - Excellent
AppColors.gradeB  // Cyan - Good
AppColors.gradeC  // Amber - Average
AppColors.gradeD  // Red - Below average
```

## 🛠️ Usage Examples

### Basic Usage
```dart
// Using theme-aware colors
Container(
  color: Theme.of(context).colorScheme.surface,
  child: Text(
    'Hello Student!',
    style: TextStyle(
      color: Theme.of(context).colorScheme.onSurface,
    ),
  ),
)

// Using specific brand colors
Container(
  color: AppColors.brandPrimary,
  child: Text(
    'App Title',
    style: TextStyle(color: AppColors.darkTextPrimary),
  ),
)
```

### Educational Context Usage
```dart
// Subject-based color coding
Container(
  decoration: BoxDecoration(
    color: AppColors.subjectMath.withOpacity(0.1),
    border: Border.left(
      color: AppColors.subjectMath,
      width: 4,
    ),
  ),
  child: Text('Mathematics Assignment'),
)

// Progress indication
LinearProgressIndicator(
  value: 0.75,
  backgroundColor: AppColors.lightSurfaceVariant,
  valueColor: AlwaysStoppedAnimation(
    ColorUsageExamples.getProgressColor(75),
  ),
)

// Grade display
Container(
  padding: EdgeInsets.all(8),
  decoration: BoxDecoration(
    color: ColorUsageExamples.getGradeColor('A'),
    borderRadius: BorderRadius.circular(4),
  ),
  child: Text(
    'A',
    style: TextStyle(
      color: AppColors.lightSurface,
      fontWeight: FontWeight.bold,
    ),
  ),
)
```

### Using Helper Functions
```dart
// Get appropriate status color
Color statusColor = ColorUsageExamples.getStatusColor('completed');

// Get subject color
Color mathColor = ColorUsageExamples.getSubjectColor('mathematics');

// Theme-aware text color
Color textColor = context.primaryText; // Using extension

// Check contrast
bool goodContrast = ColorUsageExamples.hasGoodContrast(
  AppColors.lightTextPrimary,
  AppColors.lightSurface,
);
```

## 🎯 Best Practices

### Do's
- ✅ Use semantic colors for their intended purpose
- ✅ Leverage theme-aware colors for automatic dark/light mode support
- ✅ Use helper functions for consistent color application
- ✅ Test color combinations for accessibility
- ✅ Use subject colors consistently across the app

### Don'ts
- ❌ Don't use error colors for non-error states
- ❌ Don't hardcode light/dark colors - use theme-aware alternatives
- ❌ Don't use too many different colors in one interface
- ❌ Don't ignore contrast requirements
- ❌ Don't use deprecated color properties

## 🔧 Customization

To modify colors for your specific needs:

1. **Brand Colors**: Update the brand color constants in `AppColors`
2. **Semantic Colors**: Adjust semantic colors while maintaining their meaning
3. **Theme Colors**: Modify light/dark theme colors as needed
4. **Educational Colors**: Add or modify subject/grade colors for your curriculum

## 📱 Implementation

The color system is automatically applied when you use `AppTheme.lightTheme` or `AppTheme.darkTheme` in your MaterialApp:

```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system, // Follows system preference
  home: YourHomePage(),
)
```

## 🎨 Color Palette Preview

### Light Theme
- Background: Very light gray (#FAFAFA)
- Surface: Pure white (#FFFFFF)
- Primary: Deep blue (#1E3A8A)
- Secondary: Vibrant blue (#3B82F6)
- Text: Dark gray (#111827)

### Dark Theme
- Background: Very dark blue (#0F172A)
- Surface: Dark blue-gray (#1E293B)
- Primary: Light blue (#60A5FA)
- Secondary: Blue (#3B82F6)
- Text: Very light gray (#F8FAFC)

This color system provides a solid foundation for building professional, accessible, and educationally-focused user interfaces.
