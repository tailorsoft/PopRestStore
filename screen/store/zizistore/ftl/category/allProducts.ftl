<#include "../product/listing.ftl"/>

<div class="col-lg-8 col-md-12">
    <div class="products-filter-options">
        <div class="row align-items-center">
            <div class="col d-flex">
                <p>Showing 22 of 102 results</p>
            </div>

            <div class="col d-flex">
                <span>Show:</span>

                <div class="show-products-number">
                    <select>
                        <option value="1">22</option>
                        <option value="2">32</option>
                        <option value="3">42</option>
                        <option value="4">52</option>
                        <option value="5">62</option>
                    </select>
                </div>

                <span>Sort:</span>

                <div class="products-ordering-list">
                    <select>
                        <option value="1">Featured</option>
                        <option value="2">Best Selling</option>
                        <option value="3">Price Ascending</option>
                        <option value="4">Price Descending</option>
                        <option value="5">Date Ascending</option>
                        <option value="6">Date Descending</option>
                        <option value="7">Name Ascending</option>
                        <option value="8">Name Descending</option>
                    </select>
                </div>
            </div>
        </div>
    </div>

    <div id="products-filter" class="products-collections-listing row">
        <#list productList as product>
            <div class="col-lg-6 col-md-6 products-col-item">
                <#assign mediumImageInfo = product.mediumImageInfo!{}/>
                <#assign imageContentId = mediumImageInfo.productContentId!"-"/>
                <#assign listPrice = product.listPrice!0/>
                <#assign price = product.price!0/>
                <@productlisting product.productId product.productName imageContentId price listPrice  />
            </div>
        </#list>
    </div>

    <nav class="products-pagination">
        <ul>
            <#if productListPageIndex gt 0>
                <li><a href="/store/category/all/${productListPageIndex-1}" class="prev page-numbers"><i class="fas fa-chevron-left"></i></a></li>
            </#if>
            <#list 0..productListPageCount-1 as page>
                <#assign currentClass = ''/>
                <#if page == productListPageIndex><#assign currentClass = 'current'/></#if>
                <li><a href="/store/category/all/${page}" class="page-numbers ${currentClass}">${page+1}</a></li>
            </#list>
            <#if productListPageIndex lt productListPageCount-1>
                <li><a href="/store/category/all/${productListPageIndex+1}" class="next page-numbers"><i class="fas fa-chevron-right"></i></a></li>
            </#if>
        </ul>
    </nav>

    <QuckView />
</div>


<script>
import QuckView from '../modals/QuckView';
import { mutations } from '../../utils/sidebar-util';
import ProductItem from '../landing-one/ProductItem';
export default {
    components: {
        QuckView,
        ProductItem
    },
    methods: {
        toggle() {
            mutations.toggleQuickView();
        }
    },
    computed: {
        products(){
            return this.$store.state.products.all
        }
    },
}
</script>