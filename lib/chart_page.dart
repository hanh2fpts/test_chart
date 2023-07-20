import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  late WebViewController controller;
  int _currentSegment = 0;

  /// danh sách của kiểu Resolution
  final Map<int, Widget> _segments = {
    0: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text('D'),
    ),
    1: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text('2D'),
    ),
    2: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text('3D'),
    ),
    3: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text('W'),
    ),
    4: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text('3W'),
    ),
    5: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text('M'),
    ),
    6: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text('6M'),
    ),
  };
  var chartType = 1;
  final Map<String, int> _chartType = {
    'Bar': 0,
    'Candles': 1,
    'Line': 2,
    'Area': 3,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chart Page'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7), border: Border.all(color: Colors.grey)),
                child: SvgPicture.asset(
                  'assets/icons/icon_hand.svg',
                  height: 20,
                  width: 20,
                  color: Colors.grey.shade700,
                ),
              ),
              GestureDetector(
                onTap: () {
                  chartType++;
                  if (chartType == _chartType.length) {
                    chartType = 0;
                  }
                  String script = "changeChartType($chartType);";
                  controller.runJavascript(script);
                  setState(() {});
                },
                child: Container(
                  padding: const EdgeInsets.all(3),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.grey)),
                  child: SvgPicture.asset(
                    'assets/icons/icon_chart_$chartType.svg',
                    height: 20,
                    width: 20,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7), border: Border.all(color: Colors.grey)),
                child: SvgPicture.asset(
                  'assets/icons/icon_fx.svg',
                  height: 20,
                  width: 20,
                  color: Colors.grey.shade700,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7), border: Border.all(color: Colors.grey)),
                child: SvgPicture.asset(
                  'assets/icons/icon_setting.svg',
                  height: 20,
                  width: 20,
                  color: Colors.grey.shade700,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7), border: Border.all(color: Colors.grey)),
                child: SvgPicture.asset(
                  'assets/icons/icon_share.svg',
                  height: 20,
                  width: 20,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 400,
            child: WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: 'http://localhost:8888/assets/charting_library/mobile_black.html',
              onWebViewCreated: (controller) {
                this.controller = controller;
              },
              onPageStarted: (url) {
                print('on page started $url');
              },
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CupertinoSlidingSegmentedControl(
            backgroundColor: Colors.grey.shade100,
            thumbColor: Colors.green,
            groupValue: _currentSegment,
            children: _segments,
            onValueChanged: (value) {
              String script = "";
              setState(() {
                _currentSegment = value!;
                switch (_currentSegment) {
                  case 0:
                    script = "changeResolution('D');";
                    break;
                  case 1:
                    script = "changeResolution('2D');";
                    break;
                  case 2:
                    script = "changeResolution('3D');";
                    break;
                  case 3:
                    script = "changeResolution('W');";
                    break;
                  case 4:
                    script = "changeResolution('3W');";
                    break;
                  case 5:
                    script = "changeResolution('M');";
                    break;
                  case 6:
                    script = "changeResolution('6M');";
                  default:
                    script = "changeResolution('D');";
                    break;
                }
                controller.runJavascript(script);
              });
            },
          ),
        ],
      ),
    );
  }
}
