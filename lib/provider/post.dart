import 'package:chat_app/models/postModel.dart';
import 'package:chat_app/services/post.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier{
  PostServices _productServices = PostServices();
  List<postModel> posts = [];
  List<postModel> productsSearched = [];


  PostProvider.initialize(){
    loadPosts();
  }

  loadPosts()async{
    posts = await _productServices.getPosts();
    notifyListeners();
  }

  Future search({String productName})async{
    productsSearched = await _productServices.searchPosts(postTitle: productName);
    notifyListeners();
  }

}