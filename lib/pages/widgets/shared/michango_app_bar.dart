import 'package:flutter/material.dart';
import 'package:michango/models/event.dart';
import 'package:michango/services/event_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MichangoAppBar extends StatelessWidget implements PreferredSizeWidget {
  //Future final <List<Event>> _events;
  //_events=EventService().getEvents();

  @override
  Size get preferredSize => const Size.fromHeight(50);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: EventsDropDownButton()),
    );
  }
}

class EventsDropDownButton extends StatefulWidget {
  //const EventsDropDownButton({ Key? key }) : super(key: key);

  @override
  _EventsDropDownButtonState createState() => _EventsDropDownButtonState();
}

class _EventsDropDownButtonState extends State<EventsDropDownButton> {
  //Future <List<Event>> _events;
  String dropdownValue;
  Future<List<Event>> _events;

  @override
  void initState() {
    super.initState();
    _events = EventService().getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _events,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dropdownValue =
                snapshot.data.length > 0 ? snapshot.data[0].id : 'No Event';  
            _setCurrentEvent(snapshot.data[0].id);
            
            return Container(
              child: Theme(
                data: Theme.of(context).copyWith(canvasColor: Colors.cyan[600]),
                child: DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  ),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.w200,
                      fontFamily: 'Encode Sans'),
                  /*    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ), */
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                      _setCurrentEvent(newValue);
                    });
                  },
                  items: snapshot.data
                      .map<DropdownMenuItem<String>>((Event event) {
                    return DropdownMenuItem<String>(
                      value: event.id,
                      child: Text(event.name),
                    );
                  }).toList(),
                ),
              ),
            );
          } else {
            return SizedBox(child: new CircularProgressIndicator());
          }
        });
  }

  _setCurrentEvent(eventId) async {
    print(eventId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('currentEventId', eventId);
  }
}
