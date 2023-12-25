import 'package:whatsupclone/utils/export.dart';

showLoadingDialog({required BuildContext context, required String message}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const CircularProgressIndicator(color: Color(0xFF00A884)),
                const SizedBox(
                  width: 16.0,
                ),
                Text(message)
              ],
            )
          ],
        ),
      );
    },
  );
}
