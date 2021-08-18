import 'package:chat_app/helpers/common.dart';
import 'package:chat_app/helpers/style.dart';
import 'package:chat_app/models/postModel.dart';
import 'package:chat_app/screens/product_details.dart';
import 'package:chat_app/widgets/values.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import 'loading.dart';

class ProductCard extends StatelessWidget {
  final postModel product;

  const ProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          changeScreen(context, ProductDetails(product: product,));
        },
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset(-2, -1),
                    blurRadius: 5),
              ]),
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Loading(),
                          )),
                      Center(
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
//                          image: product.picture,
                          fit: BoxFit.cover,
                          height: 140,
                          width: 120,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              RichText(
                text: TextSpan(children: [

                ], style: TextStyle(color: AppColors.primaryTwo)),
              )
            ],
          ),
        ),
      ),
    );
  }


}
