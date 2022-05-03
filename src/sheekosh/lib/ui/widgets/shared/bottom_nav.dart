import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showmBottomFilters(BuildContext ctx) {
      showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: ListView.builder(
                itemCount: 10,
                itemExtent: 50,
                itemBuilder: (ctx, index) {
                  return Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text('پزیشکی'),
                        Icon(
                          Icons.local_hospital,
                          color: Colors.blue,
                        ),
                      ],
                    ),
                  );
                }),
            behavior: HitTestBehavior.opaque,
          );
        },
      );
    }

    return Container(
      color: Colors.purple,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              // Navigator.pushNamed(context, MyAccountScreen.routeName);
            },
            child: const Icon(
              Icons.account_box_outlined,
              color: Colors.white,
              size: 35,
            ),
          ),
          InkWell(
            onTap: () => _showmBottomFilters(context),
            child: const Icon(
              Icons.shopping_cart_outlined,
              size: 35,
              color: Colors.white,
            ),
          ),
          const Icon(
            Icons.home,
            color: Colors.white,
            size: 35,
          ),
        ],
      ),
    );
  }
}
