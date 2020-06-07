<#include "../frame/header.ftl"/>
<hr/>

<div id="app"></div>

<link rel="stylesheet" href="/store/components/xstyles.css">
<style>

.step-active .circle { color: #fff; background-color: #dd6231;  position: absolute; border: none; }



.container-input { display: block; position: relative; padding-left: 35px; margin-bottom: 12px; margin-top: 2px; color: #666666;
    cursor: pointer; font-size: 1em; user-select: none; }

.container-input input:checked ~ .checkmark {background-color: #e7e7e7;}
.checkmark:after { content: ""; position: absolute; display: none; }
.container-input .checkmark:after {width: 9px;height: 9px;border-radius: 50%;background: #666666;}






.container-input .checkmark:after {width: 9px;height: 9px;border-radius: 50%;background: #666666;}


.container-input:hover input ~ .checkmark { background-color: #ccc; }
.container-input input:checked ~ .checkmark { background-color: #e7e7e7; }
.checkmark:after { content: ""; position: absolute; display: none; }
.container-input input:checked ~ .checkmark:after { display: block; }
.container-input .checkmark:after { width: 9px; height: 9px; border-radius: 50%; background: #666666; }



.span-description { display: block; margin-top: -5px; }


.text-add { color: #3ad0de !important; cursor: pointer; font-size: 0.9em; margin-top: 10px; margin-right: 17px; }


.circle { color: #666666; width: 25px; height: 25px; position: absolute; text-align: center; display: flex;
    justify-content: center; align-items: center; border-radius: 50%; border: 1px solid #666666; }








.title-product-text { color:#10c6d7; }
.title-check-text {cursor: pointer;margin-top: 15px;}
.title-cart-item { color: #666666 !important; margin-top: 15px; font-size: 1.2em; }




#checkout-body .title-check-text{
	color: #222222;
	font-size: 1em;
	
}

#checkout-body .div-checkmark { 
	background-color: #e7e7e7; 
	border-radius: 5px; 
	padding: 10px;
	margin-bottom:10px;
}

/* hide the radio buttons */
#checkout-body .container-input input[type=radio] { 
	position: absolute; 
	opacity:0;
}

#checkout-body .checkmark { 
	position: absolute; 
	top: 3px; left: 3px; 
	height: 15px; width: 15px; 
    border: 1px solid #666666; 
    border-radius: 50%; 
    display: flex; 
    justify-content: center; 
    align-items: center; 
 }

#checkout-body .title-check-text .text-address {
	margin-left: 30px
}

#checkout-body .title-check-text .step-active {
	color: black;
}

/* HR styles */
#checkout-body .hr {
	margin-top: -10px;
}

#checkout-body .hr-active {
	background-color: #222222;
}

#checkout-body .hr-complete { 
	background-color: #dc3545; 
}

/* Circle styles */

#checkout-body .circle{
	width: 25px; 
	height: 25px;
	text-align: center; 
	border-radius: 15%; 
}

#checkout-body .step-active .circle {
	background-color: #222222;
}

#checkout-body .step-complete .circle {
	background-color: #dc3545;
	border: none;
	color: white;
}

#checkout-body .step-complete .text-address {
	color: #dc3545;

}


#checkout-body .section-buttons {
	padding-bottom: 20px;
	text-align: right;
}
#checkout-body .section-buttons .btn {
	margin-left: 10px;
}

#checkout-body .edit-icon { 
	color: #222222; 
	display: inline-block; 
	right: 50px; 
	margin-top: -95px; 
	position: absolute; cursor: pointer; font-size: 0.8em; 
}

#checkout-body .delete-icon { 
	color: #222222; 
	display: inline-block; 
	right: 30px; 
	margin-top: -95px; 
	position: absolute; 
	cursor: pointer; 
	font-size: 0.8em; 
}




</style>
<#include "../frame/footer.ftl"/>