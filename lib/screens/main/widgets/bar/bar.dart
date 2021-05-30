import 'package:flutter/material.dart';

class Bar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60.0);
  final ImageProvider _image;
  final String _title;
  final IconButton _button;

  const Bar({image, title, button})
      : _image = image,
        _title = title,
        _button = button;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: CircleAvatar(backgroundImage: _image),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Flutter Counter with MVVM'),
          Text(
            _title,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
      actions: [_button],
    );
  }
}
