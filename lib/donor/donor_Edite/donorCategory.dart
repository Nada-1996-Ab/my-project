class donorCategory {
  donorCategory({
    this.cateId = 0,
    this.name = '',
    this.imagePath = '',
  });
  int cateId;
  String name;
  String imagePath;

  static List<donorCategory> categoryList = <donorCategory>[
    donorCategory(
      cateId: 2,
      imagePath: 'assets/icons/furniture.jpg',
      name: 'Furniture',
    ),
    donorCategory(
      cateId: 1,
      imagePath: 'assets/icons/book1.png',
      name: 'Books',
    ),


    donorCategory(
      cateId: 4,
      imagePath: 'assets/icons/clothes3.png',
      name: 'Clothes',
    ),

    donorCategory(
      cateId: 5,
      imagePath: 'assets/icons/food1.jpg',
      name: 'FoodBasket',
    ),
    donorCategory(
      cateId: 3,
      imagePath: 'assets/icons/devices1.jpg',
      name: 'Electronic Devices',
    ),

    donorCategory(
      cateId: 6,
      imagePath: 'assets/icons/others.png',
      name: 'Others',
    ),

  ];
}
