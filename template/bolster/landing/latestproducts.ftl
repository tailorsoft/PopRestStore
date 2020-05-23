<#include "../product/listing.ftl"/>

<#if storeInfo.categoryByType.PsctNewProducts?has_content>
    <#assign category = storeInfo.categoryByType.PsctNewProducts >
    <#assign products = ec.service.sync().name("popstore.ProductServices.get#CategoryProducts")
        .parameter("productCategoryId", category.productCategoryId).parameter("pageSize", 8).call()>
    <div>
        <!-- Start All Products Area -->
        <section class="all-products-area pb-60">
            <div class="container">
                <div class="section-title">
                    <h2><span class="dot"></span> ${category.categoryName}</h2>
                </div>
                <div class="row">
                    <#list products.productList as product>
                        <div class="col-lg-3 col-md-6 col-sm-6">
                            <@productlisting product/>
                        </div>
                    </#list>
                </div>
            </div>
        </section>
        <!-- End all Products Area -->
        <QuckView />
    </div>
</#if>