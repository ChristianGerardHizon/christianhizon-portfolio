class EndPoints {
  /* 

      Authentication EndPoints

   */
  static String get login => '/api/collections/users/auth-with-password';
  static String get refreshToken => '/api/collections/users/auth-refresh';

  /*

    Users Endpoints

  */

  static String get users => '/api/collections/users/records';

  /* 
  
    Store Endpoints
  
   */

  static String get stores => '/api/collections/stores/records';

  /* 
  
    Product Endpoints
  
   */
  static String get products => '/api/collections/products/records';

  /* 

    Orders Endpoints
  
   */
  static String get orders => '/api/collections/orders/records';

  /* 

    categories Endpoints
  
   */
  static String get categories => '/api/collections/categories/records';

  /*


      reviews


  */
  static String get reviews => '/api/collections/reviews/records';

  /* 

    Bids Endpoints
  
   */
  static String get bids => '/api/collections/bids/records';

  /* 

  Seller Application Endpoints

  */
  static String get sellerApplications =>
      '/api/collections/applications/records';

  /* 

    Tags Endpoints
  
   */
  static String get tags => '/api/collections/tags/records';
}
