<#assign cart = false>
<#if productsInCart.orderItemList??>
    <#assign cart = productsInCart.orderItemList>
</#if>
<#assign brandFeatures = product.standardFeatureList?filter(x -> x.productFeatureTypeEnumId == "PftBrand") />
<#if (brandFeatures?size gt 0) >
    <#assign brand = brandFeatures?first />
</#if>
<#assign sizes = []>
<#assign colors = []>
<#if variantsList?? >
    <#list variantsList.listFeatures?keys as key>
        <#if key.productFeatureTypeEnumId?if_exists == 'PftColor'>
            <#assign colors = variantsList.listFeatures.get(key)>
        </#if>
        <#if key.productFeatureTypeEnumId?if_exists == 'PftSize'>
            <#assign sizes = variantsList.listFeatures.get(key)>
        </#if>
    </#list>
</#if>
<#--
We want to generate a JSON structure like follows:
variants : {
    'RED' : {
        'SM' : 'PROD1'
        'MD' : 'PROD2',
        'LG' : 'PROD3' 
    },
    'GREEN' : {
        'SM' : 'PROD4'
        'MD' : 'PROD5',
        'LG' : 'PROD5' 
    }
}
-->
<#assign variants = {}>
<#assign stock = 0 >
<#if productQuantity?? &amp;&amp; productQuantity.productQuantity?? >
    <#assign stock = stock + productQuantity.productQuantity >
</#if>

<#list colors as color>
    <!-- here we create the simple array or productIds for this color -->
    <#assign colorVariants = []>
    <#list variantsList.variantOptions?keys as key >
        <#if key.enumId?if_exists == 'PftColor'>
            <#list variantsList.variantOptions.get(key) as v>
                <#if v.productFeatureId == color.productFeatureId >
                    <#assign colorVariants = colorVariants + [ v.productId ] >
                </#if>
            </#list>
        </#if>
    </#list>

    <#assign colorMap = {}>
    <#list sizes as size>
        <!-- Here we find within the previous array of productId, which one has the size we need -->
        <#list variantsList.variantOptions?keys as key >
            <#if key.enumId?if_exists == 'PftSize'>
                <#list variantsList.variantOptions.get(key) as v>
                    <#if v.productFeatureId == size.productFeatureId &amp;&amp; colorVariants?seq_contains(v.productId) >
                        <#assign colorMap = colorMap + { size.productFeatureId : v }>
                        <#if v.quantity?? >
                            <#assign stock = stock + v.quantity?number >
                        </#if>
                    </#if>
                </#list>
            </#if>
        </#list>
    </#list>
    <#assign variants = variants +  { color.productFeatureId: colorMap } >
</#list>




    <div class="col-lg-6 col-md-6">
        <form class="product-details-content" method="post" action="/store/product/addToCart">
            <h3>${product.productName}</h3>

            <div class="price">
                <span class="new-price">${product.price}</span>
            </div>

            <div class="product-review">
                <div class="rating">
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star"></i>
                    <i class="fas fa-star-half-alt"></i>
                </div>
                <a href="#" class="rating-count">3 reviews</a>
            </div>

            <ul class="product-info">
                <#if brand?? >
                    <li><span>Brand:</span> <a href="#">${brand.description}</a></li>
                </#if>
                <li><span>Availability:</span> <a href="#">In stock (${stock} items)</a></li>
                <li><span>Product Type:</span> <a href="#">${product.productTypeEnumId}</a></li>
            </ul>

            <#if colors?size gt 0 >
                <div class="product-color-switch">
                    <h4>Color:</h4>
                    <ul>
                        <#list colors as color>
                            <li><a href="#" data-color="${color.productFeatureId}" style="background:${color.idCode}"></a></li>
                        </#list>
                    </ul>
                </div>
            </#if>
            <#if sizes?size gt 0 >
                <div class="product-size-wrapper">
                    <h4>Size:</h4>
                    <ul>
                        <#list sizes as size>
                            <li><a href="#" data-size="${size.productFeatureId}">${size.abbrev}</a></li>
                        </#list>
                    </ul>
                </div>
            </#if>
            <div class="product-add-to-cart">
                <div class="input-counter">
                    <span class="minus-btn"><i class="fas fa-minus"></i></span>
                    <strong class="quantity-dsp">0</strong>
                    <span class="plus-btn"><i class="fas fa-plus"></i></span>
                </div>
                <button type="submit" class="btn btn-danger">
                    <i class="fas fa-cart-plus"></i> Update Cart 
                </button>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-cart-plus"></i> Add to Cart
                </button>
            </div>

            <div class="wishlist-compare-btn">
                <a href="#" class="btn btn-light"><i class="far fa-heart"></i> Add to Wishlist</a>
            </div>
            <input type="hidden" value="${ec.web.sessionToken}" name="moquiSessionToken" id="moquiSessionToken">
            <input type="hidden" name="productId" value="DEMO_USB32G" />
            <input type="hidden" name="currencyUomId" value="USD" />
            <input type="hidden" name="quantity" value="0" />
        </form>
    </div>
    <div class="toast">
  <div class="toast-header">
    Toast Header
  </div>
  <div class="toast-body">
    Some text inside the toast body
  </div>
</div>

