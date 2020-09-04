<div class="container">
  <footer>
	<div class="container2">
		<div class="row">
		   <div class="col-sm-3">
				
                <h5><?php echo $text_question; ?></h5>
                
   	 			
                <div class="foot_phone"><?php echo $phone; ?></div>
                
				<div class="foot_soc">
					<!--a href="#"><img src="catalog/view/theme/autoexl/image/soc_f.png" alt=""></a>
					<a href="#"><img src="catalog/view/theme/autoexl/image/soc_vk.png" alt=""></a>
					<a href="#"><img src="catalog/view/theme/autoexl/image/soc_tw.png" alt=""></a>
					<a href="#"><img src="catalog/view/theme/autoexl/image/soc_ok.png" alt=""></a>
					<a href="#"><img src="catalog/view/theme/autoexl/image/soc_google.png" alt=""></a-->
				</div>
        <div>
          <img src="image/visa.png" alt="" style="width: 100px;">
        </div>
		  </div>
		  <?php if ($informations) { ?>
		  <div class="col-sm-3">
			<h5><?php echo $text_information; ?></h5>
			<ul class="list-unstyled">
			  <?php foreach ($informations as $information) { ?>
			  <li><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
			  <?php } ?>
			</ul>
		  </div>
		  <?php } ?>
		  <div class="col-sm-3">
			<h5><?php echo $text_extra; ?></h5>
			<ul class="list-unstyled">
				<li><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
			  	<li><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
			  	<li><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
			  	<li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
			</ul>
		  </div>
		  <div class="col-sm-3"></div>
		</div>
	  </div>
  </footer>
</div>
</div>
<div class="copy"><?php echo $powered; ?></div>
</body></html>