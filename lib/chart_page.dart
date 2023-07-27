// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:local_notification/constant.dart';
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
  ValueNotifier<bool> isShowVolume = ValueNotifier(false);
  ValueNotifier<bool> isShowRsi = ValueNotifier(false);
  ValueNotifier<bool> isShowBol = ValueNotifier(false);
  ValueNotifier<bool> isShowMA5 = ValueNotifier(false);
  ValueNotifier<bool> isShowMA10 = ValueNotifier(false);
  ValueNotifier<bool> isShowMA50 = ValueNotifier(false);
  ValueNotifier<bool> isShowMA100 = ValueNotifier(false);
  ValueNotifier<bool> isShowMA20 = ValueNotifier(false);
  ValueNotifier<bool> isShowMA200 = ValueNotifier(false);

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
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                          height: 250,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5), topRight: Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [Text('Các chỉ số'), Spacer(), CloseButton()],
                                ),
                                Divider(
                                  color: Colors.grey.shade300,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        isShowVolume.value = !isShowVolume.value;
                                        controller
                                            .runJavascript("setVolume(${isShowVolume.value});");
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable: isShowVolume,
                                        builder: (context, value, child) => Container(
                                          height: 25,
                                          width: 100,
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(Radius.circular(8)),
                                              border: Border.all(color: Colors.grey.shade300),
                                              color: value
                                                  ? Colors.green
                                                  : Theme.of(context).colorScheme.background),
                                          child: const Center(
                                            child: Text('Volume'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        isShowRsi.value = !isShowRsi.value;
                                        String script = "setRSI(${isShowRsi.value});";
                                        controller.runJavascript(script);
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable: isShowRsi,
                                        builder: (context, value, child) => Container(
                                          height: 25,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(Radius.circular(8)),
                                            border: Border.all(color: Colors.grey.shade300),
                                            color: value
                                                ? Colors.green
                                                : Theme.of(context).colorScheme.background,
                                          ),
                                          child: const Center(child: Text('RSI')),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        isShowBol.value = !isShowBol.value;
                                        String script = "setBollingerBands(${isShowBol.value});";
                                        controller.runJavascript(script);
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable: isShowBol,
                                        builder: (context, value, child) => Container(
                                          height: 25,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(Radius.circular(8)),
                                              border: Border.all(color: Colors.grey.shade300),
                                              color: value
                                                  ? Colors.green
                                                  : Theme.of(context).colorScheme.background),
                                          child: const Center(child: Text('Bol. Bands')),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey.shade300,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        isShowMA5.value = !isShowMA5.value;
                                        String script = "setMA5(${isShowMA5.value});";
                                        controller.runJavascript(script);
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable: isShowMA5,
                                        builder: (context, value, child) => Container(
                                          height: 25,
                                          width: 100,
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(Radius.circular(8)),
                                              border: Border.all(color: Colors.grey.shade300),
                                              color: value
                                                  ? Colors.green
                                                  : Theme.of(context).colorScheme.background),
                                          child: const Center(child: Text('MA5')),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        isShowMA10.value = !isShowMA10.value;
                                        String script = "setMA10(${isShowMA10.value});";
                                        controller.runJavascript(script);
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable: isShowMA10,
                                        builder: (context, value, child) => Container(
                                          height: 25,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(Radius.circular(8)),
                                              border: Border.all(color: Colors.grey.shade300),
                                              color: value
                                                  ? Colors.green
                                                  : Theme.of(context).colorScheme.background),
                                          child: const Center(child: Text('MA10')),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        isShowMA20.value = !isShowMA20.value;
                                        String script = "setMA20(${isShowMA20.value});";
                                        controller.runJavascript(script);
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable: isShowMA20,
                                        builder: (context, value, child) => Container(
                                          height: 25,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(Radius.circular(8)),
                                              border: Border.all(color: Colors.grey.shade300),
                                              color: value
                                                  ? Colors.green
                                                  : Theme.of(context).colorScheme.background),
                                          child: const Center(child: Text('MA20')),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        isShowMA50.value = !isShowMA50.value;
                                        String script = "setMA50(${isShowMA50.value});";
                                        controller.runJavascript(script);
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable: isShowMA50,
                                        builder: (context, value, child) => Container(
                                          height: 25,
                                          width: 100,
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(Radius.circular(8)),
                                              border: Border.all(color: Colors.grey.shade300),
                                              color: value
                                                  ? Colors.green
                                                  : Theme.of(context).colorScheme.background),
                                          child: const Center(child: Text('MA50')),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        isShowMA100.value = !isShowMA100.value;
                                        String script = "setMA100(${isShowMA100.value});";
                                        controller.runJavascript(script);
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable: isShowMA100,
                                        builder: (context, value, child) => Container(
                                          height: 25,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(Radius.circular(8)),
                                              border: Border.all(color: Colors.grey.shade300),
                                              color: value
                                                  ? Colors.green
                                                  : Theme.of(context).colorScheme.background),
                                          child: const Center(child: Text('MA100')),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        isShowMA200.value = !isShowMA200.value;
                                        String script = "setMA200(${isShowMA200.value});";
                                        controller.runJavascript(script);
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable: isShowMA200,
                                        builder: (context, value, child) => Container(
                                          height: 25,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(Radius.circular(8)),
                                              border: Border.all(color: Colors.grey.shade300),
                                              color: value
                                                  ? Colors.green
                                                  : Theme.of(context).colorScheme.background),
                                          child: const Center(child: Text('MA200')),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ));
                    },
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(3),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.grey)),
                  child: SvgPicture.asset(
                    'assets/icons/icon_fx.svg',
                    height: 20,
                    width: 20,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => showModalBottomSheet(
                  context: context,
                  builder: (context) => const SettingChartWidget(),
                ),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.grey)),
                  child: SvgPicture.asset(
                    'assets/icons/icon_setting.svg',
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
                  'assets/icons/icon_share.svg',
                  height: 20,
                  width: 20,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
          ValueListenableBuilder(
            valueListenable: Constant.chartHeight,
            builder: (context, value, child) => SizedBox(
              height: value,
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: 'http://localhost:8888/assets/charting_library/mobile_black.html',
                onWebViewCreated: (controller) {
                  this.controller = controller;
                },
                onPageStarted: (url) {
                  if (kDebugMode) {
                    print('on page started $url');
                  }
                },
                onPageFinished: (url) {},
                zoomEnabled: false,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          CupertinoSlidingSegmentedControl(
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

class SettingChartWidget extends StatefulWidget {
  const SettingChartWidget({super.key});

  @override
  State<SettingChartWidget> createState() => _SettingChartWidgetState();
}

class _SettingChartWidgetState extends State<SettingChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 200,
      child: Column(
        children: [
          const Row(
            children: [Spacer(), CloseButton()],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Chiều cao chart:'),
              SizedBox(
                width: 280,
                child: Slider(
                    min: 100,
                    max: 500,
                    value: Constant.chartHeight.value,
                    onChanged: (value) {
                      setState(() {
                        Constant.chartHeight.value = value;
                      });
                    }),
              )
            ],
          )
        ],
      ),
    );
  }
}
