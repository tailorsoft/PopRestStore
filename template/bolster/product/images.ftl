<#assign images = []>
<#list product.contentList as content>
    <#if ["PcntImageLarge", "PcntImageDetail"]?seq_contains(content.productContentTypeEnumId) >
        <#assign images = images + [ content.productContentId ]>
    </#if>
</#list>

<div class="col-lg-6 col-md-6">
    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
      <ol class="carousel-indicators">
        <#list images as img>
        <#assign className = (img?index == 0)?string('active','')>
        <li data-target="#carouselExampleIndicators" data-slide-to="${img?index}" class="${className}"></li>
        </#list>
      </ol>
      <div class="carousel-inner">
        <#list images as img>
          <#assign className = (img?index == 0)?string('active','')>
          <div class="carousel-item ${className}">
            <img class="d-block w-100" src="/store/content/productImage/${img}" >
          </div>
        </#list>
      </div>
      <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev" style="color:#CCC">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>
</div>