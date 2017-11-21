@isTest
private class TestShoppingCartController {
	private static ShoppingCartController controller;
    @testSetup
    static void setup(){
        List<Product__c> listOfProducts = new List<Product__c>();
        For(Integer count = 0; count < 10; count++){
            Product__c product = new Product__c(Name = 'Product'+count, Product_Code__c = 'PR-'+count, Price__c = count * 10 + 1 );
        	listOfProducts.add(product);
        }   
        insert listOfProducts;
    }
    static void initialSetupForController(){
        Purchase_Order__c order = new Purchase_Order__c();
        ApexPages.StandardController stdController = new ApexPages.StandardController(order);
        controller = new ShoppingCartController(stdController);
        Contact customer = new Contact(LastName = 'customer1');
        insert customer;
        controller.order.Customer__c = customer.Id;
        controller.createOrder();
        
        PageReference pageRef = Page.ShoppingCart;
        Test.setCurrentPage(pageRef);
    }
    @isTest
    static void testToCreateOrder(){
        initialSetupForController();
        System.assertEquals(10, controller.getAllProducts().size());
        System.assert(controller.getProductsInCart().size() == 0);
    }
    @isTest
    static void testToAddProductToCart(){
        initialSetupForController();
        List<Product__c> listOfProducts = [SELECT Id, Name, Product_Code__c, Price__c FROM Product__c WHERE Name LIKE 'Product%'];
        for(Integer count = 0; count < 10; count++){
            Id productId = listOfProducts[count].id;
            ApexPages.currentPage().getParameters().put('productId', productId);
            controller.addProductToCart();
            System.assert(controller.cartMap.containsKey(productId));
        }
    }
    @isTest
    static void testToDeleteProductFromCart(){
        initialSetupForController();
        List<Product__c> listOfProducts = [SELECT Id, Name, Product_Code__c, Price__c FROM Product__c WHERE Name LIKE 'Product%'];
        for(Integer count = 0; count < listOfProducts.size(); count++){
            Id productId = listOfProducts[count].id;
            ApexPages.currentPage().getParameters().put('productId', productId);
            controller.addProductToCart();
            System.assert(controller.cartMap.containsKey(productId));
        }
        for(Integer count = 0; count < listOfProducts.size(); count++){
            Id cartProductId = listOfProducts[count].Id;
            controller.cartProductId = cartProductId;    
            controller.deleteProductFromCart();
			System.assert(!controller.cartMap.containsKey(cartProductId));
        }
    }
    @isTest
    static void testToUpdateProductInCart(){
        initialSetupForController();
        List<Product__c> listOfProducts = [SELECT Id, Name, Product_Code__c, Price__c FROM Product__c WHERE Name LIKE 'Product%'];
        for(Integer count = 0; count < listOfProducts.size(); count++){
            Id productId = listOfProducts[count].id;
            ApexPages.currentPage().getParameters().put('productId', productId);
            controller.addProductToCart();
            System.assert(controller.cartMap.containsKey(productId));
        }
        Id cartProductId = listOfProducts[0].Id;
        controller.cartProductId = cartProductId;    
        controller.cartMap.get(cartProductId).Quantity__c = 5;
        controller.updateProductInCart();
        System.assertEquals(5, controller.cartMap.get(cartProductId).Quantity__c);
    }
    @isTest
    static void testToUpdateProductInCartNegativeCase(){
        initialSetupForController();
        List<Product__c> listOfProducts = [SELECT Id, Name, Product_Code__c, Price__c FROM Product__c WHERE Name LIKE 'Product%'];
        for(Integer count = 0; count < listOfProducts.size(); count++){
            Id productId = listOfProducts[count].id;
            ApexPages.currentPage().getParameters().put('productId', productId);
            controller.addProductToCart();
            System.assert(controller.cartMap.containsKey(productId));
        }
        Id cartProductId = listOfProducts[0].Id;
        controller.cartProductId = cartProductId;    
        controller.cartMap.get(cartProductId).Quantity__c = 5.5;
        controller.updateProductInCart();
        List<Apexpages.Message> msgs = ApexPages.getMessages();
        boolean isError = false;
        for(Apexpages.Message msg:msgs){
            if (msg.getDetail().contains('Quantity "'+ controller.cartMap.get(cartProductId).Quantity__c +'" is not valid')){
                isError = true;
            } 
        }
        system.assert(isError);
    }
    
    @isTest
    static void testToResetProductQuantity(){
        initialSetupForController();
        List<Product__c> listOfProducts = [SELECT Id, Name, Product_Code__c, Price__c FROM Product__c WHERE Name LIKE 'Product%'];
        for(Integer count = 0; count < listOfProducts.size(); count++){
            Id productId = listOfProducts[count].id;
            ApexPages.currentPage().getParameters().put('productId', productId);
            controller.addProductToCart();
            System.assert(controller.cartMap.containsKey(productId));
        }
        Id cartProductId = listOfProducts[0].Id;
        controller.cartProductId = cartProductId;   
        controller.changeEditMode();
        controller.cartMap.get(cartProductId).Quantity__c = 5;
        System.assertEquals(5, controller.cartMap.get(cartProductId).Quantity__c);
        cartProductId = listOfProducts[1].Id;
        controller.cartProductId = cartProductId;   
        controller.changeEditMode();
        controller.cartMap.get(cartProductId).Quantity__c = 5;
        controller.resetQuantity();
        System.assertEquals(1, controller.cartMap.get(cartProductId).Quantity__c);
    }
    @isTest
    static void testToCheckout(){
        initialSetupForController();
        List<Product__c> listOfProducts = [SELECT Id, Name, Product_Code__c, Price__c FROM Product__c WHERE Name LIKE 'Product%'];
        for(Integer count = 0; count < listOfProducts.size(); count++){
            Id productId = listOfProducts[count].id;
            ApexPages.currentPage().getParameters().put('productId', productId);
            controller.addProductToCart();
            System.assert(controller.cartMap.containsKey(productId));
        }
        System.assertEquals(Page.PurchaseOrdersHomePage.getUrl(), controller.checkout().getUrl());
    }
    @isTest
    static void testCancelMethod(){
        initialSetupForController();
        System.assertEquals(Page.PurchaseOrdersHomePage.getUrl(), controller.cancel().getUrl());
    }
}