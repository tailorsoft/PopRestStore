    <div>
        <!-- Start Page Title Area -->
        <div class="page-title-area">
            <div class="container">
                <ul>
                    <li><a href="/store/">Home</a></li>
                    <li>${category.categoryName}</li>
                </ul>
            </div>
        </div>
        <!-- End Page Title Area -->

        <!-- Start Collections Area -->
        <section class="products-collections-area ptb-60">
            <div class="container">
                <div class="section-title">
                    <h2><span class="dot"></span> Products</h2>
                </div>

                <div class="row">
                    <#include "sidebar.ftl"/>
                    <#include "allProducts.ftl"/>
                </div>
            </div>
        </section>
        <!-- End Collections Area -->
    </div>