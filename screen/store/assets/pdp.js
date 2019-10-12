function initializeFeatureSelects() {
  if (!variants || !Array.isArray(variants)) {
  	console.warn("No variants found, please check they are populated");
  	return;
  }

  if (!document.getElementById("addToCartSection")) {
    console.warn("No addToCartSection found, give an ID of 'addToCartSection' to the dif with the add to cart button");
    return;
  }
  var featureSelects = document.getElementsByClassName("featureSelect");
  var selectedProducts = variants.filter(function(v){return v.productId == selectedProductId});

  if (selectedProducts.length == 1) {
    var variant = selectedProducts[0];
    for(var i = 0; i < featureSelects.length; i++) {
      var combo = featureSelects[i];
      combo.value = variant.features[combo.name];
    };
  }

  var featureSelects = document.getElementsByClassName("featureSelect");
  for(var i = 0; i < featureSelects.length; i++) {
    featureSelects[i].onchange = function() {
      applyFeatureFilters();
    }
  }

  if (variants.size > 1)
    applyFeatureFilters();
  else {
    // todo, fix this
    document.getElementById("outOfStock").style.display = "none";
    document.getElementById("addToCartSection").style.display = "block";
  }
    
}


function applyFeatureFilters() {  

  var filtered = variants.slice();
  var featureSelects = document.getElementsByClassName("featureSelect");
  for(var i = 0; i < featureSelects.length; i++) {
    var combo = featureSelects[i];
    // ignore selects that have not been set
    if (!combo.value)
        continue; 
    filtered = filtered.filter(function(variant) {
        return variant.features[combo.name] == combo.value;
    })
  };

  // If just one variant remains, show/hide add to cart buttons
  if (filtered.length == 1){
    if(filtered[0].quantity > 0) {
      document.getElementById("addToCartSection").style.display = "block";
      document.getElementById("outOfStock").style.display = "none";
      document.getElementById("productId").value = filtered[0].productId;
    } else {
      document.getElementById("addToCartSection").style.display = "none";
      document.getElementById("outOfStock").style.display = "block";
      document.getElementById("productId").value = '';
    }
  } else {
    document.getElementById("addToCartSection").style.display = "none";
    document.getElementById("outOfStock").style.display = "none";
  }
}