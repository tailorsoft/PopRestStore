<#macro productlisting productId productName imageContentId price listPrice  >
    <div 
        :class="className">
        <div class="single-product-box">
            <div class="product-image">
                <a href="/store/product/${productId}">
                    <#if imageContentId ??>
                        <img class="figure-img img-fluid product-img product-small-img"
                            src="/store/content/productImage/${imageContentId}"
                            alt="Product Image">
                    <#else>
                        <img class="figure-img img-fluid product-img product-small-img"
                            src="/store/assets/default.png"
                            alt="Product Image">
                    </#if>
                </a>

                <ul>
                    <li>
                        <a 
                            href="javascript:void(0)" 
                            title="Quick View"
                            v-b-tooltip.hover
                            @click.prevent="quickView"
                        >
                            <i class="far fa-eye"></i>
                        </a>
                    </li>
                    <li>
                        <a 
                            href="#"
                            title="Add to Wishlist"
                            v-b-tooltip.hover
                        >
                            <i class="far fa-heart"></i>
                        </a>
                    </li>
                    <li>
                        <a 
                            href="#"
                            title="Add to Compare"
                            v-b-tooltip.hover
                        >
                            <i class="fas fa-sync"></i>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="product-content">
                <h3>
                    <a href="/store/product/${productId}">${productName}</a>
                </h3>

                <div class="product-price">
                    <#if price lt listPrice>
                    <span class="old-price">
                        ${listPrice}
                    </span>
                    </#if>
                    <span class="new-price">${price}</span>
                </div>

                <div class="rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="far fa-star"></i>
                </div>
                <#if productTypeEnumId?if_exists == 'PtAsset'>
                <a 
                    v-else
                    href="javascript:void(0)" 
                    class="btn btn-light" 
                    @click="addToCart(product)">
                    Add to Cart
                </a>
                </#if>
            </div>
        </div>
    </div>
</#macro>