import 'dart:math';

import 'package:bubble_chart/bubble_chart.dart';
import 'package:flutter/material.dart';

class GrupoView extends StatefulWidget {
  const GrupoView({Key? key}) : super(key: key);

  @override
  _GrupoViewState createState() => _GrupoViewState();
}

class _GrupoViewState extends State<GrupoView> {
  List<BubbleNode> childNode = [];

  @override
  void initState() {
    super.initState();
    _addNewNode();
    // Timer.periodic(Duration(milliseconds: 500), (_) {
    //   _addNewNode();
    // });
  }

  _addNewNode() {
    setState(() {
      Random random = Random();

      for (int i = 0; i <= 150; i++) {
        BubbleNode node = BubbleNode.leaf(
          value: max(1, random.nextInt(50)),
          options: BubbleOptions(
            child: Image(
                image: NetworkImage(
                    'https://scontent.fagu2-1.fna.fbcdn.net/v/t39.30808-6/329349825_581028793575102_6527898272697218778_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeF5Lv2e6P-OKvAljp2WXNO4rQ_LRxEZP12tD8tHERk_XYLJi_zZ6HEJRdLv_MFHfcnONJAhqeXDYmo0d329EznM&_nc_ohc=VTPXrD_SKCcAX_DNrq_&_nc_ht=scontent.fagu2-1.fna&oh=00_AfAljy23UfDVzeqj8fdzcieSt_o31fM4dw3VviNPjLwUJA&oe=641E2143')),
            color: () {
              Random random = Random();
              return Colors.primaries[random.nextInt(Colors.primaries.length)];
            }(),
          ),
        );
        node.options?.onTap = () {
          setState(() {
            node.value += 1;
            // childNode.remove(node);
          });
        };
        childNode.add(node);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: 1000,
        child: BubbleChartLayout(
          padding: 10,
          children: [
            BubbleNode.node(
              padding: 15,
              children: childNode,
              options: BubbleOptions(color: Colors.red),
            ),
          ],
          duration: Duration(milliseconds: 500),
        ),
      ),
    );
  }
}
