<#assign cartQuantity = 0 >
<#assign cart = [] >
<#if productsInCart?? &amp;&amp; productsInCart.orderItemList??>
    <#list productsInCart.orderItemList as orderItem>
        <#assign cartQuantity = cartQuantity + orderItem.quantity>
        <#assign cart = cart + [orderItem] >
    </#list>
</#if>
<!-- Modal -->
<div class="modal right fade shoppingCartModal" id="shoppingCartModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
        <button type="button" class="close" data-dismiss="modal""><span aria-hidden="true">&times;</span></button>
        <#if cart?size != 0>
        <div 
            class="modal-body"
            v-if="cart.length > 0"
        >
            <h3>My Cart (${cartQuantity})</h3>

            <div class="product-cart-content">
                <#list cart as orderItem>
                    <#assign content = productsInCart.orderItemContent[orderItem.productId] >



                <div class="product-cart">
                    <div class="product-image">
                        <img class="d-block w-100" src="/store/content/productImage/${content.productContentId}" >
                    </div>

                    <div class="product-content">
                        <h3><a href="#">${orderItem.itemDescription}</a></h3>
                        <#if orderItem.comments?? ><span>${orderItem.comments}</span></#if>
                        <div class="product-price">
                            <span>${orderItem.quantity}</span>
                            <span>x</span>
                            <span class="price">${orderItem.unitAmount}</span>
                        </div>
                    </div>
                </div>
                </#list>
            </div>

            <div class="product-cart-subtotal">
                <span>Subtotal</span>

                <span class="subtotal">$ ${productsInCart.orderHeader.grandTotal}</span>
            </div>

            <div @click="closeSidebarPanel" class="product-cart-btn">
                <a href="/store/d#/checkout" class="btn btn-primary">Proceed to Checkout</a>
            </div>
        </div>
        </#if>
        <#if cart?size == 0>
        <div class="modal-body" v-else>
            <h3>Empty!</h3>
            <div @click="closeSidebarPanel" class="product-cart-btn">
                <nuxt-link to="/products" class="btn btn-primary">Browse All Time Hot!</nuxt-link>
                <nuxt-link to="/products" class="btn btn-light">Browse Latest!</nuxt-link>
            </div>
        </div>
        </#if>
    </div>
  </div>
</div>

