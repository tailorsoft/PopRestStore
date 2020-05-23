
<div>
    <!-- Start Page Title Area -->
    <div class="page-title-area">
        <div class="container">
            <ul>
                <li><a href="/store">Home</a></li>
                <li>${product.productName}</li>
            </ul>
        </div>
    </div>
    <!-- End Page Title Area -->

    <!-- Start Products Details Area -->
    <section class="products-details-area ptb-60">
        <div class="container">
            <div class="row">
                <#include "images.ftl"/>
                <#include "detail.ftl"/>
                <DetailsInfo />
                <RelatedProducts :id = "product.id" />
            </div>
        </div>
    </section>
</div>






