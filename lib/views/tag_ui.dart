import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:driver_bits/utility_classes/tag.dart';
import 'package:driver_bits/utility_classes/reading.dart';

Map<String, dynamic> sampleData = const {
  "timestamp":1629472635430,
  "driver":"screwdriver-testbed-20212021",
  "rssi":-60,
  "temperature":28.71,
  "humidity":35.8,
  "pressure":100784,
  "battery":3034,
  "measurementSequenceNumber":28827,
  "tag":"ef9d0e26ed52",
};

class TagUi extends StatefulWidget {
  final Tag _selected;

  const TagUi({required Tag tag, Key? key})
      : _selected = tag,
        super(key: key);

  @override
  State<TagUi> createState() => _TagState();
}

class _TagState extends State<TagUi> {
  Reading? _latest;

  @override
  initState() {
    super.initState();
    _latest = Reading(sampleData);
  }

  @override
  Widget build(BuildContext context) {

    Widget _tempGauge() {
      return SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
                startAngle: 180,
                endAngle: 360,
                canScaleToFit: true,
                interval: 10,
                radiusFactor: 0.95,
                labelFormat: '{value} °C',
                labelsPosition: ElementsPosition.outside,
                ticksPosition: ElementsPosition.inside,
                labelOffset: 15,
                minorTickStyle: const MinorTickStyle(
                    length: 0.05, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
                majorTickStyle: const MajorTickStyle(
                    length: 0.1, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
                minorTicksPerInterval: 5,
                pointers: const <GaugePointer>[
                  NeedlePointer(
                      value: 50,
                      needleStartWidth: 1,
                      needleEndWidth: 3,
                      needleLength: 0.8,
                      enableAnimation: true,
                      lengthUnit: GaugeSizeUnit.factor,
                      knobStyle: KnobStyle(
                        knobRadius: 6,
                        sizeUnit: GaugeSizeUnit.logicalPixel,
                      ),
                      tailStyle: TailStyle(
                          width: 2,
                          lengthUnit: GaugeSizeUnit.logicalPixel,
                          length: 24)),
                  RangePointer(
                    value: 50,
                    width: 5,
                    enableAnimation: true,
                  ),
                ],
                axisLabelStyle:
                const GaugeTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                axisLineStyle:
                const AxisLineStyle(thickness: 3, color: Color(0xFF00A8B5))),
          ]
      );
    }

    Widget _humidGauge() {
      return const Text('humid');
    }

    Widget _presGauge() {
      return const Text('pres');
    }

    Widget _batGauge() {
      return const Text('bat');
    }

    Widget _rssiGauge() {
      return const Text('rssi');
    }

    Widget _comboGauge() {
      return const Text('combo');
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        Text(_latest?.timeSince, style: Theme.of(context).textTheme.headline4,),
        _tempGauge(),
      ],
    );
  }
}