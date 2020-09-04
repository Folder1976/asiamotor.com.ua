<?php echo $header; ?>
<div class="container">
     <ul class="breadcrumb" itemscope itemtype="https://schema.org/BreadcrumbList">
		    <?php foreach ($breadcrumbs as $count => $breadcrumb) { ?>
			    <?php if($count == 0) { ?>
				  <li>
					<a href="<?php echo $breadcrumb['href']; ?>">
					  <?php echo $breadcrumb['text']; ?>
					</a>
				  </li>
		        <?php } elseif($count+1<count($breadcrumbs)) { ?>
		        	<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
					<a itemscope itemtype="https://schema.org/Thing" itemprop="item" href="<?php echo $breadcrumb['href']; ?>" itemid="<?php echo $breadcrumb['href']; ?>" title="<?php echo $breadcrumb['text']; ?>">
					  <span itemprop="name"><?php echo $breadcrumb['text']; ?></span>
					</a>
					<meta itemprop="position" content="<?php echo $count; ?>" />
					</li>
		        <?php } else { ?>
		        	<li itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
		        	<span itemscope itemtype="https://schema.org/Thing" itemprop="item" itemid="<?php echo $breadcrumb['href']; ?>">
					  <!-- <span itemprop="name"><?php echo $breadcrumb['text']; ?></span> -->
					  <span itemprop="name">Контакты</span>
					</span>
					<meta itemprop="position" content="<?php echo $count; ?>" />
		        	</li>
		        <?php } ?>
			<?php } ?>
	  </ul>
</div>
<?php echo $content_top; ?>
<div class="container">
	<div class="row top-row">
	  <div class="col-sm-12">
		  <!-- <h1 class="cat-header"><?php echo $heading_title; ?></h1> -->
		  <h1 class="cat-header">Контакты</h1>
	  </div>
  </div>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>">
	    <div class="row">
		    <div class="col-sm-6 contact-form-box">
				<h3>Адрес:</h3>
				<p>Украина, Запорожье, Кривая Бухта 2, оф 105</p>

				<h3>Телефоны: </h3>
				<p>+38 (050) 6-410-410</p>
				<p>+38 (097) 412-29-25</p>
				<p>+38 (050) 720-18-66</p>
				<p>+38 (068) 881-36-77</p>

				<h3>График работы</h3>
				<p>ПН-ПТ: 09:00 - 18:00</p>
				<p>СБ: 9:00 - 13:00</p>
				<p>ВС: Выходной</p>

				<h3>email</h3>
				<p>yarmachok79@gmail.com</p>

				<h3>Viber</h3>
				<p>+380506410410</p>

				
			    <!-- <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
			        <fieldset>
			          <div class="form-group required">
			            <label class="col-sm-3 control-label" for="input-name"><?php echo $entry_name; ?></label>
			            <div class="col-sm-9">
			              <input type="text" name="name" value="<?php echo $name; ?>" id="input-name" class="form-control" />
			              <?php if ($error_name) { ?>
			              <div class="text-danger"><?php echo $error_name; ?></div>
			              <?php } ?>
			            </div>
			          </div>
			          <div class="form-group required">
			            <label class="col-sm-3 control-label" for="input-email"><?php echo $entry_email; ?></label>
			            <div class="col-sm-9">
			              <input type="text" name="email" value="<?php echo $email; ?>" id="input-email" class="form-control" />
			              <?php if ($error_email) { ?>
			              <div class="text-danger"><?php echo $error_email; ?></div>
			              <?php } ?>
			            </div>
			          </div>
			          <div class="form-group required">
			            <label class="col-sm-3 control-label" for="input-enquiry"><?php echo $entry_enquiry; ?></label>
			            <div class="col-sm-9">
			              <textarea name="enquiry" rows="10" id="input-enquiry" class="form-control"><?php echo $enquiry; ?></textarea>
			              <?php if ($error_enquiry) { ?>
			              <div class="text-danger"><?php echo $error_enquiry; ?></div>
			              <?php } ?>
			            </div>
			          </div>
			          <?php if ($text_terms) { ?>
			            <div class="form-group required">
			              <label class="col-sm-3"></label>
			              <div class="col-sm-9">
			              <?php echo $text_terms; ?> <input type="checkbox" name="terms" value="1" style="width: auto;" <?php if ($terms) { ?>checked="checked"<?php } ?>/>
			              <?php if ($error_terms) { ?>
			              <div class="text-danger"><?php echo $error_terms; ?></div>
			              <?php } ?>
			              </div>
			            </div>
			          <?php } ?>
			          <div class="col-sm-offset-3 col-sm-9 captcha-box">
				          <?php echo $captcha; ?>
			          </div>
			        <div class="col-sm-offset-3 col-sm-9 contact-button-box">
			            <input class="btn btn-primary" type="submit" value="<?php echo $button_submit; ?>" />
			        </div>
			        </fieldset>
			    </form> -->
		    </div>
		    <div class="col-sm-6">
			    <?php if ($oct_luxury_cont_contacthtml !='') { echo "<div class=\"contacthtml-box\">" . $oct_luxury_cont_contacthtml . "</div>"; } ?>
		    </div>
	    </div>
	    <div class="row map-box-row">
		    <div class="col-sm-12">
			    <?php if ($oct_luxury_cont_contactmap !='') {  echo "<div class=\"map-box\">" . html_entity_decode($oct_luxury_cont_contactmap, ENT_QUOTES, 'UTF-8') . "</div>"; } ?>
		    </div>
		</div>
	    
      </div>
    <?php echo $column_right; ?></div>
</div><?php echo $content_bottom; ?>
<?php echo $footer; ?>
