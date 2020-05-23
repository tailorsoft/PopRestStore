<#include "../product/listing.ftl"/>

<#assign crossSells = ec.service.sync().name("popstore.ProductServices.get#ProductAssocAndDetails")
        .parameter("productId", product.productId).parameter("assocType", "PatCrossSell")
        .parameter("productStoreId", storeInfo.productStore.productStoreId).call()>

<div class="col-lg-12 col-md-12">
    <div class="related-products-area">
        <div class="container">
            <div class="section-title">
                <h2><span class="dot"></span> Related Products</h2>
            </div>
            <div class="row">
                <#list crossSells.products as assoc >
                    <div class="col-lg-3 col-md-6 col-sm-6">
                        <#assign imgLarge = assoc.content?filter(x -> x.productContentTypeEnumId == "PcntImageLarge")?first />
    
                        <@productlisting assoc.product.toProductId assoc.product.productName imgLarge.productContentId assoc.prices.price assoc.prices.listPrice  />
                    </div>
                </#list>
            </div>
        </div>
    </div>
</div>