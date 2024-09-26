import 'dart:collection';

import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_controller.dart';
class FilterWidget extends StatelessWidget {
  final String title;
  final Function(String) onFilterSelected;
  FilterWidget({
    required this.title,
    required this.onFilterSelected,
  });
  @override
  Widget build(BuildContext context) {
    HashSet<String> filters = context.watch<UserController>().users;
    HashSet<String> selectedUserList = context.read<UserController>().selectedUsers;

    return FilterListWidget<String>(
      themeData: FilterListThemeData(context,
      backgroundColor: Colors.white,
        borderRadius: 20,

      ),
      maximumSelectionLength: filters.length,
      listData: filters.toList(),
      selectedListData: selectedUserList.toList(),
      onApplyButtonClick: (list) {
          context.read<UserController>().setSelectedList(list??[]);
      },
      choiceChipLabel: (item) {
        /// Used to display text on chip
        return item;
      },
      hideHeader: false,
      hideSearchField: true,
      hideSelectedTextCount: true,
      validateSelectedItem: (list, val) {
        /// Identify if item is selected or not
        return list!.contains(val);
      },
      onItemSearch: (user, query) {
        /// When search query change in search bar then this method will be called
        ///
        /// Check if items contains query
        return user.toLowerCase().contains(query.toLowerCase());
      },
    );
  }
}