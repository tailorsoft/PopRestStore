<div class="top-panel">
    <div class="carousel slide" data-ride="carousel">
        <div class="carousel-inner" role="listbox">
            <div class="carousel-item active text-center">
                 <strong>Enjoy an extra 20% off</strong> select sales styles <a href="#">Read More</a>
            </div>
            <div class="carousel-item text-center">
                <strong>Enjoy an extra 20% off</strong> select sales styles <a href="#">Read More</a>
            </div>
        </div>
        <i @click="emitToParent" class="fas fa-times panel-close-btn"></i>
    </div>
</div>
<style scoped>
.carousel-item a,
.carousel-item.active,
.carousel-item.active a{
    color:white;
}
</style>
<script>
$(".panel-close-btn").click(function() {
    $(".top-panel").hide();
})
</script>