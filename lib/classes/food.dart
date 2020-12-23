class Food {
  Food({
    this.id,
    this.name,
    this.description,
    this.img,
    this.price,
    this.categoryId,
    this.categoryName,
    this.certificate,
  });

  final int id;
  final int categoryId;
  final String name;
  final int price;
  final String categoryName;
  final String description;
  final String img;
  final bool certificate;
}
