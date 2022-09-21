import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../layout/Shop_App/cubit.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  required function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );


Widget defaultFormField({
  TextEditingController? controller,
  TextInputType? type,
  onSubmit,
  onChange,
  onTap,
  bool isPassword = false,
  validate,
  required String? label,
  String? hint,
  IconData? prefix,
  IconData? suffix,
  suffixPressed,
   double raduis=20,
  bool isClickable = true,
  IconData? prefixIcon,
  IconData? suffixIcon,
  Null Function(dynamic value)? onFieldSubmitted,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          color: Colors.grey,
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
          raduis,
        )),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);
void showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
      msg: msg,
      fontSize: 15,
      backgroundColor: chooseToastColor(state),
      timeInSecForIosWeb: 5,
      textColor: Colors.white,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
Widget buildListProduct(model, BuildContext context,
        {bool isOldPrice = true}) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                height: 100.0,
                width: 100,
                fit: BoxFit.cover,
              ),
              if (model.discount != 0 && isOldPrice)
                Container(
                  width: 70,
                  color: Colors.red,
                  child: const Text(
                    'Discount',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                )
            ],
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Container(
              alignment: AlignmentDirectional.topStart,
              color: Colors.white,
              child: Column(
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text('${model.price}',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 20,
                      ),
                      if (model.discount != 0 && isOldPrice)
                        Text('${model.oldPrice}',
                            style: TextStyle(
                                decoration: TextDecoration.lineThrough)),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                        },
                        icon: ShopCubit.get(context).favorites[model.id] as bool
                            ? Icon(
                                Icons.favorite,
                                size: 25,
                                color: Colors.red,
                              )
                            : Icon(
                                Icons.favorite_border,
                                size: 25,
                                color: Colors.grey,
                              ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.yellow;
      break;
  }
  return color;
}
