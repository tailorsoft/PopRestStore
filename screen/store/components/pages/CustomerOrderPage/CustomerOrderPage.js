var CustomerOrderPage = {
  name: "customerorder-page",
  data() {
    return {
      ordersList:[],
      orderList:{},
      axiosConfig: {
        headers: {
          "Content-Type": "application/json;charset=UTF-8",
          "Access-Control-Allow-Origin": "*",
          "api_key":storeInfo.apiKey,
          "moquiSessionToken":storeInfo.moquiSessionToken
        }
      }
    };
  },
  methods: {
    getCustomerOrders() {
      CustomerService.getCustomerOrders(this.axiosConfig).then(data => {
        this.ordersList = data.orderInfoList;
      });
    },
    getCustomerOrderById() {
      CustomerService.getCustomerOrderById("100000",this.axiosConfig).then(data => {
        this.orderList = data;
      });
    },
    formatDate(date) {
      var monthNames = [
        "January", "February", "March",
        "April", "May", "June", "July",
        "August", "September", "October",
        "November", "December"
      ];
      var date = new Date(date);
      var day = date.getDate();
      var monthIndex = date.getMonth();
      var year = date.getFullYear();
      return day + ' ' + monthNames[monthIndex] + ', ' + year;
    }
  },
  mounted() {
    this.getCustomerOrderById();
  }
};
var CustomerOrderPageTemplate = getPlaceholderRoute(
  "./components/pages/CustomerOrderPage/CustomerOrderPage.html",
  "CustomerOrderPage"
);
