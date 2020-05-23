
<#assign ingredientsContent = product.contentList?filter(x -> x.productContentTypeEnumId == "PcntIngredients")?first />
<#if ingredientsContent??>
    <#assign ingredients = ec.service.sync().name("popstore.ProductServices.get#LocationText")
        .parameter("location", ingredientsContent.contentLocation).call().text>
</#if>

<#assign specificationsContent = product.contentList?filter(x -> x.productContentTypeEnumId == "PcntSpecification")?first />
<#if specificationsContent??>
    <#assign specifications = ec.service.sync().name("popstore.ProductServices.get#LocationText")
        .parameter("location", specificationsContent.contentLocation).call().text>
</#if>


<div class="col-lg-12 col-md-12">
    <div class="tab products-details-tab">
        <div class="row">
            <div class="col-lg-12 col-md-12">
                <ul class="tabs">
                    <li><a href="#">
                        <div class="dot"></div> Description
                    </a></li>
                </ul>
            </div>

            <div class="col-lg-12 col-md-12">
                <div class="tab_content">
                    <div class="tabs_item">
                        <div class="products-details-tab-content">
                            <p><#if product.descriptionLong??>
                                ${product.descriptionLong}
                            </#if></p>
                            <div class="row">
                                <#if ingredients??>
                                <div class="col-lg-6 col-md-6">
                                     ${ingredients}
                                </div>
                                </#if>
                                <#if specifications??>
                                <div class="col-lg-6 col-md-6">
                                     ${specifications}
                                </div>
                                </#if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>