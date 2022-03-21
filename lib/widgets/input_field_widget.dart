import 'package:flutter/material.dart';
import 'package:tugasminggu4/globals/style.dart';

class RegularInputWidget extends StatelessWidget {
  const RegularInputWidget({
    Key? key,
    required TextEditingController controller,
    required this.valid,
    required this.label,
    required this.decorate,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final String label;
  final String valid;

  final InputDecoration decorate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toString(),
          style: kTitleTextWhite,
        ),
        SizedBox(height: 5.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(7.0),
          child: TextFormField(
            style: TextStyle(
              color: Colors.white,
            ),
            controller: _controller,
            validator: (value) => value!.isEmpty ? valid : null,
            decoration: decorate,
          ),
        ),
        SizedBox(height: 30.0),
      ],
    );
  }
}
