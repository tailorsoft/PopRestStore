<#assign cart = false>
<#if productsInCart?? &amp;&amp; productsInCart.orderItemList??>
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
        <form class="product-details-content" name="cart-form" method="post" action="/store/product/addToCart">
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
            <input type="hidden" name="productId" value="" />
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
        var quantity = 1;
        var defaultColor = getDefaultColor();

        $( window ).on( 'hashchange', function( e ) {
            var color = getColorFromHash();
            showValuesForColor(color);
        });

        if (window.location.hash) {
            var color = getColorFromHash();
            showValuesForColor(color);
        } else if(defaultColor) {
            window.location.hash = defaultColor;
        } else if (Object.keys(variantsMap).length == 0) {
            updateCartButtons(productId); // This product has no variants
        } else {
            $(".product-add-to-cart").hide();
        }

        function getColorFromHash() {
            return window.location.hash.replace('#', '');
        }

        function getDefaultColor() {
            return Object.keys(variantsMap)[0];
        }

        function updateHash(color) {
            window.location.hash = color;
        }

        function showValuesForColor(color) {
            $(".product-color-switch").find('li').removeClass("active");
            $('.product-color-switch a[data-color=' + color + ']').parent().addClass("active");

            $(".product-size-wrapper").find('a').removeClass("active");
            $('input[name="productId"]').val('');

            updateSizesInStock(color);
        }

        function updateSizesInStock(color) {
            var isAvailable = false;
            $(".product-size-wrapper").find('a').each(function( index ) {
              var s = $(this).data("size");
              var p = variantsMap[color][s];
              if (p.quantity > 0) {
                isAvailable = true;
                $(this).addClass("available");
              } else {
                $(this).removeClass("available");
              }
            });

            // if no sizes have  quantity, hide the submit button
            console.log("isAvailable:",isAvailable)
            if (isAvailable) {
                $(".product-add-to-cart").show();
                updateCartButtons();
            } else {
                $(".product-add-to-cart").hide();
            }
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



        $(".product-color-switch a").click(function(e) {
            e.preventDefault();
            updateHash($(this).data("color"));
        });


        $(".product-size-wrapper a").click(function(e) {
            var color = getColorFromHash();
            e.preventDefault();
            if ($(this).hasClass("available")){
                var size = $(this).data("size");
                var variant = variantsMap[color][size];
                $('input[name="productId"]').val(variant.productId);
                updateCartButtons(variant.productId);
            } else {
                $('.toast').html("No product in stock for "+$(this).data("size"))
                $('.toast').toast('show');
            }
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

        $("form[name='cart-form']").submit(function(e){
            var productId = $('input[name="productId"]').val();
            if (!productId || productId == "") {
                $('.toast').html("Please select a size")
                $('.toast').toast('show');
                return false;
            }
        })

        
        
        updateQuantity(quantity);
    });
</script>