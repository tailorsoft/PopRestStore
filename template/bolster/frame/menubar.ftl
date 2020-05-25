<#assign cartQuantity = 0 >
<#if productsInCart?? &amp;&amp; productsInCart.orderItemList??>
    <#list productsInCart.orderItemList as orderItem>
        <#assign cartQuantity = cartQuantity + orderItem.quantity>
    </#list>
</#if>
        <#include "../cart/sidebar.ftl"/>
        <div class="navbar-area">
            <div class="comero-nav">
                <div class="container">
                    <nav class="navbar navbar-expand-md navbar-light">
                        <a class="navbar-brand" href="/store/">
                            <img src="/store/assets/bolster/logo.svg" alt="logo" width="150" height="32">
                        </a>

                        <b-collapse class="collapse navbar-collapse" id="navbarSupportedContent" is-nav>
                            <ul class="navbar-nav">
                                
                                <li class="nav-item p-relative"><a href="/store/" class="nav-link">Home </a></li>
                                <li class="nav-item p-relative"><a href="/store/category/all" class="nav-link">Shop </a></li>
                                <li class="nav-item"><a href="/gallery-one" class="nav-link">Gallery</a></li>
                                <li class="nav-item p-relative"><a href="#" class="nav-link">Blog <i class="fas fa-chevron-down"></i></a>
                                    <ul class="dropdown-menu">
                                        <li class="nav-item"><a href="/blog-one" class="nav-link">Blog Grid</a></li>

                                        <li class="nav-item"><a href="/blog-details" class="nav-link">Blog Details</a></li>
                                    </ul>
                                </li>

                                <li class="nav-item">
                                    <a href="/contact" class="nav-link">Contact</a>
                                </li>
                            </ul>

                            <div class="others-option">
                                <div class="option-item">
                                    <a href="/store/d#/login">Login</a>
                                </div>
                                <div class="option-item">
                                    <a href="#" data-toggle="modal" data-target="#shoppingCartModal">
                                        Cart(${cartQuantity}) <i class="fas fa-shopping-bag"></i>
                                    </a>
                                </div>
                            </div>
                        </b-collapse>
                    </nav>
                </div>
            </div>
        </div>
        

        <script>
        $(function() {
            const navTop = $('.navbar-area').offset().top;
            $(window).scroll(function() {
                if ($(this).scrollTop() > navTop){  
                    $('.navbar-area').addClass("is-sticky");
                } else {
                    $('.navbar-area').removeClass("is-sticky");
                }
            });
        });
        </script>