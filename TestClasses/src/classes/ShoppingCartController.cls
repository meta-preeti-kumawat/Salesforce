public class ShoppingCartController {
	public Map<Id, Product__c> productMap;
    public Purchase_Order__c order { get; set;}
    public Boolean isProductAvailableInCart{get; set;}
    public Boolean isProductAvailableInStore{get; set;}
    public Map<Id,PurchaseOrderLineItem__c> cartMap;
    public Integer numberOfProducts { get; set;}
    public Decimal totalCost { get; set;}
    public boolean isEditable {get; set;}
    
    public Id previousCartProductId { get; set;}
    public Id cartProductId { get; set;}
    
    public ShoppingCartController(ApexPages.StandardController stdController){
        hide();
        isEditable = false;
        order = new Purchase_Order__c();
        cartMap = new Map<Id, PurchaseOrderLineItem__c>();
    }
    
    public List<Product__c> getAllProducts() {
        return productMap.values();
    }
    public List<PurchaseOrderLineItem__c> getProductsInCart() {
        return cartMap.values();
    }
    public PageReference createOrder(){
        productMap = new ProductsSelector().selectAllAsMap();
        if(productMap.size() > 0){
            isProductAvailableInStore = true;
        }
        numberOfProducts = 0;
        totalCost = 0;
        return null;
    }
    /*this method disable the view of editing the object*/
    public void hide() {
        isProductAvailableInCart = false;
    }
   
    public void deleteProductFromCart(){
        if(cartMap.containsKey(cartProductId)){
            productMap.put(cartProductId, cartMap.get(cartProductId).Product__r);
            isProductAvailableInStore = true;
            totalCost = totalCost - cartMap.get(cartProductId).Total_Price__c;
            cartMap.remove(cartProductId);
            numberOfProducts = cartMap.size();
            
            if( numberOfProducts == 0){
	            isProductAvailableInCart = false;
                totalCost = 0;
            }
        }
    }
    public void updateProductInCart(){
        isEditable = false;
        if(cartMap.containsKey(cartProductId)){
            if(validateQuantity(cartMap.get(cartProductId).Quantity__c)){
            	totalCost = totalCost - cartMap.get(cartProductId).Total_Price__c;
                PurchaseOrderLineItem__c productInCart = cartMap.get(cartProductId).clone(true, true, true, true);
                productInCart.Total_Price__c = productInCart.Quantity__c * productInCart.Product__r.Price__c;
                cartMap.put(cartProductId, productInCart);
                totalCost = totalCost + productInCart.Total_Price__c;
            }
            else{
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Quantity "'+ cartMap.get(cartProductId).Quantity__c +'" is not valid'));
            }
        }
    }
    public Boolean validateQuantity(Decimal quantity){
        if(quantity.round(System.roundingMode.DOWN) == quantity){
            return true;
        }
        else{
            return false;
        }
    }
    public void resetQuantity(){
        savePreviousChanges();
        isEditable = false;
        if(cartMap.containsKey(cartProductId)){
            totalCost = totalCost - cartMap.get(cartProductId).Total_Price__c;
            PurchaseOrderLineItem__c productInCart = cartMap.get(cartProductId).clone(true, true, true, true);
            productInCart.Quantity__c = 1;
            productInCart.Total_Price__c = productInCart.Quantity__c * productInCart.Product__r.Price__c;
            cartMap.put(cartProductId, productInCart);
            totalCost = totalCost + productInCart.Total_Price__c;
        }
    }
    public void addProductToCart(){
        Id productId = ApexPages.currentPage().getParameters().get('productId');
        if(productMap.containsKey(productId)){
            PurchaseOrderLineItem__c productInCart = new PurchaseOrderLineItem__c(
                PurchaseOrder__c = order.Id, 
                Product__r = productMap.get(productId),
                Quantity__c = 1,
                Total_Price__c = productMap.get(productId).Price__c
            );
            cartMap.put(productId, productInCart);
            numberOfProducts = cartMap.size();
            totalCost = totalCost + productInCart.Total_Price__c;
            productMap.remove(productId);
            isProductAvailableInCart = true;
            if(productMap.size() == 0){
                 isProductAvailableInStore = true;
            }
        }
    }
    
    public PageReference checkout(){
        insert order;
        if(!String.isBlank(order.Id)){
            for(PurchaseOrderLineItem__c orderLineItem: cartMap.values()){
                orderLineItem.PurchaseOrder__c = order.Id;
                orderLineItem.Product__c = orderLineItem.Product__r.Id;
            }
            insert cartMap.values();
        }
        return redirectToHome();
    }
    public PageReference cancel(){
        return redirectToHome();
    }
    public PageReference redirectToHome(){
        PageReference homePage = Page.PurchaseOrdersHomePage;
        homePage.setRedirect(true);
        return homePage;
    }
    public void changeEditMode(){
        if(isEditable){
            savePreviousChanges();
        }
        isEditable = isEditable ? false: true;
        previousCartProductId = cartProductId;
    }
    public void savePreviousChanges(){
        if(previousCartProductId != null && previousCartProductId != cartProductId){
            Id newcartProductId = cartProductId;
            cartProductId = previousCartProductId;
            updateProductInCart();
            cartProductId = newcartProductId;
        }
    }
}