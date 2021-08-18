import 'dart:io';
import 'package:chat_app/api/database.dart';
import 'package:chat_app/models/Image_model.dart';
import 'package:chat_app/models/postImage.dart';
import 'package:chat_app/models/postModel.dart';
import 'package:chat_app/profile/profileScreen.dart';
import 'package:chat_app/provider/user.dart';
import 'package:chat_app/widgets/globalData.dart';
import 'package:chat_app/widgets/spaces.dart';
import 'package:chat_app/widgets/values.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class Addpost extends StatefulWidget {
  final  postModel postData;
  final String screenTitle;
  final  int cateId;

  Addpost(this.postData, this.screenTitle,this.cateId);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddpostState(this.postData, this.screenTitle,this.cateId);
  }
}

class _AddpostState extends State<Addpost> {
  postModel postData;
  String screenTitle;
  int cateId;
  TextEditingController controller = new TextEditingController();
  String userId = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  String date;
  String time;
  TextEditingController postTitle = new TextEditingController();
  TextEditingController postType = new TextEditingController();
  TextEditingController postDesc = new TextEditingController();
  bool postState=false;
  CategoryType categoryType = CategoryType.requested;
  String selectItemCondition = StringConst.postType;
  List<String> _itemCondition = [
    StringConst.New,
    StringConst.used,
  ];
  List<Object> images = List<Object>();

