public with sharing class ProductHelper {
    public static Map<String, Product2> getProductsByName(Set<String> productsName) {
        Map<String, Product2> productsByName = new Map<String, Product2>();
        // Builds productsByName to be able to search Products based on Name
        for(Product2 product : [SELECT Name FROM Product2 WHERE Name LIKE : productsName]) {
            productsByName.put(product.Name, product);
        }
        return productsByName;
}   }