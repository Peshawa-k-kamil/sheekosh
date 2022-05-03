import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
  var value = "";
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: TextFormField(
        keyboardType: TextInputType.text,
        controller: _textEditingController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.all(
              Radius.circular(30),
            ),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: InkWell(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => SearchScreen(
                  //       searchQuery: 'val'.trim(),
                  //     ),
                  //   ),
                  // );
                  value = _textEditingController.text;
                  if (value != "") {
                    print(value);
                  }
                },
                child: SvgPicture.asset(
                  'assets/images/search-icon.svg',
                  //color: searchBorder,
                  width: 1,
                  height: 1,
                ),
              ),
            ),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
              child: IconButton(
                onPressed: () {
                  _textEditingController.clear();
                },
                icon: const Icon(
                  Icons.clear,
                ),
              ),
            ),
          ),
        ),
        onFieldSubmitted: (val) {
          value = val;
          if (value != "") {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => SearchScreen(
            //       searchQuery: val.trim(),
            //     ),
            //   ),
            // );
            //print(val);
            print(value);
          }
        },
      ),
    );
  }
}
