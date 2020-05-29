<#assign photos>
banner1.jpg
banner2.jpg
banner3.jpg
banner4.jpg
banner5.jpg
</#assign>
<#assign photos = photos?split('\\n', 'rmc') >
<#assign nextRandom = .now?string["HHmmssSSS"]?number>
<#assign img = photos[nextRandom % photos?size] >

    <div class="main-banner item-bg1" style="background-image: url('/store/zizistore/landing/${img}')">
        <div class="d-table">
            <div class="d-table-cell">
                <div class="container">
                    <div class="main-banner-content">
                        <span>New Inspiration 2019</span>
                        <h1>Clothing made for you!</h1>
                        <p>Trending from men and women style collection</p>

                        <a href="/store/category/womens" class="btn btn-primary">Shop Women's</a>
                        <a href="/store/category/mens" class="btn btn-light">Shop Men's</a>
                    </div>
                </div>
            </div>
        </div>
    </div>