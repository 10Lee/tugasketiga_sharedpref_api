import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tugasminggu4/models/category_model.dart';

class NewsCategory extends StatelessWidget {
  NewsCategory({Key? key}) : super(key: key);

  List<CategoryModel> categories = [
    CategoryModel(
        name: 'Technology',
        imageUrl:
            'https://images.unsplash.com/photo-1593508512255-86ab42a8e620?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8dnJ8ZW58MHx8MHx8&auto=format&fit=crop&w=900&q=60'),
    CategoryModel(
        name: 'Business',
        imageUrl:
            'https://images.unsplash.com/photo-1569180880150-df4eed93c90b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8bWFya2V0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60'),
    CategoryModel(
        name: 'Sport',
        imageUrl:
            'https://images.unsplash.com/photo-1517649763962-0c623066013b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHNwb3J0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60'),
    CategoryModel(
        name: 'Fashion',
        imageUrl:
            'https://images.unsplash.com/photo-1644982647708-0b2cc3d910b7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxzZWFyY2h8MXx8ZmFzaGlvbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60'),
  ];

  Widget _buildCategories(BuildContext context, category) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 150.0,
      height: 200.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1,
          color: Colors.grey.shade200,
        ),
      ),
      child: Stack(
        children: [
          Container(
            width: 150.0,
            height: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                category.imageUrl.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 150.0,
            height: 200.0,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(.9),
                  Colors.transparent,
                ],
              ),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                category.name.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            "Categories",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24.0,
            ),
          ),
        ),
        Container(
          height: 200.0,
          // color: Colors.blue,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return _buildCategories(context, category);
            },
          ),
        ),
      ],
    );
  }
}
