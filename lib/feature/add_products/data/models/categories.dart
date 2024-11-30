class Category {
  final String name;
  final List<String> subcategories;

  Category({required this.name, required this.subcategories});
}

final List<Category> categories = [
  Category(name: 'Backpacks', subcategories: ['School', 'Hiking', 'Travel']),
  Category(name: 'Handbags', subcategories: ['Tote', 'Clutch', 'Sling']),
  Category(name: 'Duffel Bags', subcategories: ['Gym', 'Travel', 'Weekender']),
  Category(name: 'Laptop Bags', subcategories: ['Messenger', 'Sleeve', 'Rolling']),
];
