
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

    NeedlePointer _needle(double value, [double lengthFactor = 0.86]) => NeedlePointer(
          needleColor: _scheme.secondary,
          value: value,
          needleStartWidth: 0.5,
          needleEndWidth: 3,
          needleLength: lengthFactor,
          enableAnimation: true,
          lengthUnit: GaugeSizeUnit.factor,
          knobStyle: KnobStyle(
            knobRadius: 4,
            color: _scheme.secondaryVariant,
            borderColor: _scheme.secondary,
            borderWidth: 1,
            sizeUnit: GaugeSizeUnit.logicalPixel,
          ),
          tailStyle: TailStyle(
              width: 2,
              color: _scheme.secondary,
              lengthUnit: GaugeSizeUnit.factor,
              length: 0.15,
          ),
    );
    RangePointer _range(double value) => RangePointer(
      color: _scheme.secondary,
      value: value,
      sizeUnit: GaugeSizeUnit.logicalPixel,
      width: 1.5,
      pointerOffset: -1,
      enableAnimation: true,
    );
    AxisLineStyle _axisLine() => AxisLineStyle(
      thickness: 4,
      thicknessUnit: GaugeSizeUnit.logicalPixel,
      color: _scheme.secondary,);
    GaugeTextStyle _gaugeText() => const GaugeTextStyle(fontSize: 12, fontWeight: FontWeight.normal);
    GaugeAnnotation _annotation(double value, String forType) {
      switch (forType) {
        case 'temperature': return GaugeAnnotation(
          angle: 90,
          positionFactor: 0.2,
          widget: Text(
            'Temperature: ' + value.toStringAsFixed(1) + ' °C',
            style: TextStyle(
                fontSize: 12,
                color: _scheme.secondary,
                fontWeight: FontWeight.normal,
            ),
          ),
        );
        case 'humidity': return GaugeAnnotation(
          angle: 90,
          positionFactor: 0.2,
          widget: Text(
            'Humidity: ' + value.toStringAsFixed(1) + ' %',
            style: TextStyle(
                fontSize: 12,
                color: _scheme.secondary,
                fontWeight: FontWeight.normal,
            ),
          ),
        );
        case 'pressure': return GaugeAnnotation(
          angle: 90,
          positionFactor: 0.2,
          widget: Text(
            'Pressure: ' + value.toString() + ' hPa',
            style: TextStyle(
                fontSize: 12,
                color: _scheme.secondary,
                fontWeight: FontWeight.normal,
            ),
          ),
        );
        case 'battery': return GaugeAnnotation(
          angle: 90,
          positionFactor: 0.2,
          widget: Text(
            'Battery: ' + value.toStringAsFixed(2) + ' V',
            style: TextStyle(
                fontSize: 12,
                color: _scheme.secondary,
                fontWeight: FontWeight.normal,
            ),
          ),
        );
        case 'rssi': return GaugeAnnotation(
          angle: 90,
          positionFactor: 0.2,
          widget: Text(
            'RSSI: ' + value.toStringAsFixed(0),
            style: TextStyle(
                fontSize: 12,
                color: _scheme.secondary,
                fontWeight: FontWeight.normal
            ),
          ),
        );
        default: return GaugeAnnotation(
          angle: 90,
          positionFactor: 0.2,
          widget: Text(
            'Default: ' + value.toStringAsFixed(1),
            style: TextStyle(
                fontSize: 12,
                color: _scheme.secondary,
                fontWeight: FontWeight.normal,
            ),
          ),
        );
      }
    }
    MinorTickStyle _tickMinor() => const MinorTickStyle(
        length: 5, lengthUnit: GaugeSizeUnit.logicalPixel, thickness: 1.5);
    MajorTickStyle _tickMajor() => const MajorTickStyle(
        length: 10, lengthUnit: GaugeSizeUnit.logicalPixel, thickness: 1.5);
    Widget _alignment(Widget child) => Align(
      heightFactor: 0.8,
      widthFactor: 1,
      child: child,
    );
    double _labelOffset = 10;
    double _loadingDuration = 1500;

    Widget _tempGauge() {
      SfRadialGauge gauge = SfRadialGauge(
          enableLoadingAnimation: true,
          animationDuration: _loadingDuration,
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
              radiusFactor: 1,
              canScaleToFit: true,
              interval: 5,
              labelFormat: '{value} °C',
              labelsPosition: ElementsPosition.outside,
              labelOffset: _labelOffset,
              ticksPosition: ElementsPosition.inside,
              canRotateLabels: true,
              minorTickStyle: _tickMinor(),
              majorTickStyle: _tickMajor(),
              minorTicksPerInterval: 5,
              annotations: <GaugeAnnotation>[
                _annotation(_latest.temperature, 'temperature'),
              ],
              pointers: <GaugePointer>[
                _needle(_latest.temperature),
                _range(_latest.temperature),
              ],
              axisLabelStyle: _gaugeText(),
              axisLineStyle: _axisLine(),
            ),
          ]
      );
      return _alignment(gauge);
    }

    Widget _humidGauge() {
      SfRadialGauge gauge = SfRadialGauge(
          enableLoadingAnimation: true,
          animationDuration: _loadingDuration,
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
              radiusFactor: 1,
              canScaleToFit: true,
              interval: 10,
              labelFormat: '{value} %',
              labelsPosition: ElementsPosition.outside,
              labelOffset: _labelOffset,
              ticksPosition: ElementsPosition.inside,
              canRotateLabels: true,
              minorTickStyle: _tickMinor(),
              majorTickStyle: _tickMajor(),
              minorTicksPerInterval: 5,
              annotations: <GaugeAnnotation>[
                _annotation(_latest.humidity, 'humidity'),
              ],
              pointers: <GaugePointer>[
                _needle(_latest.humidity),
                _range(_latest.humidity),
              ],
              axisLabelStyle: _gaugeText(),
              axisLineStyle: _axisLine(),
            ),
          ]
      );
      return _alignment(gauge);
    }

    Widget _presGauge() {
      double trimPressure() {
        return _latest.pressure/100.toDouble();
      }
      SfRadialGauge gauge = SfRadialGauge(
          enableLoadingAnimation: true,
          animationDuration: _loadingDuration,
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
              radiusFactor: 1,
              canScaleToFit: true,
              interval: 10,
              labelFormat: '{value} hPa',
              labelsPosition: ElementsPosition.outside,
              labelOffset: _labelOffset,
              ticksPosition: ElementsPosition.inside,
              canRotateLabels: true,
              minorTickStyle: _tickMinor(),
              majorTickStyle: _tickMajor(),
              minorTicksPerInterval: 5,
              annotations: <GaugeAnnotation>[
                _annotation(trimPressure(), 'pressure'),
              ],
              pointers: <GaugePointer>[
                _needle(trimPressure(), 0.815),
                _range(trimPressure()),
              ],
              axisLabelStyle: _gaugeText(),
              axisLineStyle: _axisLine(),
            ),
          ]
      );
      return _alignment(gauge);
    }

    Widget _batGauge() {
      double trimBattery() => _latest.battery/1000.toDouble();
      SfRadialGauge gauge = SfRadialGauge(
          enableLoadingAnimation: true,
          animationDuration: _loadingDuration,
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
              radiusFactor: 1,
              canScaleToFit: true,
              interval: 0.2,
              labelFormat: '{value} V',
              labelsPosition: ElementsPosition.outside,
              labelOffset: _labelOffset,
              ticksPosition: ElementsPosition.inside,
              canRotateLabels: true,
              minorTickStyle: _tickMinor(),
              majorTickStyle: _tickMajor(),
              minorTicksPerInterval: 5,
              annotations: <GaugeAnnotation>[
                _annotation(trimBattery(), 'battery'),
              ],
              pointers: <GaugePointer>[
                _needle(_latest.battery/1000),
                _range(_latest.battery/1000),
              ],
              axisLabelStyle: _gaugeText(),
              axisLineStyle: _axisLine(),
            ),
          ]
      );
      return _alignment(gauge);
    }

    Widget _rssiGauge() {
      SfRadialGauge gauge = SfRadialGauge(
          enableLoadingAnimation: true,
          animationDuration: _loadingDuration,
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
              radiusFactor: 0.95,
              canScaleToFit: true,
              interval: 15,
              labelFormat: '{value}',
              labelsPosition: ElementsPosition.outside,
              labelOffset: _labelOffset,
              ticksPosition: ElementsPosition.inside,
              canRotateLabels: true,
              minorTickStyle: _tickMinor(),
              majorTickStyle: _tickMajor(),
              minorTicksPerInterval: 3,
              annotations: <GaugeAnnotation>[
                _annotation(_latest.rssi.toDouble(), 'rssi'),
              ],
              pointers: <GaugePointer>[
                _needle(_latest.rssi.toDouble(), 0.88),
                _range(_latest.rssi.toDouble()),
              ],
              axisLabelStyle: _gaugeText(),
              axisLineStyle: _axisLine(),
            ),
          ]
      );
      return _alignment(gauge);
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
        Text(widget._selected.name),
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