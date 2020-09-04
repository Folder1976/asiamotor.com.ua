<div id="search" class="input-group">
	<div class="input-group-btn dropdown">
		<button type="button" class="cats-button hidden-xs btn btn-default btn-lg dropdown-toggle" data-toggle="dropdown" aria-expanded="false" data-hover="dropdown">
			<span class="category-name"><?php echo $oct_search_cat; ?></span><i class="fa fa-caret-down" aria-hidden="true"></i>
		</button>
		<ul class="dropdown-menu">
			<li><a href="#" onclick="return false;" id="0"><?php echo $oct_search_cat; ?></a></li>
			<?php foreach ($search_octcat as $search_octcategory) { ?>
			<li><a href="#" onclick="return false;" id="<?php echo $search_octcategory['category_id']; ?>"><?php echo $search_octcategory['name']; ?></a></li>
			<?php } ?>
			</ul>
		<input class="selected_oct_cat" type="hidden" name="category_id" value="0">
	</div>
  <input type="text" name="search" value="<?php echo $search; ?>" placeholder="<?php echo $text_search; ?>" class="form-control input-lg" />
  <span class="input-group-btn">
    <button type="button"  id="oct-search-button" class="btn btn-default btn-lg btn-search"><i class="fa fa-search"></i></button>
  </span>
  <div id="close-desktop-search" style="display: none;"><i class="fa fa-times" aria-hidden="true"></i></div>
</div>
<style>
  div#close-desktop-search {
    position: absolute;
    right: 1px;
    top: 29px;
    height: 52px;
    z-index: 10;
    cursor: pointer;
}
div#close-desktop-search i {
    line-height: 30px;
    padding: 0 10px;
    border: 0;
    border-radius: 0;
    background-image: none;
    box-shadow: none;
    font-size: 18px;
    background-color: #dedede;
    transition-duration: .2s;
    transition-property: all;
}
  #livesearch_search_results{
    margin: 0;
    padding: 5px;
    position: absolute;
    top: 30px;
    left: 0;
    /*right: 283px;*/
    background-color: #000;
    list-style-type: none;
    z-index: 10;
    min-width: 265px;
    width: auto;
    background-color: rgba(255,255,255,0.98);
    padding: 20px;
    -webkit-box-shadow: 0 5px 41px 0 rgba(0,0,0,0.1);
    -moz-box-shadow: 0 5px 41px 0 rgba(0,0,0,0.1);
    box-shadow: 0 5px 41px 0 rgba(0,0,0,0.1);
    overflow: auto;
    max-height: 500px;
    overflow-y: scroll;
  }
  #livesearch_search_results img {
    border: 1px solid #f0f0f0;
    border-radius: 1px;
    margin-top: 5px;
}
#livesearch_search_results li {
    padding: 5px;
    margin-right: 5px;
    margin-top: 5px;
}
#livesearch_search_results a, #livesearch_search_results a:visited{
    color: #107cab;
    text-decoration: none;
    font-size: 14px;
    font-family: 'Roboto Condensed', sans-serif;
    font-weight: 400;
    text-decoration: none;
}
#livesearch_search_results a:hover{
   color: #E00000;
  text-decoration: underline;
}
</style>