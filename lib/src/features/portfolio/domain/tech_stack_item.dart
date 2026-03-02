import 'package:dart_mappable/dart_mappable.dart';

part 'tech_stack_item.mapper.dart';

/// A single technology in the portfolio tech stack.
@MappableClass()
class TechStackItem with TechStackItemMappable {
  final String id;
  final String name;
  final String category;
  final String description;
  final String iconName;
  final int proficiencyLevel;
  final int yearsOfExperience;
  final String url;
  final int sortOrder;
  final String collectionId;

  const TechStackItem({
    required this.id,
    required this.name,
    this.category = '',
    this.description = '',
    this.iconName = '',
    this.proficiencyLevel = 0,
    this.yearsOfExperience = 0,
    this.url = '',
    this.sortOrder = 0,
    this.collectionId = '',
  });

  static const collectionName = 'techStack';
}
