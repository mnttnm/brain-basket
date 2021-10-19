window.initiatePayment = (options) => {
  console.log('calling payment', options);
  var rzp1 = new Razorpay(options);
  rzp1.open();
};
