const BooksPageRoute = "Books";
const AuthorsPageRoute = "Authors";
const ContactPageRoute = "Contact Us";
const CartPageRoute = "Cart";
const PaymentsPageRoute = "Payment";
const CheckOutPageRoute = "Checkout";
const OrderSuccessPageRoute = "Order Success";

String getPathStrForRoute(String route) {
  return '/' + route.replaceAll(' ', '').toLowerCase();
}

List sideMenuItems = [
  BooksPageRoute,
  AuthorsPageRoute,
  ContactPageRoute,
];
