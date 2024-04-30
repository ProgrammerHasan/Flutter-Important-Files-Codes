import 'package:app/controllers/api/flight_controller.dart';
import 'package:app/models/flight.dart';
import 'package:flutter/foundation.dart';

class ModalBottomSheet extends StatelessWidget {
  const ModalBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  _showModalBottomSheet(BuildContext context, {required String title, required Widget child}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.transparent,
      elevation: 0,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.colorScheme.background
              ),
              constraints: const BoxConstraints(
                minHeight: 200,
              ),
              child: SingleChildScrollView(
                child: IntrinsicHeight(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 0,
                      ),
                      child: Column(
                        children: [

                        ],
                      ),
                    )
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}