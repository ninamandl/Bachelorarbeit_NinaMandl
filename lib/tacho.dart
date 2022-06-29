// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_final_fields, deprecated_member_use, constant_identifier_names, unused_field
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';


class Tacho extends StatefulWidget {
  @override
  State<Tacho> createState() => _TachoState();
}

class _TachoState extends State<Tacho> {

  double pointerDuration = 1000.0;
  bool pointerAnimation = true;
  double tachoPointerValue = 0.0;
  double revolutionsPointerValue = 0.0;
  var duration = 0;
  bool _buttonPressed = false;
  bool _loopActive = false;
  bool _notButtonPressed = false;

  void _setPointerDuration() {
    setState(() {
      pointerAnimation = true;
      // pointerDuration = randomizePointerDuration();
      tachoPointerValue++;
      revolutionsPointerValue = tachoPointerValue / 38;
      tankPointerValue -= 0.05;
      if (tachoPointerValue == 180) _stop();
      print('Tacho Value: $tachoPointerValue; Revolutions Value: $revolutionsPointerValue; Tank Value: $tankPointerValue - going up');
    });
  }

  void _setNegativePointerDuration() {
    pointerAnimation = true;
    tachoPointerValue--;
    revolutionsPointerValue = tachoPointerValue / 38;
    if (tachoPointerValue == 0.0) _reset();
    print(
        'Value: $tachoPointerValue; Revolutions Value: $revolutionsPointerValue  - going down');
  }

  void _stop() {
    setState(() {
      duration = 0;
      _buttonPressed = false;
      _notButtonPressed = false;
      print('stop');
    });
  }

  void _reset() {
    setState(() {
      tachoPointerValue = 0.0;
      revolutionsPointerValue = 0.0;
      duration = 0;
      _buttonPressed = false;
      _notButtonPressed = false;
      print('reset');
    });
  }

  changeDuration() {
    Random random = Random();
    int newDuration = duration + random.nextInt(100);
    print('Random Pointer Duration $newDuration');
    return newDuration;
  }

// whie pressed button

  // Pointer going up
  void _increasePointerValueWhilePressed() async {
    if (_loopActive) return; // check if loop is active

    _loopActive = true;

    while (_buttonPressed) {
      // do your thing
      setState(() {
        _setPointerDuration();
      });

      // wait a second
      await Future.delayed(Duration(milliseconds: changeDuration()));
    }

    _loopActive = false;
  }

  // Pointer going down
  void _decreasePointerValueWhilePressed() async {
    while (_notButtonPressed) {
      setState(() {
        _setNegativePointerDuration();
      });

      await Future.delayed(Duration(milliseconds: 75));
    }
  }

// end while pressed button

  double tankPointerValue = 80.0;


  static const IconData local_gas_station_sharp = IconData(0xea8e, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height * 1.2);
    final double itemWidth = (size.width);

    return Scaffold(
        body: GridView.count(
      primary: false,
      crossAxisCount: 3,
      childAspectRatio: (itemWidth / itemHeight),

      children: <Widget>[
        SfRadialGauge( // Revolutions
            // title: GaugeTitle(text: "Revolutions"), //title for guage
            enableLoadingAnimation:
                false, //show meter pointer movement while loading
            //animationDuration: 200, //pointer movement speed
            axes: <RadialAxis>[
              //Radial Guage Axix, use other Guage type here
              RadialAxis(
                  minimum: 0,
                  maximum: 6,
                  interval: 1,
                  axisLineStyle: AxisLineStyle(thickness: 35),
                  radiusFactor: 0.8,
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: revolutionsPointerValue,
                      width: 35,
                      color: Colors.black,
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Container(
                            child: Text(
                                'rpm'.toString(), //noch ändern zu current value
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                        angle: 90,
                        positionFactor: 0.5),
                    //add more annotations 'texts inside guage' here
                  ]
                  //add more annotations 'texts inside guage' here
                  )
            ]),
        
        Column(
          children: [
            Container( //reset button
                padding: EdgeInsets.fromLTRB(100, 100, 100, 20),
                child: SizedBox(
                    height: 50,
                    width: 150,
                    child: RaisedButton(
                      color: Color.fromARGB(255, 70, 70, 70),
                      textColor: Colors.white,
                      child: Text(
                        'reset',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                      // onPressed: null,
                      onPressed: () => _reset(),
                    ))),
            Container( // stop button
            padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
            child: SizedBox(
                height: 50,
                width: 150,
                child: RaisedButton(
                  color: Color.fromARGB(255, 70, 70, 70),
                  textColor: Colors.white,
                  child: Text(
                    'stop',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                    ),
                  ),
                  // onPressed: null,
                  onPressed: () => _stop(),
                ))),
        
          ],
        ),
        
        SfRadialGauge( // Tacho
            // title: GaugeTitle(text: "Speedo Meter"), //title for guage
            enableLoadingAnimation:
                false, //show meter pointer movement while loading
            //animationDuration: 200, //pointer movement speed
            axes: <RadialAxis>[
              //Radial Guage Axix, use other Guage type here
              RadialAxis(
                  minimum: 0,
                  maximum: 180,
                  axisLineStyle: AxisLineStyle(thickness: 35),
                  radiusFactor: 0.8,
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: tachoPointerValue,
                      width: 35,
                      color: Colors.black,
                    )
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                        widget: Container(
                            child: Text(
                                'km/h'
                                    .toString(), //noch ändern zu current value
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                        angle: 90,
                        positionFactor: 0.5),
                    //add more annotations 'texts inside guage' here
                  ])
            ]),
        
        Container( // stop button
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              DigitalClock(
                digitAnimationStyle: Curves.elasticOut,
                is24HourTimeFormat: false,
                areaDecoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                hourMinuteDigitTextStyle: TextStyle(
                  color: Color.fromARGB(255, 55, 55, 55),
                  fontSize: 50,
                ),
                amPmDigitTextStyle: TextStyle(
                    color: Color.fromARGB(255, 50, 50, 50),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        
        Container( // start button
          padding: EdgeInsets.fromLTRB(100, 20, 100, 20),

          child: Listener(
            onPointerDown: (details) {
              _buttonPressed = true;
              _notButtonPressed = false;
              // _increaseCounterWhilePressed();
              _increasePointerValueWhilePressed();
            },
            onPointerUp: (details) {
              _buttonPressed = false;
              _notButtonPressed = true;
              _decreasePointerValueWhilePressed();
            },
            child: Container(
              decoration:
                  BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 5),
                    borderRadius: BorderRadius.circular(30),
                    ),
              padding: EdgeInsets.all(16.0),
              child: Text(
                'gib Gas',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        
        Row(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(130, 20, 0, 57),
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.local_gas_station_sharp,
                size: 40,
              ),
            ),
            Container( // Tank Level
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              // child: LevelIndicator()
              child: Center(
                child: SizedBox(
                  height: 250,
                  width: 100,
                  child: SfLinearGauge(
                    orientation: LinearGaugeOrientation.vertical,
                    axisTrackStyle: LinearAxisTrackStyle(thickness: 30),
                    barPointers: [
                      LinearBarPointer(
                        value: tankPointerValue,
                        thickness: 30,
                        color: Colors.black,
                    )],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
