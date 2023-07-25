import 'package:app/controllers/api/flight_controller.dart';
import 'package:app/models/flight.dart';
import 'package:flutter/foundation.dart';

class SimpeDynamicPaginationPage extends StatefulWidget {
  const SimpeDynamicPaginationPage({Key? key}) : super(key: key);

  @override
  State<SimpeDynamicPaginationPage> createState() => _SimpeDynamicPaginationPageState();
}

class _SimpeDynamicPaginationPageState extends State<FlightCreatePage> {
  FlightController flightController = FlightController();

  int currentPage = 1; // Current page number
  List<Flight> flights = []; // List to store fetched data

  @override
  void initState() {
    super.initState();
    fetchFlights(currentPage); // Initial API call
  }

  Future<void> fetchFlights(int page) async {
    try {
      final newFlights = await flightController.getFlights(page);
      setState(() {
        if (page == 1) {
          flights = newFlights;
        } else {
          flights.addAll(newFlights);
        }
      });
    } catch (e) {
      // Handle error
      if (kDebugMode) {
        print(e);
      }
    }
  }
  
  void loadNextPage() {
    currentPage++;
    fetchFlights(currentPage);
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: const Text("Simple Paigination",style: TextStyle(color:Colors.white),textAlign: TextAlign.center),
      ),
      body: ListView.builder(
            itemCount: flights.length + 1, // Add one for the "Next Page" button
            itemBuilder: (context, index) {
              if (index < flights.length) {
                final flight = flights[index];
                return ListTile(
                  title: Text(flight.flightDate),
                  subtitle: Text('Departure: ${flight.flightDate}, Arrival: ${flight.flightDate}'),
                );
              } else if (index == flights.length) {
                return ElevatedButton(
                  onPressed: loadNextPage,
                  child: Text('Next Page'),
                );
              } else {
                return null;
              }
            },
          ),
    );
  }

}
