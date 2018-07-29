<div class="container mt-2">
    <a class="customer-link" href="/store">Home <i class="fas fa-angle-right"></i></a>
    <#-- TODO: replace demo breadcrumbs with real or get rid of -->
    <span class="customer-link">All Products <i class="fas fa-angle-right"></i></span>
    <span class="customer-link">Office Supplies</span>
</div>
<div class="container container-text mt-1">
    <div id="isSuccessAddCart" class="alert alert-primary mt-3 mb-3" role="alert">
        <i class="far fa-check-square"></i> You added a ${product.productName} to your shopping cart.
        <a class="float-right" href="/store/d#/checkout">Go to Checkout <i class="fas fa-arrow-right"></i></a>
    </div>
    <div class="row mt-2">
        <div class="col col-lg-1 col-sm-4 col-4">
            <div>
                <#list product.contentList as img>
                    <#if img.productContentTypeEnumId == "PcntImageLarge">
                        <img width="200px" height="200px" onClick="changeLargeImage('${img.productContentId}');"
                            class="figure-img img-fluid product-img"
                            src="/store/content/productImage/${img.productContentId}"
                            alt="Product Image">
                    </#if>
                </#list>
            </div>
        </div>
        <div class="col col-lg-4 col-sm-8 col-8">
            <img id="product-image-large" class="product-img-select">
        </div>
        <div class="col col-lg-4 col-sm-12 col-12">
            <p>
                <span class="product-title">${product.productName}</span>
                <br>
                <#list 1..5 as x>
                    <span class="star-rating">
                        <i class="fas fa-star"></i>
                    </span>
                </#list>
            </p>
            <div class="product-description">
                <#if product.descriptionLong??>
                    ${product.descriptionLong}
                </#if>
            </div>
        </div>
        <div class="col col-lg-3">
            <#-- TODO: implement add to cart form target, see old PopCommerce app for example -->
            <form id="cart-add-form">
                <div class="card cart-div">
                    <#if product.listPrice??>
                        <span class="save-circle" v-if="product.listPrice">
                            <span class="save-circle-title">SAVE</span>
                            <span class="save-circle-text">$${(product.listPrice - product.price)?string(",##0.00")}</span>
                        </span>
                    </#if>
                    <div class="form-group col">
                        <div class="cart-form-price">
                            <p>
                                <span class="price-text">${product.price}</span> 
                                <#if product.listPrice??>
                                    <span>
                                        <span class="product-listprice-text">was</span>
                                        <del>${product.listPrice}</del>
                                    </span>
                                </#if>
                            </p>
                        </div>
                        <#--
                        <hr class="product-hr" style="margin-top: -5px;">
                        <span class="product-description">On sale until midnight or until stocks last.</span>
                        -->
                        <hr class="product-hr">
                    </div>
                    <div class="form-group col">
                        <input type="hidden" value="${product.pseudoId}" name="productId" />
                        <input type="hidden" value="${product.priceUomId}" name="currencyUomId" />
                        <input type="hidden" value="${ec.web.sessionToken}" name="moquiSessionToken"/>
                        <span class="product-description">Quantity</span>
                        <select class="form-control" name="quantity">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                        </select>
                    </div>
                </div>
                <button id="cartAdd" class="btn cart-form-btn col"><i class="fa fa-shopping-cart"></i> Add to Cart</button>
            </form>
        </div>
    </div>
    <hr>
</div>

<div class="container mb-5">
    <span class="modal-text">Customer Reviews</span>
	<#list reviewsList.productReviewList as review>
  	<div class="review">
        <span class="modal-text">"${review.productReview}"</span>
        <br>
        <span class="star-rating review-text-size">
    		<#list 1..5 as x>
    			<#if (review.productRating >= x)>
					<i class="fas fa-star"></i>
                <#else>
					<i class="far fa-star"></i>
                </#if>
            </#list>
        </span>
        <span class="review-date review-text-size">
    		Reviewed by
    		<#if review.postedAnonymous == "Y">
    			Anonymous
            <#else>
                ${review.userId}
            </#if>
    		on ${review.postedDateTime}
    	</span>
        <br>
        <span class="review-text review-text-size">
            ${review.productReview}
        </span>
    </div>
    </#list>
    <br>
    <button data-toggle="modal" data-target="#modal1" class="btn btn-continue review-btn">Write a Review</button>
</div>
<div class="modal fade" id="modal1">
    <div class="modal-dialog" role="document">
        <form class="modal-content" id="product-review-form">
            <div class="modal-header">
                <h5 class="modal-title">Add an Review</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <input type="hidden" value="${ec.web.sessionToken}" name="moquiSessionToken" id="moquiSessionToken">
                <input type="hidden" value="${productId}" name="productId" id="productId">
                <input type="hidden" value="1" name="productRating" id="productRating">
                <label>Rating</label>
                <div class='rating-stars text-center'>
                    <ul id='stars'>
                        <li class='star' data-value='1'><i class='fa fa-star fa-fw'></i></li>
                        <li class='star' data-value='2'><i class='fa fa-star fa-fw'></i></li>
                        <li class='star' data-value='3'><i class='fa fa-star fa-fw'></i></li>
                        <li class='star' data-value='4'><i class='fa fa-star fa-fw'></i></li>
                        <li class='star' data-value='5'><i class='fa fa-star fa-fw'></i></li>
                    </ul>
                </div>
                <br>
                <label>Comments</label>
                <textarea class="form-control text-area-review" rows="5" name="productReview" id="productReview"></textarea>
            </div>
            <div class="modal-footer">
                <button class="btn btn-continue" id="addReview">Add Review</button>
                <a data-dismiss="modal" class="btn btn-link">Or Cancel</a>
            </div>
        </form>
    </div>
</div>

<script>
    var prodImageUrl = "/store/content/productImage/";
    var $productImageLarge = document.getElementById("product-image-large");
    function changeLargeImage(productContentId) { $productImageLarge.src = prodImageUrl + productContentId; }
    //Default image
    <#if product.contentList?has_content>changeLargeImage("${product.contentList[0].productContentId}");</#if>
    function setStarNumber(number) {
        var productRating = document.getElementById("productRating");
        productRating.value = number;
    }
</script>
