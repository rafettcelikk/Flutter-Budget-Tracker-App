import 'package:flutter/material.dart';
import 'package:flutter_budget_tracker_app/modules/transaction/controllers/category_controller.dart';
import 'package:flutter_budget_tracker_app/utils/icon_helper.dart';
import 'package:get/get.dart';

class AddCategoryDialog extends StatelessWidget {
  const AddCategoryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<CategoryController>(CategoryController());
    return AlertDialog(
      title: Text(
        "Kategori Ekle",
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Kategori Adı",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.category_outlined),
              ),
              onChanged: (value) => controller.categoryName.value = value,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Lütfen bir kategori adı girin.";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Obx(
              () => DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: "Simge Seçin",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.image_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Lütfen bir simge seçin.";
                  }
                  return null;
                },
                items: icons
                    .map(
                      (icon) =>
                          DropdownMenuItem(value: icon, child: Text(icon)),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    controller.selectedIcon.value = value;
                  }
                },
                initialValue: controller.selectedIcon.value,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Iptal"),
                ),
                Obx(
                  () => ElevatedButton(
                    onPressed: () {
                      controller.isLoading ? null : controller.createCategory();
                    },
                    child: controller.isLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text("Kaydet"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