  List<postImage> imagesList = List();
  List<File> imagesList2 = List();
  Future<File> _imageFile;
  Future<void> submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    } else {
      if (imagesList2.length == 0 || imagesList2 == null) {
        Fluttertoast.showToast(
          msg: "The image for post is not selected",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR, // also possible "TOP" and "CENTER"
          backgroundColor:Colors.white,
          textColor: Colors.black,
        );
      } else
        _formKey.currentState.save();
      save(imagesList2[0]);
    }
  }
  _AddpostState(this.postData, this.screenTitle,this.cateId,);
  UserProvider userProvider;
  void dispose() {
    super.dispose();
  }
  void initState() {
    super.initState();
    setState(() {
      images.add("Add Image");
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
     userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: AppColors.whiteShade2,
        body: Container(
          child: Column(
            children: <Widget>[
              getAppBarUI(),
              Expanded(
                child: Container(
                  color: AppColors.whiteShade2,
                  child: Form(
                      autovalidate: true,
                      key: _formKey,
                      child: ListView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25,
                        ),
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColors.grey.withOpacity(0.2),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16, bottom: 16),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            PanelTitle(
                                              title: StringConst.addTitel,
                                              isRequired: true,
                                            ),
                                            TextFormField(
                                              maxLines: null,
                                              maxLengthEnforced: false,
                                              keyboardType: TextInputType.multiline,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                              controller: postTitle,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                              ),
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return ' Titel of post is required';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) =>
                                              postData.postTitle = value,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColors.grey.withOpacity(0.2),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16, bottom: 16),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 1, bottom: 1),
                                      child: PanelTitle(
                                        title: StringConst.postType,
                                        isRequired: true,
                                      ),
                                    ),
                                  ),
                                  SpaceW12(),
                                  Column(
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 1),
                                              child: Container(
                                                child: RadioGroup<String>.builder(
                                                  groupValue: selectItemCondition,
                                                  direction: Axis.horizontal,
                                                  horizontalAlignment:
                                                  MainAxisAlignment.start,
                                                  onChanged: (value) => setState(() {
                                                    selectItemCondition = value;
                                                    postData.postType=value;
                                                  }),
                                                  items: _itemCondition,
                                                  itemBuilder: (item) => RadioButtonBuilder(
                                                    item,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColors.grey.withOpacity(0.2),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16, bottom: 16),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            PanelTitle(
                                              title: StringConst.DESCRIPTION,
                                              isRequired: true,
                                            ),
                                            TextFormField(
                                              maxLines: null,
                                              maxLengthEnforced: false,

                                              keyboardType: TextInputType.text,
                                              style: TextStyle(
                                                fontSize: 16,
                                              ),
                                              controller: postDesc,
                                              textCapitalization: TextCapitalization.words,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                              ),
                                              validator: (String value) {
                                                if (value.isEmpty) {
                                                  return ' Description post is required';
                                                }
                                                return null;
                                              },

                                              onSaved: (value) =>
                                              postData.postDesc = value ,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SpaceH8(),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 16, left: 16, right: 16, bottom: 16),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: AppColors.grey.withOpacity(0.2),
                                    offset: const Offset(1.1, 1.1),
                                    blurRadius: 10.0),
                              ],
                            ),

                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  PanelTitle(
                                    title: StringConst.postImage,
                                    isRequired: true,
                                  ),
                                  buildGridView(),
                                ]),

                          ),
                          SpaceH20(),
                          Padding(
                            padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.height * 0.08,
                              right: MediaQuery.of(context).size.height * 0.08,
                              bottom: MediaQuery.of(context).size.height * 0.03,
                            ),
                            child: Container(
                              width: 220,
                              height: 50,
                              child: FlatButton(
                                color: AppColors.primary,
                                shape: StadiumBorder(),
                                child: Center(
                                  child: Text(
                                    StringConst.save,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                onPressed: () async {
                                  await submit();
                                },
                              ),
                            ),
                          ),
                        ],
                      ))
                ),
              )
            ],
          ),
        ));
  }
  Widget getAppBarUI() {
    return Container(
        child: AppBar(
      backgroundColor: AppColors.white,
      iconTheme: IconThemeData(
        color: AppColors.black,
      ),
      centerTitle: true,
      title: Text(
        screenTitle,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      elevation: 0.0,
    ));
  }
  Widget buildGridView() {

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 1,
      childAspectRatio: 1,
      children: List.generate(images.length, (index) {
        if (images[index] is ImageUploadModel) {
          ImageUploadModel uploadModel = images[index];
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Stack(
              children: <Widget>[
                Image.file(
                  uploadModel.imageFile,
                  width: 300,
                  height: 300,
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: InkWell(
                    child: Icon(
                      Icons.remove_circle,
                      size: 20,
                      color: Colors.red,
                    ),
                    onTap: () {
                      setState(() {
                        images.replaceRange(index, index + 1, ['Add Image']);
                        imagesList.removeAt(index);
                        imagesList2.remove(uploadModel.imageFile);
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card(
            child: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _onAddImageClick(index);
              },
            ),
          );
        }
      }),
    );
  }
  Future<String> save(var file) async {

    String fileName = basename(file.path);
    StorageReference ref =
    FirebaseStorage.instance.ref().child('posts/$fileName');
    StorageUploadTask uploadTask = ref.putFile(file);
    var dowurl = await (await uploadTask.onComplete).ref.getDownloadURL();
    String url = dowurl.toString();
    if (uploadTask.isComplete) {
      postData.postImage=url;
      postData.postState=false;
      postData.donorId=userProvider.userModel.id;
      postData.postDate=getDate();
      postData.cateId=cateId;
      print(postData.postImage);
      await DatabaseService().Addpost(postData);
    }
    return url;
  }
  Future _onAddImageClick(int index) async {
    setState(() {
      // ignore: deprecated_member_use
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);

      _imageFile!=null? getFileImage(index):getFileImageEmpty();
    });
  }
  void goBack(BuildContext context) {
    Navigator.pop(context, true);
  }
  void getFileImageEmpty( ) async {}
  void getFileImage(int index) async {

    _imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = true;
        imageUpload.uploading = true;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
        imagesList.add(new postImage(
          imageId: "",
          prodId: "",
          imageName: basename(file.path),
        ));
        imagesList2.add(file);
      });
    });
  }
}

Future<List<String>> uploadFiles(List imagesList2) async {
  await Future.wait(imagesList2.map((imagesList2) => upload(imagesList2)));
}

Future upload(File file) async {
  String fileName = basename(file.path);
  StorageReference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('posts/$fileName');
  StorageUploadTask uploadTask = firebaseStorageRef.putFile(file);
  uploadTask.onComplete.then((value) => print(value.uploadSessionUri));
// var url = await firebaseStorageRef.getDownloadURL() as String;
}
