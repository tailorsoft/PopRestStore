<div class="col-lg-6 col-md-6">
    <div id="carouselExampleIndicators" class="product-images carousel slide" data-ride="carousel">
      <ol class="carousel-indicators"></ol>
      <div class="carousel-inner"></div>
      <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev" style="color:#CCC">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
    </div>
</div>

<script>
    var contentList = ${ Static["groovy.json.JsonOutput"].toJson(product.contentList) };
    $(function() {
        // this is to avoid the flicker as the hash changes
        setTimeout(function() {
          var [color, size] = window.location.hash.replace('#', '').split('/');
          updateFromValues(color, size);

          $( window ).on( 'hashchange', function( e ) {
              [color, size] = window.location.hash.replace('#', '').split('/');
              updateFromValues(color, size);
          });
        
        }, 100)
        

        

        function updateFromValues(color, size) {
          console.log("updateFromValues:", color, size)
          $('.product-images .carousel-indicators').empty();
          $('.product-images .carousel-inner').empty();
          addImagesForColor(color);

          console.log("#####", $('.product-images .carousel-inner').children().length)
          if ($('.product-images .carousel-inner').children().length == 0) {

            addImagesForColor();
          }
        }

        function addImagesForColor(color) {
          var count = 0;
          for(var content of contentList) {
            if (content.productFeatureId == color && content.productContentTypeEnumId == 'PcntImageLarge') {
              var className = count == 0 ? "active" : "";
              $('.product-images .carousel-inner').append(`
                <div class="carousel-item `+ className +`">
                  <img class="d-block w-100" src="/store/content/productImage/`+content.productContentId+`" >
                </div>
              `);

              $('.product-images .carousel-indicators').append(`
                <li data-target="#carouselExampleIndicators" data-slide-to="`+content.productContentId+`" class="` + className + `"></li>
              `)
              count ++;
            }
          }
        }

    });
</script>