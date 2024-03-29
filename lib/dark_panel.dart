// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, prefer_final_fields, deprecated_member_use, constant_identifier_names, unused_field, avoid_print
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:slide_digital_clock/slide_digital_clock.dart';

enum Options { small, medium, big, exit }



class DarkPanel extends StatefulWidget {
  @override
  State<DarkPanel> createState() => _DarkPanelState();
}

class _DarkPanelState extends State<DarkPanel> {

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
      if (tankPointerValue < 0) tankPointerValue = 0;
      if (tankPointerValue > 100) tankPointerValue = 100;
      if (tachoPointerValue >= 180) tachoPointerValue = 180;
      print('Tacho Value: $tachoPointerValue; Revolutions Value: $revolutionsPointerValue; Tank Value: $tankPointerValue - going up');
    });
  }

  void _setNegativePointerDuration() {
    pointerAnimation = true;
    tachoPointerValue -= 0.5;
    revolutionsPointerValue = tachoPointerValue / 38;
    if (tachoPointerValue == 0.0) _reset();
    print(
        'Tacho Value: $tachoPointerValue; Revolutions Value: $revolutionsPointerValue  - going down');
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

  void _refillTank(){
    setState(() {
      pointerAnimation = true;
      tankPointerValue ++;
      if (tankPointerValue < 0) tankPointerValue = 0;
      if (tankPointerValue > 100) tankPointerValue = 100;
      print('Tank: $tankPointerValue');
    });
  }

  void _stopRefillTank(){
    setState(() {
      duration = 0;
      _buttonPressed = false;
      _notButtonPressed = false;
      print('stop refill');
    });
  }

  // to randomize the Duration of the increasing Pinter Value
  // changeDuration() {
  //   Random random = Random();
  //   int newDuration = duration + random.nextInt(100);
  //   print('Random Pointer Duration $newDuration');
  //   return newDuration;
  // }


// whie pressed gas button

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
      await Future.delayed(Duration(milliseconds: 60));
      // await Future.delayed(Duration(milliseconds: changeDuration));

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

// end while pressed gas button


// whie pressed Tank Refill button

  // Tank Pointer going up
  void _increaseTankPointerValueWhilePressed() async {
    if (_loopActive) return; // check if loop is active

    _loopActive = true;

    while (_buttonPressed) {
      // do your thing
      setState(() {
        _refillTank();
      });

      // wait a second
      await Future.delayed(Duration(milliseconds: 60));
    }

    _loopActive = false;
  }

// end while pressed Tank Refill button


  double tankPointerValue = 75.0;

// Icons:
  static const IconData local_gas_station_sharp = IconData(0xea8e, fontFamily: 'MaterialIcons');
  static const IconData settings = IconData(0xe57f, fontFamily: 'MaterialIcons');
  

// ----------------> Settings: Change Font Size - Start 

  var _popupMenuItemIndex = 0.0;

// change Font Size rpm - start

  double custSizeRPM = 15.0;

    PopupMenuItem _buildPopupMenuItemRPM(String title, IconData iconData, double position) {
    return PopupMenuItem(
      value: position,
      child:  Row(
        children: [
          Icon(iconData, color: Colors.black, size: indivitualSize,),
          Text(title),
        ],
      ),
    );
  }

  double indivitualSize = 20;

  // if (this.iconName = '') indivitualSize = 30;


  _onMenuItemSelectedRPM(double value) {
    setState(() {
      _popupMenuItemIndex = value;
    });

    if (value == Options.small.index) {
      custSizeRPM = 10.0;
    } else if (value == Options.medium.index) {
      custSizeRPM = 15.0;
    } else if (value == Options.big.index) {
      custSizeRPM = 20.0;
    } else {
      custSizeRPM = custSizeRPM;
    }
  }
// change Font Size rpm - end


// change Font Size kmh - start

  double custSizeKMH = 15.0;

    PopupMenuItem _buildPopupMenuItemKMH(String title, IconData iconData, double position) {
    return PopupMenuItem(
      value: position,
      child:  Row(
        children: [
          Icon(iconData, color: Colors.black,),
          Text(title),
        ],
      ),
    );
  }

  _onMenuItemSelectedKMH(double value) {
    setState(() {
      _popupMenuItemIndex = value;
    });

    if (value == Options.small.index) {
      custSizeKMH = 10.0;
    } else if (value == Options.medium.index) {
      custSizeKMH = 15.0;
    } else if (value == Options.big.index) {
      custSizeKMH = 20.0;
    } else {
      custSizeKMH = custSizeKMH;
    }
  }
// change Font Size kmh - end


// change Font Size Tank - start

  double custSizeTank = 15.0;

    PopupMenuItem _buildPopupMenuItemTank(String title, IconData iconData, double position) {
        return PopupMenuItem(
          value: position,
          child:  Row(
            children: [
              Icon(iconData, color: Colors.black,),
              Text(title),
            ],
          ),
        );
      }

  _onMenuItemSelectedTank(double value) {
    setState(() {
      _popupMenuItemIndex = value;
    });

    if (value == Options.small.index) {
      custSizeTank = 10.0;
    } else if (value == Options.medium.index) {
      custSizeTank = 15.0;
    } else if (value == Options.big.index) {
      custSizeTank = 20.0;
    } else {
      custSizeTank = custSizeTank;
    }
  }

// change Font Size Tank - end

// ----------------> Settings: Change Font Size - End 

// change Widget Size - start

  double custWidgetSize = 40;

  PopupMenuItem _buildPopupMenuItem(String title, IconData iconData, double position) {
    return PopupMenuItem(
      value: position,
      child:  Row(
        children: [
          Icon(iconData, color: Colors.black),
          Text(title),
        ],
      ),
    );
  }
      
  _onMenuItemSelected(double value) {
    setState(() {
      _popupMenuItemIndex = value;
    });

    if (value == Options.small.index) {
      custWidgetSize = 30.0;
      custSizeRPM = 10.0;
      custSizeKMH = 10.0;
      custSizeTank = 10.0;
    } else if (value == Options.medium.index) {
      custWidgetSize = 40.0;
      custSizeRPM = 15.0;
      custSizeKMH = 15.0;
      custSizeTank = 15.0;
    } else if (value == Options.big.index) {
      custWidgetSize = 50.0;
      custSizeRPM = 20.0;
      custSizeKMH = 20.0;
      custSizeTank = 20.0;
    } else {
      custWidgetSize = custWidgetSize;
    }
  }

// change Widget Size - end

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height * 1.2);
    final double itemWidth = (size.width);

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white70, size: 10.0),
        title: Text(
          "Instrument Panel - Testing",
          style: TextStyle(
            color: Colors.white70)),
        backgroundColor: Color.fromARGB(255, 34, 34, 34),
        actions: [PopupMenuButton(
          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
          onSelected: (value) {
                _onMenuItemSelected(value as double);
              },
          itemBuilder: (ctx) => [
                _buildPopupMenuItem('Font Size - Small', Icons.arrow_downward, Options.small.index as double),
                _buildPopupMenuItem('Font Size - Medium', Icons.arrow_forward, Options.medium.index as double),
                _buildPopupMenuItem('Font Size - Big', Icons.arrow_upward, Options.big.index as double),
                _buildPopupMenuItem('Exit', Icons.exit_to_app, Options.exit.index as double),
              ],
        ) 
        ],
      ),

    
      body: GridView.count(
      primary: false,
      crossAxisCount: 3,
      childAspectRatio: (itemWidth / itemHeight),
      
      children: <Widget>[

        Row( // Revolutions
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: PopupMenuButton(
                child: Icon(
                  Icons.settings,
                  size: 30,
                  color: Colors.white70,
                  ),
                onSelected: (value) {
                  _onMenuItemSelectedRPM(value as double);
                },
                itemBuilder: (ctx) => [
                  _buildPopupMenuItemRPM('Font Size - Small', Icons.arrow_downward, Options.small.index as double),
                  _buildPopupMenuItemRPM('Font Size - Medium', Icons.arrow_forward, Options.medium.index as double),
                  _buildPopupMenuItemRPM('Font Size - Big', Icons.arrow_upward, Options.big.index as double),
                  _buildPopupMenuItemRPM('Exit', Icons.exit_to_app, Options.exit.index as double),
                ],
              )   // Callback that sets the selected popup menu ite
            ),
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
                      axisLineStyle: AxisLineStyle(thickness: custWidgetSize, color: Colors.white70),
                      axisLabelStyle: GaugeTextStyle(fontSize: custSizeRPM, color: Colors.yellow),
                      minorTickStyle: MinorTickStyle(color: Colors.grey[600]),
                      majorTickStyle: MajorTickStyle(color: Colors.white70),
                      radiusFactor: 0.8,
                      pointers: <GaugePointer>[
                        RangePointer(
                          value: revolutionsPointerValue,
                          width: custWidgetSize,
                          color: Colors.yellow,
                        )
                      ],
                      annotations: <GaugeAnnotation>[
                        GaugeAnnotation(
                            widget: Container(
                                child: Text(
                                    'rpm'.toString(), //noch ändern zu current value
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold))),
                            angle: 90,
                            positionFactor: 0.5),
                        //add more annotations 'texts inside guage' here
                      ]
                      //add more annotations 'texts inside guage' here
                      )
                ]),
          ],
        ),
        
        Column( // tank refill and stop button
          children: [
            
            Container( // refill Tank button
              padding: EdgeInsets.fromLTRB(100, 100, 100, 20),
              child: Listener(
                onPointerDown: (details) {
                  _buttonPressed = true;
                  _notButtonPressed = false;
                  _increaseTankPointerValueWhilePressed();
                },
                onPointerUp: (details) {
                  _buttonPressed = false;
                  _notButtonPressed = true;
                  _stopRefillTank();
                 },
                child: Container(
                  decoration:
                      BoxDecoration(
                        color: Colors.grey[600],
                        border: Border.all(width: 2, color: Colors.white70),
                        borderRadius: BorderRadius.circular(10)
                        ),
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'refill tank',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),

            Container( // stop button
            padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
            child: SizedBox(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey[600], // Background color
                  ),
                  child: Text(
                    'stop',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  // onPressed: null,
                  onPressed: () => _stop(),
                ))),
        
          ],
        ),
        
        Row( // Tacho
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: PopupMenuButton(
                child: Icon(
                  Icons.settings,
                  size: 30,
                  color: Colors.white70,
                  ),
                onSelected: (value) {
                  _onMenuItemSelectedKMH(value as double);
                },
                itemBuilder: (ctx) => [
                  _buildPopupMenuItemKMH('Font Size - Small', Icons.arrow_downward, Options.small.index as double),
                  _buildPopupMenuItemKMH('Font Size - Medium', Icons.arrow_forward, Options.medium.index as double),
                  _buildPopupMenuItemKMH('Font Size - Big', Icons.arrow_upward, Options.big.index as double),
                  _buildPopupMenuItemKMH('Exit', Icons.exit_to_app, Options.exit.index as double),
                ],
              )   // Callback that sets the selected popup menu ite
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
                      axisLineStyle: AxisLineStyle(thickness: custWidgetSize, color: Colors.white70,),
                      axisLabelStyle: GaugeTextStyle(fontSize: custSizeKMH, color: Colors.yellow,),
                      minorTickStyle: MinorTickStyle(color: Colors.grey[600]),
                      majorTickStyle: MajorTickStyle(color: Colors.white70),
                      radiusFactor: 0.8,
                      pointers: <GaugePointer>[
                        RangePointer(
                          value: tachoPointerValue,
                          width: custWidgetSize,
                          color: Colors.yellow,
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
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.bold))),
                            angle: 90,
                            positionFactor: 0.5),
                        //add more annotations 'texts inside guage' here
                      ])
                ]),
          ],
        ),
        
        Column( // Clock and reset button
          children: [
            Container( // Clock
            padding: EdgeInsets.fromLTRB(100, 150, 100, 20),
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
                      color: Colors.white70, // time
                      fontSize: 50,
                    ),
                    amPmDigitTextStyle: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Container( //reset button    
                padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                child: SizedBox(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[600], // Background color
                      ),
                      child: Text(
                        'reset',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                      // onPressed: null,
                      onPressed: () => _reset(),
                    ))),
          ],
        ),
        
        Container( // gas button
          padding: EdgeInsets.fromLTRB(100, 20, 100, 20),

          child: Listener(
            onPointerDown: (details) {
              _buttonPressed = true;
              _notButtonPressed = false;
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
                    color: Colors.grey[800],
                    border: Border.all(width: 5, color: Colors.white70),
                    borderRadius: BorderRadius.circular(30),
                    ),
              padding: EdgeInsets.all(16.0),
              child: Text(
                'accelerate',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ),
        ),
        
        Row( // tank bar
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: PopupMenuButton(
                child: Icon(
                  Icons.settings,
                  size: 30,
                  color: Colors.white70,
                  ),
                onSelected: (value) {
                  _onMenuItemSelectedTank(value as double);
                },
                itemBuilder: (ctx) => [
                  _buildPopupMenuItemTank('Font Size - Small', Icons.arrow_downward, Options.small.index as double),
                  _buildPopupMenuItemTank('Font Size - Medium', Icons.arrow_forward, Options.medium.index as double),
                  _buildPopupMenuItemTank('Font Size - Big', Icons.arrow_upward, Options.big.index as double),
                  _buildPopupMenuItemTank('Exit', Icons.exit_to_app, Options.exit.index as double),
                ],
              )   // Callback that sets the selected popup menu ite
            ),

            Container( // Gas Staion Icon
              padding: EdgeInsets.fromLTRB(110, 20, 0, 62),
              alignment: Alignment.bottomRight,
              child: Icon(
                Icons.local_gas_station_sharp,
                size: 40,
                color: Colors.white70,
              ),
            ),

            Container( // Tank Level
              child: Center(
                child: SizedBox(
                  height: 250,
                  width: 100,
                  child: SfLinearGauge(
                    interval: 25,
                    orientation: LinearGaugeOrientation.vertical,
                    axisTrackStyle: LinearAxisTrackStyle(thickness: custWidgetSize-10, color: Colors.white70),
                    axisLabelStyle: TextStyle(fontSize: custSizeTank, color: Colors.yellow),
                    minorTickStyle: LinearTickStyle(color: Colors.grey[600]),
                    majorTickStyle: LinearTickStyle(color: Colors.white70),
                    barPointers: [
                      LinearBarPointer(
                        value: tankPointerValue,
                        thickness: custWidgetSize-10,
                        color: Colors.yellow,
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
