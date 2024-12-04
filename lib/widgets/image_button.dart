

import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {

  const ImageButton({required this.imagePath, required this.label,
    required this.onPressed, super.key});

  final String imagePath;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //Will leave the container here for now for if we decide we want to add
          // decoration
          Container(
            width: 82,
            height: 82,
            child: Image.asset(imagePath, height: 64, width: 64,),
          ),
          const SizedBox(height: 2,),
          Center(
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }

}