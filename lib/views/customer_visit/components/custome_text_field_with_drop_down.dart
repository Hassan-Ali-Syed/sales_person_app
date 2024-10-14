import 'package:flutter/material.dart';
import 'package:sales_person_app/constants/constants.dart';
import 'package:sales_person_app/extensions/context_extension.dart';

class CustomTextFieldWithDropdown extends StatefulWidget {
  final List<String> dropDownItems;
  final String hintText;
  final String seachHintText;
  final String createMessage;
  final VoidCallback? onSubmitted;
  final VoidCallback onTapMethod;
  final bool boolValue;

  const CustomTextFieldWithDropdown({
    super.key,
    required this.dropDownItems,
    required this.hintText,
    required this.createMessage,
    required this.seachHintText,
    this.onSubmitted,
    required this.onTapMethod,
    required this.boolValue,
  });

  @override
  State<CustomTextFieldWithDropdown> createState() =>
      _CustomTextFieldWithDropdownState();
}

class _CustomTextFieldWithDropdownState
    extends State<CustomTextFieldWithDropdown> {
  bool _isExpanded = false;
  bool _isSearch = false;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<String> filteredDropDown = [];
  String? selectedDropDown;

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isExpanded
        ? Container(
            height: Sizes.HEIGHT_250,
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _isSearch
                        ? Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                labelText: widget.seachHintText,
                                hintText: widget.seachHintText,
                                border: const UnderlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.search),
                                  onPressed: () {
                                    setState(() {
                                      filteredDropDown = widget.dropDownItems
                                          .where((filteredData) => filteredData
                                              .toLowerCase()
                                              .contains(_searchController.text
                                                  .toLowerCase()))
                                          .toList();
                                      _isSearch == false;
                                    });
                                  },
                                ),
                              ),
                            ),
                          )
                        : Text(
                            widget.seachHintText,
                            style: context.bodyLarge,
                          ),
                    Row(
                      children: [
                        _isSearch
                            ? const SizedBox.shrink()
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSearch = true;
                                  });
                                },
                                child: const Icon(Icons.search),
                              ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = false;
                            });
                          },
                          child: const Icon(
                            Icons.arrow_drop_up,
                            size: Sizes.WIDTH_40,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: _scrollController,
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: filteredDropDown.isNotEmpty
                          ? filteredDropDown.length
                          : widget.dropDownItems.length,
                      itemBuilder: (context, index) {
                        final filteredData = filteredDropDown.isNotEmpty
                            ? filteredDropDown[index]
                            : widget.dropDownItems[index];
                        return ListTile(
                          title: Text(filteredData),
                          onTap: () {
                            setState(() {
                              selectedDropDown = filteredData;
                              _isExpanded = false;
                              _searchController.clear();
                              filteredDropDown.clear();
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            Text(
                              widget.createMessage,
                              style: context.bodyLarge,
                            ),
                            const Icon(Icons.add),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(
              top: Sizes.PADDING_8,
            ),
            child: TextField(
              controller: TextEditingController(text: selectedDropDown),
              textAlign: TextAlign.left,
              onSubmitted: (value) {
                setState(() {
                  widget.onSubmitted!();
                });
              },
              // onChanged: (value) => widget.onSubmitted,
              decoration: InputDecoration(
                hintText: widget.hintText,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isExpanded = true;
                      filteredDropDown.clear();
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    size: Sizes.WIDTH_30,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
  }
}
