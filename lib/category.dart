class needyCategory {
  needyCategory({
    this.cateId = 0,
    this.name = '',
    this.imagePath = '',
  });
  int cateId;
  String name;
  String imagePath;


  static List<needyCategory> categoryList = <needyCategory>[
    needyCategory(
      cateId: 2,
      imagePath: 'assets/icons/furniture.jpg',
      name: 'Furniture',
    ),
    needyCategory(
      cateId: 1,
      imagePath: 'assets/icons/book1.png',
      name: 'Books',
    ),


    needyCategory(
      cateId: 4,
      imagePath: 'assets/icons/clothes3.png',
      name: 'Clothes',
    ),

    needyCategory(
      cateId: 5,
      imagePath: 'assets/icons/food1.jpg',
      name: 'FoodBasket',
    ),
    needyCategory(
      cateId: 3,
      imagePath: 'assets/icons/devices1.jpg',
      name: 'Electronic Devices',
    ),

    needyCategory(
      cateId: 6,
      imagePath: 'assets/icons/others.png',
      name: 'Others',
    ),

  ];
}
