import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/inquiryProvider.dart';
import 'listpage.dart';
import '../model/torque.dart';
import '../commonComponents/mainscaffold.dart';

class ListPageState extends State<ListPage> {
  int _rowsPerPage = 10;
  int _startIndex = 0;
  late Torque torque;



  TextEditingController controller = TextEditingController();

  final List<DataColumn> _columns = [
    const DataColumn(label: Expanded(child: Center(child: Text('Car Mark')))),
    const DataColumn(label: Expanded(child: Center(child: Text('Car Number')))),
    const DataColumn(label: Expanded(child: Center(child: Text('Car Status')))),
    const DataColumn(label: Expanded(child: Center(child: Text('Priority')))),
    const DataColumn(label: Expanded(child: Center(child: Text('Shop')))),
    const DataColumn(
        label: Expanded(child: Center(child: Text('Submitted By')))),
    const DataColumn(label: Expanded(child: Center(child: Text('Action')))),

  ];


  String _searchResult = '';


  @override
  void initState() {
    super.initState();
    context.read<Inquiry>().getInquiryList("token", "network");
  }

  @override
  Widget build(BuildContext context) {
    final _provider = context.watch<Inquiry>();
    final _model = _provider.inquiryList;

    print(_searchResult);


    if (_model?.inquiryList == null) {
      return const SizedBox.shrink();
    }

    final torque = Torque(_model!,context);

    return MainScaffold(
        route: '/list',
        value: 'User',
        body: Column(
          children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                  Expanded(
                  child: Padding(
                  padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        controller: controller,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          suffixIcon: InkWell(
                            child: Icon(Icons.search),
                          ),
                          contentPadding: EdgeInsets.all(15.0),
                          hintText: 'Search ',
                        ),

                          onChanged: (value) {
                            setState(() {
                              _searchResult = value;
                            });

                          },
                        ),
                      ),
                      ),

                        IconButton(
                          onPressed: () {
                            setState(() {
                              controller.clear();
                              _searchResult = '';
                        });
                            // source.filterServerSide(searchController.text);
                        },
                              icon: Icon(Icons.clear),
                ),
    ],

        ),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: PaginatedDataTable(
                      columns: _columns,
                      source: torque,
                      onPageChanged: (int startIndex) {
                        setState(() {
                          _startIndex = startIndex;
                        });
                      },
                      rowsPerPage: _rowsPerPage,
                      availableRowsPerPage: const [10, 50, 100],
                      onRowsPerPageChanged: (int? updatedRowsPerPage) {
                        if (updatedRowsPerPage != null) {
                          setState(() {
                            _rowsPerPage = updatedRowsPerPage;
                          });
                        }
                      },
                      showCheckboxColumn: true,
                      dataRowMinHeight: 30,
                      dataRowMaxHeight: 40,
                      columnSpacing: 40,
                      initialFirstRowIndex: 0,
                      showFirstLastButtons: true,
                      header: const Text('Items'),

                    ))),
          ],
        ));
  }
}
