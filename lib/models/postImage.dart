import 'dart:io';

class postImage {
  String imageId;
 String imageName;
 String prodId;
  postImage({
    this.imageId,
    this.prodId,
    this.imageName,

  });

  postImage.fromJson(Map<String, dynamic> parsedJSON)
      : imageId = parsedJSON['imageId'],
        imageName = parsedJSON['imageName'],
        prodId = parsedJSON['prodId'];
}
