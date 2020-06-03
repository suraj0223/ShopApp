import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../products_provide.dart/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  const OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(7),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.shopping_cart,
                size: 35,
              ),
              backgroundColor: Colors.lightGreenAccent,
              foregroundColor: Colors.blueAccent,
            ),
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(
              DateFormat('dd/MM/yyyy/hh:mm').format(widget.order.dateTime),
            ),
            trailing: IconButton(
              icon: Icon(
                _expanded ? Icons.expand_less : Icons.expand_more,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          // if (_expanded)
            AnimatedContainer(
              duration: Duration(milliseconds: 600),
              height: _expanded ? min(widget.order.products.length * 20.0 + 30, 100) : 0,
              child: ListView.builder(
                itemBuilder: (BuildContext ctx, int index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${widget.order.products[index].title}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${widget.order.products[index].quantity}  X   \$${widget.order.products[index].price}',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        )
                      ],
                    ),
                  );
                },
                itemCount: widget.order.products.length,
              ),
            ),
        ],
      ),
    );
  }
}
