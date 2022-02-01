
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'package:driver_bits/utility_classes/tag.dart';
import 'package:driver_bits/utility_classes/reading.dart';
import 'package:driver_bits/utility_classes/options.dart';
import 'package:driver_bits/tools/readingOptions.dart';

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
  late Reading _latest;

  @override
  initState() {
    super.initState();
    _latest = Reading(sampleData);
  }

  @override
  Widget build(BuildContext context) {
    ReadingOptions _tagOpt = getOptions(optFor: widget._selected.type);
    ColorScheme _scheme = Theme.of(context).colorScheme;

    Widget _tempGauge() {
      return Align(
        heightFactor: 0.8,
        child: SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 1500,
            axes: <RadialAxis>[
              RadialAxis(
                  minimum: _tagOpt.tempStart.toDouble(),
                  maximum: _tagOpt.tempEnd.toDouble(),
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: _tagOpt.tempStart.toDouble(),
                      endValue: _tagOpt.tempAlertLow.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.blue, Colors.lightBlueAccent],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.tempAlertLow.toDouble(),
                      endValue: _tagOpt.tempWarnLow.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lightBlueAccent, Colors.greenAccent],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.tempWarnLow.toDouble(),
                      endValue: _tagOpt.tempOptimum1.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.greenAccent, Colors.lightGreenAccent],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.tempOptimum1.toDouble(),
                      endValue: _tagOpt.tempOptimum2.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lightGreenAccent, Colors.lightGreen],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.tempOptimum2.toDouble(),
                      endValue: _tagOpt.tempWarnHigh.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lightGreen, Colors.lime],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.tempWarnHigh.toDouble(),
                      endValue: _tagOpt.tempAlertHigh.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lime, Colors.yellow],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.tempAlertHigh.toDouble(),
                      endValue: _tagOpt.tempEnd.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.yellow, Colors.deepOrange],
                          stops: <double>[0.25, 0.60]),
                    ),
                  ],
                  startAngle: 180,
                  endAngle: 360,
                  canScaleToFit: true,
                  interval: 5,
                  radiusFactor: 0.95,
                  labelFormat: '{value} °C',
                  labelsPosition: ElementsPosition.outside,
                  ticksPosition: ElementsPosition.inside,
                  labelOffset: 10,
                  canRotateLabels: true,
                  minorTickStyle: const MinorTickStyle(
                      length: 0.05, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
                  majorTickStyle: const MajorTickStyle(
                      length: 0.1, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
                  minorTicksPerInterval: 5,
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      angle: 90,
                      positionFactor: 0.2,
                      widget: Text(
                        'Temperature: ' + _latest.temperature.toStringAsFixed(1) + ' °C',
                        style: TextStyle(
                            fontSize: 16,
                            color: _scheme.secondary,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Times'),
                      ),
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                        needleColor: _scheme.secondary,
                        value: _latest.temperature,
                        needleStartWidth: 0.5,
                        needleEndWidth: 3,
                        needleLength: 0.86,
                        enableAnimation: true,
                        lengthUnit: GaugeSizeUnit.factor,
                        knobStyle: KnobStyle(
                          knobRadius: 4,
                          color: _scheme.secondaryVariant,
                          borderColor: _scheme.secondary,
                          borderWidth: 0.5,
                          sizeUnit: GaugeSizeUnit.logicalPixel,
                        ),
                        tailStyle: TailStyle(
                            width: 2,
                            color: _scheme.secondary,
                            lengthUnit: GaugeSizeUnit.logicalPixel,
                            length: 24)),
                    RangePointer(
                      color: _scheme.secondary,
                      value: _latest.temperature,
                      width: 2,
                      pointerOffset: 4,
                      enableAnimation: true,
                    ),
                  ],
                  axisLabelStyle:
                  const GaugeTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  axisLineStyle:
                  AxisLineStyle(thickness: 4, color: _scheme.secondary,)),
            ]
        ),
      );
    }

    Widget _humidGauge() {
      return Align(
        heightFactor: 0.8,
        child: SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 1500,
            axes: <RadialAxis>[
              RadialAxis(
                  minimum: _tagOpt.humidStart.toDouble(),
                  maximum: _tagOpt.humidEnd.toDouble(),
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: _tagOpt.humidStart.toDouble(),
                      endValue: _tagOpt.humidAlertLow.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.blue, Colors.lightBlueAccent],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.humidAlertLow.toDouble(),
                      endValue: _tagOpt.humidWarnLow.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lightBlueAccent, Colors.greenAccent],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.humidWarnLow.toDouble(),
                      endValue: _tagOpt.humidOptimum1.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.greenAccent, Colors.lightGreenAccent],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.humidOptimum1.toDouble(),
                      endValue: _tagOpt.humidOptimum2.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lightGreenAccent, Colors.lightGreen],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.humidOptimum2.toDouble(),
                      endValue: _tagOpt.humidWarnHigh.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lightGreen, Colors.lime],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.humidWarnHigh.toDouble(),
                      endValue: _tagOpt.humidAlertHigh.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lime, Colors.yellow],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.humidAlertHigh.toDouble(),
                      endValue: _tagOpt.humidEnd.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.yellow, Colors.deepOrange],
                          stops: <double>[0.25, 0.60]),
                    ),
                  ],
                  startAngle: 180,
                  endAngle: 360,
                  canScaleToFit: true,
                  interval: 10,
                  radiusFactor: 0.95,
                  labelFormat: '{value} %',
                  labelsPosition: ElementsPosition.outside,
                  ticksPosition: ElementsPosition.inside,
                  labelOffset: 10,
                  canRotateLabels: true,
                  minorTickStyle: const MinorTickStyle(
                      length: 0.05, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
                  majorTickStyle: const MajorTickStyle(
                      length: 0.1, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
                  minorTicksPerInterval: 5,
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      angle: 90,
                      positionFactor: 0.2,
                      widget: Text(
                        'Humidity: ' + _latest.humidity.toStringAsFixed(1) + ' %',
                        style: TextStyle(
                            fontSize: 16,
                            color: _scheme.secondary,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Times'),
                      ),
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                        needleColor: _scheme.secondary,
                        value: _latest.humidity,
                        needleStartWidth: 0.5,
                        needleEndWidth: 3,
                        needleLength: 0.86,
                        enableAnimation: true,
                        lengthUnit: GaugeSizeUnit.factor,
                        knobStyle: KnobStyle(
                          knobRadius: 4,
                          color: _scheme.secondaryVariant,
                          borderColor: _scheme.secondary,
                          borderWidth: 0.5,
                          sizeUnit: GaugeSizeUnit.logicalPixel,
                        ),
                        tailStyle: TailStyle(
                            width: 2,
                            color: _scheme.secondary,
                            lengthUnit: GaugeSizeUnit.logicalPixel,
                            length: 24)),
                    RangePointer(
                      color: _scheme.secondary,
                      value: _latest.humidity,
                      width: 2,
                      pointerOffset: 4,
                      enableAnimation: true,
                    ),
                  ],
                  axisLabelStyle:
                  const GaugeTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  axisLineStyle:
                  AxisLineStyle(thickness: 4, color: _scheme.secondary,)),
            ]
        ),
      );
    }

    Widget _presGauge() {
      double trimPressure() {
        return _latest.pressure/100.toDouble();
      }
      return Align(
        heightFactor: 0.8,
        child: SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 1500,
            axes: <RadialAxis>[
              RadialAxis(
                  minimum: _tagOpt.presStart/100.toDouble(),
                  maximum: _tagOpt.presEnd/100.toDouble(),
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: _tagOpt.presStart/100.toDouble(),
                      endValue: _tagOpt.presAlertLow/100.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.blue, Colors.lightBlueAccent],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.presAlertLow/100.toDouble(),
                      endValue: _tagOpt.presWarnLow/100.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lightBlueAccent, Colors.greenAccent],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.presWarnLow/100.toDouble(),
                      endValue: _tagOpt.presOptimum1/100.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.greenAccent, Colors.lightGreenAccent],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.presOptimum1/100.toDouble(),
                      endValue: _tagOpt.presOptimum2/100.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lightGreenAccent, Colors.lightGreen],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.presOptimum2/100.toDouble(),
                      endValue: _tagOpt.presWarnHigh/100.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lightGreen, Colors.lime],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.presWarnHigh/100.toDouble(),
                      endValue: _tagOpt.presAlertHigh/100.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lime, Colors.yellow],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.presAlertHigh/100.toDouble(),
                      endValue: _tagOpt.presEnd/100.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.yellow, Colors.deepOrange],
                          stops: <double>[0.25, 0.60]),
                    ),
                  ],
                  startAngle: 180,
                  endAngle: 360,
                  canScaleToFit: true,
                  interval: 5,
                  radiusFactor: 0.95,
                  labelFormat: '{value} hPa',
                  labelsPosition: ElementsPosition.outside,
                  ticksPosition: ElementsPosition.inside,
                  labelOffset: 10,
                  canRotateLabels: true,
                  minorTickStyle: const MinorTickStyle(
                      length: 0.05, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
                  majorTickStyle: const MajorTickStyle(
                      length: 0.1, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
                  minorTicksPerInterval: 5,
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      angle: 90,
                      positionFactor: 0.2,
                      widget: Text(
                        'Pressure: ' + trimPressure().toString() + ' hPa',
                        style: TextStyle(
                            fontSize: 16,
                            color: _scheme.secondary,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Times'),
                      ),
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                        needleColor: _scheme.secondary,
                        value: trimPressure(),
                        needleStartWidth: 0.5,
                        needleEndWidth: 3,
                        needleLength: 0.86,
                        enableAnimation: true,
                        lengthUnit: GaugeSizeUnit.factor,
                        knobStyle: KnobStyle(
                          knobRadius: 4,
                          color: _scheme.secondaryVariant,
                          borderColor: _scheme.secondary,
                          borderWidth: 0.5,
                          sizeUnit: GaugeSizeUnit.logicalPixel,
                        ),
                        tailStyle: TailStyle(
                            width: 2,
                            color: _scheme.secondary,
                            lengthUnit: GaugeSizeUnit.logicalPixel,
                            length: 24)),
                    RangePointer(
                      color: _scheme.secondary,
                      value: trimPressure(),
                      width: 2,
                      pointerOffset: 4,
                      enableAnimation: true,
                    ),
                  ],
                  axisLabelStyle:
                  const GaugeTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  axisLineStyle:
                  AxisLineStyle(thickness: 4, color: _scheme.secondary,)),
            ]
        ),
      );
    }

    Widget _batGauge() {
      double trimBattery() => _latest.battery/1000.toDouble();
      return Align(
        heightFactor: 0.8,
        child: SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 1500,
            axes: <RadialAxis>[
              RadialAxis(
                  minimum: _tagOpt.voltStart/1000.toDouble(),
                  maximum: _tagOpt.voltEnd/1000.toDouble(),
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: _tagOpt.voltStart/1000.toDouble(),
                      endValue: _tagOpt.voltAlertLow/1000.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.deepOrange, Colors.yellow],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.voltAlertLow/1000.toDouble(),
                      endValue: _tagOpt.voltWarnLow/1000.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.yellow, Colors.lime],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.voltWarnLow/1000.toDouble(),
                      endValue: _tagOpt.voltOptimum1/1000.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lime, Colors.lightGreenAccent],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.voltOptimum1/1000.toDouble(),
                      endValue: _tagOpt.voltOptimum2/1000.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lightGreenAccent, Colors.lightGreen],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.voltOptimum2/1000.toDouble(),
                      endValue: _tagOpt.voltWarnHigh/1000.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lightGreen, Colors.lime],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.voltWarnHigh/1000.toDouble(),
                      endValue: _tagOpt.voltEnd/1000.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lime, Colors.deepOrange],
                          stops: <double>[0.15, 0.60]),
                    ),
                  ],
                  startAngle: 180,
                  endAngle: 360,
                  canScaleToFit: true,
                  interval: 0.2,
                  radiusFactor: 0.95,
                  labelFormat: '{value} V',
                  labelsPosition: ElementsPosition.outside,
                  ticksPosition: ElementsPosition.inside,
                  labelOffset: 10,
                  canRotateLabels: true,
                  minorTickStyle: const MinorTickStyle(
                      length: 0.05, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
                  majorTickStyle: const MajorTickStyle(
                      length: 0.1, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
                  minorTicksPerInterval: 5,
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      angle: 90,
                      positionFactor: 0.2,
                      widget: Text(
                        'Battery: ' + trimBattery().toStringAsFixed(2) + ' V',
                        style: TextStyle(
                            fontSize: 16,
                            color: _scheme.secondary,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Times'),
                      ),
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                        needleColor: _scheme.secondary,
                        value: _latest.battery/1000,
                        needleStartWidth: 0.5,
                        needleEndWidth: 3,
                        needleLength: 0.86,
                        enableAnimation: true,
                        lengthUnit: GaugeSizeUnit.factor,
                        knobStyle: KnobStyle(
                          knobRadius: 4,
                          color: _scheme.secondaryVariant,
                          borderColor: _scheme.secondary,
                          borderWidth: 0.5,
                          sizeUnit: GaugeSizeUnit.logicalPixel,
                        ),
                        tailStyle: TailStyle(
                            width: 2,
                            color: _scheme.secondary,
                            lengthUnit: GaugeSizeUnit.logicalPixel,
                            length: 24)),
                    RangePointer(
                      color: _scheme.secondary,
                      value: _latest.battery/1000,
                      width: 2,
                      pointerOffset: 4,
                      enableAnimation: true,
                    ),
                  ],
                  axisLabelStyle:
                  const GaugeTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  axisLineStyle:
                  AxisLineStyle(thickness: 4, color: _scheme.secondary,)),
            ]
        ),
      );
    }

    Widget _rssiGauge() {
      return Align(
        heightFactor: 0.8,
        child: SfRadialGauge(
            enableLoadingAnimation: true,
            animationDuration: 1500,
            axes: <RadialAxis>[
              RadialAxis(
                  minimum: _tagOpt.rssiStart.toDouble(),
                  maximum: _tagOpt.rssiEnd.toDouble(),
                  ranges: <GaugeRange>[
                    GaugeRange(
                      startValue: _tagOpt.rssiStart.toDouble(),
                      endValue: _tagOpt.rssiLow.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.deepOrange, Colors.yellow],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.rssiLow.toDouble(),
                      endValue: _tagOpt.rssiModerate.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.yellow, Colors.lime],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.rssiModerate.toDouble(),
                      endValue: _tagOpt.rssiHigh.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lime, Colors.lightGreenAccent],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.rssiHigh.toDouble(),
                      endValue: _tagOpt.rssiVeryHigh.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lightGreenAccent, Colors.lightGreen],
                          stops: <double>[0.25, 0.75]),
                    ),
                    GaugeRange(
                      startValue: _tagOpt.rssiVeryHigh.toDouble(),
                      endValue: _tagOpt.rssiEnd.toDouble(),
                      startWidth: 4,
                      endWidth: 4,
                      gradient: const SweepGradient(
                          colors: <Color>[Colors.lightGreen, Colors.green],
                          stops: <double>[0.25, 0.75]),
                    )
                  ],
                  startAngle: 180,
                  endAngle: 360,
                  canScaleToFit: true,
                  interval: 10,
                  radiusFactor: 0.95,
                  labelFormat: '{value}',
                  labelsPosition: ElementsPosition.outside,
                  ticksPosition: ElementsPosition.inside,
                  labelOffset: 10,
                  canRotateLabels: true,
                  minorTickStyle: const MinorTickStyle(
                      length: 0.05, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
                  majorTickStyle: const MajorTickStyle(
                      length: 0.1, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
                  minorTicksPerInterval: 5,
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      angle: 90,
                      positionFactor: 0.2,
                      widget: Text(
                        'RSSI: ' + _latest.rssi.toStringAsFixed(0),
                        style: TextStyle(
                            color: _scheme.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Times'),
                      ),
                    ),
                  ],
                  pointers: <GaugePointer>[
                    NeedlePointer(
                        needleColor: _scheme.secondary,
                        value: _latest.rssi.toDouble(),
                        needleStartWidth: 0.5,
                        needleEndWidth: 3,
                        needleLength: 0.86,
                        enableAnimation: true,
                        lengthUnit: GaugeSizeUnit.factor,
                        knobStyle: KnobStyle(
                          color: _scheme.secondaryVariant,
                          borderColor: _scheme.secondary,
                          borderWidth: 0.5,
                          knobRadius: 4,
                          sizeUnit: GaugeSizeUnit.logicalPixel,
                        ),
                        tailStyle: TailStyle(
                            color: _scheme.secondary,
                            width: 2,
                            lengthUnit: GaugeSizeUnit.logicalPixel,
                            length: 24)),
                    RangePointer(
                      color: _scheme.secondary,
                      value: _latest.rssi.toDouble(),
                      width: 2,
                      pointerOffset: 4,
                      enableAnimation: true,
                    ),
                  ],
                  axisLabelStyle:
                  const GaugeTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  axisLineStyle:
                  AxisLineStyle(thickness: 4, color: _scheme.secondary)),
            ]
        ),
      );
    }

    //Widget _comboGauge() {
    //       return SfRadialGauge(
    //           axes: <RadialAxis>[
    //             RadialAxis(
    //                 minimum: _tagOpt.tempStart.toDouble(),
    //                 maximum: _tagOpt.tempEnd.toDouble(),
    //                 startAngle: 90,
    //                 endAngle: 270,
    //                 canScaleToFit: true,
    //                 interval: 10,
    //                 radiusFactor: 0.75,
    //                 labelFormat: '{value} °C',
    //                 labelsPosition: ElementsPosition.outside,
    //                 ticksPosition: ElementsPosition.outside,
    //                 labelOffset: 15,
    //                 canRotateLabels: true,
    //                 minorTickStyle: const MinorTickStyle(
    //                     length: 0.05, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
    //                 majorTickStyle: const MajorTickStyle(
    //                     length: 0.1, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
    //                 minorTicksPerInterval: 5,
    //                 pointers: const <GaugePointer>[
    //                   NeedlePointer(
    //                       value: 5,
    //                       needleStartWidth: 0.5,
    //                       needleEndWidth: 3,
    //                       needleLength: 0.82,
    //                       enableAnimation: true,
    //                       lengthUnit: GaugeSizeUnit.factor,
    //                       knobStyle: KnobStyle(
    //                         knobRadius: 6,
    //                         sizeUnit: GaugeSizeUnit.logicalPixel,
    //                       ),
    //                       tailStyle: TailStyle(
    //                           width: 2,
    //                           lengthUnit: GaugeSizeUnit.logicalPixel,
    //                           length: 24)),
    //                   RangePointer(
    //                     value: 5,
    //                     width: 3,
    //                     pointerOffset: 4,
    //                     enableAnimation: true,
    //                   ),
    //                 ],
    //                 axisLabelStyle:
    //                 const GaugeTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    //                 axisLineStyle:
    //                 const AxisLineStyle(thickness: 4, color: Color(0xFF00A8B5))),
    //             RadialAxis(
    //                 minimum: _tagOpt.humidStart.toDouble(),
    //                 maximum: _tagOpt.humidEnd.toDouble(),
    //                 startAngle: 270,
    //                 endAngle: 450,
    //                 canScaleToFit: true,
    //                 interval: 10,
    //                 radiusFactor: 0.75,
    //                 labelFormat: '{value} %',
    //                 labelsPosition: ElementsPosition.outside,
    //                 ticksPosition: ElementsPosition.outside,
    //                 labelOffset: 15,
    //                 canRotateLabels: true,
    //                 minorTickStyle: const MinorTickStyle(
    //                     length: 0.05, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
    //                 majorTickStyle: const MajorTickStyle(
    //                     length: 0.1, lengthUnit: GaugeSizeUnit.factor, thickness: 1.5),
    //                 minorTicksPerInterval: 5,
    //                 pointers: const <GaugePointer>[
    //                   NeedlePointer(
    //                       value: 55,
    //                       needleStartWidth: 0.5,
    //                       needleEndWidth: 3,
    //                       needleLength: 0.82,
    //                       enableAnimation: true,
    //                       lengthUnit: GaugeSizeUnit.factor,
    //                       knobStyle: KnobStyle(
    //                         knobRadius: 6,
    //                         sizeUnit: GaugeSizeUnit.logicalPixel,
    //                       ),
    //                       tailStyle: TailStyle(
    //                           width: 2,
    //                           lengthUnit: GaugeSizeUnit.logicalPixel,
    //                           length: 24)),
    //                   RangePointer(
    //                     value: 55,
    //                     width: 3,
    //                     pointerOffset: 4,
    //                     enableAnimation: true,
    //                   ),
    //                 ],
    //                 axisLabelStyle:
    //                 const GaugeTextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    //                 axisLineStyle:
    //                 const AxisLineStyle(thickness: 4, color: Color(0xFF00A8B5)))
    //           ]
    //       );
    //     }



    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      children: <Widget>[
        Text(_latest.timeSince, style: Theme.of(context).textTheme.headline4,),
        _tempGauge(),
        _humidGauge(),
        _presGauge(),
        _batGauge(),
        _rssiGauge()
      ],
    );
  }
}