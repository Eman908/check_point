import 'package:check_point/core/utils/padding_extension.dart';
import 'package:check_point/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class StuffTab extends StatelessWidget {
  const StuffTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const CustomTextFormField(hintText: 'Search', prefix: Icons.search),
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder:
                  (context, index) => const Divider(color: Colors.black12),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const CircleAvatar(backgroundColor: Colors.black),
                  title: const Text('UserName'),
                  subtitle: const Text('Email'),
                  trailing: TextButton(
                    onPressed: () {},
                    child: const Icon(Icons.delete),
                  ),
                );
              },
            ),
          ),
        ],
      ).horizontalPadding(16),
    );
  }
}
