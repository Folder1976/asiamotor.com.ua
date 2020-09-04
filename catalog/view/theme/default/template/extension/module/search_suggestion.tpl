<style type="text/css">
<?php echo $css; ?> 
</style>

<?php if (!empty($element)) { ?> 
<script type="text/javascript">
  var search_element = "<?php echo $element; ?>";
</script>
<?php } ?>
<script type="text/javascript">
  function ss_cart_add(product_id, minimum) {
		window.ss_btn_clicked = true; 
		cart.add(product_id, minimum);
		return false;
	}
</script>