<script>
    var productId = '${product.productId}';
    var variantsMap = ${ Static["groovy.json.JsonOutput"].toJson(variants) };
    var cart = ${ Static["groovy.json.JsonOutput"].toJson(cart) };

    $(function() {
        var color = "";
        var size = "";
        var quantity = 1;

        if (window.location.hash && window.location.hash.indexOf("/") > 0) {
            [color, size] = window.location.hash.replace('#', '').split('/');
        }
        

        $( window ).on( 'hashchange', function( e ) {
            [color, size] = window.location.hash.replace('#', '').split('/');
            updateFromValues(color, size);
        });

        if (valuesAreValid(color, size)) {
            updateFromValues(color, size);
        } else {
            var defaultHash = getDefaultHash();
            if (defaultHash) {
                window.location.hash = defaultHash;
            } else if (Object.keys(variantsMap).length == 0) {
                updateCartButtons(productId); // This product has no variants
            } else {
                $(".product-add-to-cart").hide();
            }
        }

        function valuesAreValid(color, size) {
            return color && size && variantsMap[color] && variantsMap[color][size] && variantsMap[color][size].quantity > 0
        }

        function getDefaultHash() {
            var colors = Object.keys(variantsMap);
            var middleColor = colors[Math.round((colors.length - 1) / 2)];
            var color = getNextAvailableColor(middleColor);

            // no colors have available inventory
            if (!color) return;

            var sizes = Object.keys(variantsMap[color])
            var middleSize = sizes[Math.round((sizes.length - 1) / 2)];
            var size = getNextAvailableSize(color, middleSize);

            return color + "/" + size;
        }

        function updateHash() {
            if (color && size)
                window.location.hash = color+"/"+size;
            else if (color)
                window.location.hash = color;
        }

        function updateFromValues(color, size) {
            $(".product-color-switch").find('li').removeClass("active");
            $('.product-color-switch a[data-color=' + color + ']').parent().addClass("active");

            $(".product-size-wrapper").find('a').removeClass("active");
            if (color && size && variantsMap[color][size].quantity > 0) {
                // update the size selector to reflect the users choice
                $('.product-size-wrapper a[data-size=' + size + ']').addClass("active");

                // populate the productId in the hidden input 
                var variant = variantsMap[color][size];
                $('input[name="productId"]').val(variant.productId);

                updateCartButtons(variant.productId)
                $(".product-add-to-cart").show();
            } else {
                $(".product-add-to-cart").hide();
            }
            updateSizesInStock();
        }

        function updateCartButtons(productId) {
            // If the item was in the cart already, show the different button
            var cartItem = getCartItem(productId);
            if (cartItem) {
                updateQuantity(cartItem.quantity);
                $(".product-add-to-cart").find(".btn-danger").show();
                $(".product-add-to-cart").find(".btn-primary").hide();
            } else {
                updateQuantity(1);
                $(".product-add-to-cart").find(".btn-danger").hide();
                $(".product-add-to-cart").find(".btn-primary").show();
            }
        }

        function getCartItem(productId) {
            if (!cart) return false;
            for(var orderItem of cart) {
                if (orderItem.productId == productId) return orderItem;
            }
            return false;
        }

        function updateQuantity(val) {
            quantity = val;
            $('.quantity-dsp').html(val);
            $('input[name="quantity"]').val(val);
        }

        function updateSizesInStock() {
            $(".product-size-wrapper").find('a').each(function( index ) {
              var s = $(this).data("size");
              var p = variantsMap[color][s];
              if (p.quantity > 0)
                $(this).addClass("available");
              else 
                $(this).removeClass("available");
            });
        }

        $(".product-color-switch a").click(function(e) {
            e.preventDefault();
            color = $(this).data("color");
            size = getNextAvailableSize(color, size);
            updateHash();
        });

        function getNextAvailableColor(color, size) {
            // If a size with quantity is found for this color
            if(getNextAvailableSize(color, size)) return color;

            var colors = Object.keys(variantsMap)
            for(var c of colors) {
                if(getNextAvailableSize(c, size)) return c;
            }

            return "";
        }

        function getNextAvailableSize(color, size) {
            var colorMap = variantsMap[color];
            if(size && colorMap[size].quantity > 0) return size;

            if (!colorMap) return;

            var sizes = Object.keys(colorMap)
            for(var s of sizes) {
                if(colorMap[s].quantity > 0) return s;
            }

            return;
        }

        $(".product-size-wrapper a").click(function(e) {
            e.preventDefault();
            if ($(this).hasClass("available")){
                size = $(this).data("size");
                updateHash();
            } else {
                $('.toast').html("No product in stock for "+$(this).data("size"))
                $('.toast').toast('show');
            }
        });

        $(window).on('hashchange', function() {
          console.log("window.location.hash: ", window.location.hash)
        });
        

        $(".plus-btn").click(function() {
            if(quantity > 9){
                $('.toast').html("Can't add more than 10")
                $('.toast').toast('show');
            } else {
                quantity++
            }
            updateQuantity(quantity);
        });

        $(".minus-btn").click(function() {
            if(quantity < 1){
                $('.toast').html("Can't add more than 10")
                $('.toast').toast('show');
            } else {
                quantity--
            }
            updateQuantity(quantity);
        });

        
        
        updateQuantity(quantity);
    });
</script>