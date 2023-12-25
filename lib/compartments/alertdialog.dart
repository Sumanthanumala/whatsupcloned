import 'package:whatsupclone/utils/export.dart';

showalertdialog({required BuildContext context, required String message}) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return  AlertDialog(
        title:
            const Text('Alert', style: TextStyle(fontWeight: FontWeight.bold)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Text(message, style: const TextStyle(fontSize: 16)),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('OK'))
        ],
      );
    },
  );
}
