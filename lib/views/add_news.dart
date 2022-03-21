import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tugasminggu4/globals/datas.dart';
import 'package:tugasminggu4/globals/style.dart';
import 'package:tugasminggu4/models/news_model.dart';
import 'package:tugasminggu4/repository/news_repository.dart';
import 'package:tugasminggu4/widgets/input_field_widget.dart';

import 'home.dart';

class AddNews extends StatefulWidget {
  AddNews({Key? key}) : super(key: key);

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          color: Colors.pink,
          child: Center(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Center(
                  child: Text(
                    'Add New News',
                    style: kHeadingTextWhite,
                  ),
                ),
                SizedBox(height: 30.0),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 20.0),
                  width: double.infinity,
                  child: Form(
                    key: _globalKey,
                    child: Column(
                      children: [
                        RegularInputWidget(
                          controller: titleController,
                          valid: "Title must be filled",
                          label: "Title",
                          decorate: kInputDecoration.copyWith(
                            fillColor: Colors.pinkAccent,
                            hintText: "Enter news title",
                          ),
                        ),
                        RegularInputWidget(
                          controller: descriptionController,
                          valid: "Description must be filled",
                          label: "Description",
                          decorate: kInputDecoration.copyWith(
                            fillColor: Colors.pinkAccent,
                            hintText: "Describe the article",
                          ),
                        ),
                        RegularInputWidget(
                          controller: imageUrlController,
                          valid: "Image URL must be filled",
                          label: "Title Image URL",
                          decorate: kInputDecoration.copyWith(
                            fillColor: Colors.pinkAccent,
                            hintText: "https://images.unsplash.com/....",
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Content',
                              style: kTitleTextWhite,
                            ),
                            SizedBox(height: 5.0),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(7.0),
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                controller: contentController,
                                maxLines: 7,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Article input must be filled";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: kInputDecoration.copyWith(
                                  fillColor: Colors.pinkAccent,
                                  hintText: 'Enter News Article',
                                ),
                              ),
                            ),
                            SizedBox(height: 30.0),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        InkWell(
                          onTap: () {
                            if (_globalKey.currentState!.validate()) {
                              NewsRepository()
                                  .postForm(
                                title: titleController.text,
                                description: descriptionController.text,
                                imageUrl: imageUrlController.text,
                                content: contentController.text,
                                source: "User",
                              )
                                  .then((value) {
                                print(value);
                                setState(() {
                                  final userNews = NewsModel(
                                    title: value['title'],
                                    imageUrl: value['imageUrl'],
                                    description: value['description'],
                                    content: value['content'],
                                    source: value['source'],
                                    publishedAt: DateTime.now(),
                                  );

                                  listOfNews.insert(0, userNews);

                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) => Home()),
                                      (Route<dynamic> route) => false);
                                });
                              }).onError((error, stackTrace) {
                                print(error);
                                print(stackTrace);
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Center(
                              child: Text(
                                'Post this news',
                                style: kTitleTextWhite.copyWith(
                                  color: Colors.pink,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
