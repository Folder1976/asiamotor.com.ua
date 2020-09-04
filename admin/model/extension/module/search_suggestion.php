<?php
 class ModelExtensionModuleSearchSuggestion extends Model{public function install(){$this->load->model('design/layout');$a7db3a6a00c60755316a907ffd5f2f6c2=$this->model_design_layout->getLayouts();foreach($a7db3a6a00c60755316a907ffd5f2f6c2 as $ae1f967086f9deda548a196c9a87dfd54){$this->db->query("INSERT INTO ".DB_PREFIX."layout_module SET layout_id = '".(int)$ae1f967086f9deda548a196c9a87dfd54['layout_id']."', code = 'search_suggestion', position = 'content_top', sort_order = '0'");}}public function getDefaultOptions(){return array('element'=>"#search input[name='search']",'types_order'=>array('category'=>array('sort'=>0),'manufacturer'=>array('sort'=>1),'information'=>array('sort'=>2),'product'=>array('sort'=>3),),'width'=>"100%",'css'=>' 
#search .dropdown-menu { 
  max-width: 100%;
  overflow: hidden;
}
#search .dropdown-menu, 
#search .dropdown-menu div,
#search .dropdown-menu span {
  padding: 0;
  text-align:left;
}
#search .dropdown-menu  li a,
#search .dropdown-menu  li.disabled {
  padding: 5px 10px;
	white-space: normal;
}
#search .dropdown-menu li {
  list-style-image:  none !important;
	clear: both;
}
.search-suggestion {
  overflow: hidden;
  width: 100%;
}
.search-suggestion span {
  margin-right: 5px;	
}
.search-suggestion .label {
  font-weight: bold;	
  color: black;
}
.search-suggestion  .image img {
  border: 1px solid #E7E7E7;
}
.search-suggestion  .price-old {
  margin-right: 2px;
  color: #F00;
  text-decoration: line-through;
}
.search-suggestion  .price-new {
  font-weight: bold;
}','product'=>array('status'=>1,'title'=>array('1'=>'Products'),'order'=>'name','order_dir'=>'asc','logic'=>'or','limit'=>7,'more'=>1,'search_by'=>array('name'=>1,'tags'=>1,'description'=>1),'fields'=>array('image'=>array('sort'=>0,'show'=>1,'width'=>40,'height'=>40,'location'=>'newline','css'=>'float: left;
margin: 0 5px 0 0;'),'name'=>array('sort'=>1,'show'=>1,'location'=>'newline','css'=>'font-weight: bold;
text-decoration: none;
'),'price'=>array('sort'=>2,'show'=>1,'show_field_name'=>1,'location'=>'newline'),'manufacturer'=>array('sort'=>3,'show_field_name'=>1,'location'=>'inline'),'model'=>array('sort'=>4,'show_field_name'=>1,'location'=>'inline'),'sku'=>array('sort'=>5,'show_field_name'=>1,'location'=>'inline'),'upc'=>array('sort'=>6,'show_field_name'=>1,'location'=>'inline'),'ean'=>array('sort'=>7,'show_field_name'=>1,'location'=>'inline'),'jan'=>array('sort'=>8,'show_field_name'=>1,'location'=>'inline'),'isbn'=>array('sort'=>9,'show_field_name'=>1,'location'=>'inline'),'mpn'=>array('sort'=>10,'show_field_name'=>1,'location'=>'inline'),'quantity'=>array('sort'=>11,'show_field_name'=>1,'location'=>'inline'),'description'=>array('sort'=>12,'cut'=>50,'location'=>'newline','css'=>''),'attributes'=>array('sort'=>13,'cut'=>50,'separator'=>' / ','show_field_name'=>1,'location'=>'newline',),'rating'=>array('sort'=>14,'show_field_name'=>1,'location'=>'newline',),'cart'=>array('sort'=>15,'show_field_name'=>0,'location'=>'newline','code'=>'<button type="button" onclick="ss_cart_add(\'product_id\', \'minimum\');" class="btn btn-primary btn-sm"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs hidden-sm hidden-md">button_cart</span></button>'))),'category'=>array('status'=>1,'title'=>array('1'=>'Categories'),'order'=>'name','order_dir'=>'asc','logic'=>'or','limit'=>3,'search_by'=>array('name'=>array('status'=>1,'weight'=>20,),'description'=>array('status'=>1,'weight'=>10,'css'=>'margin-left: 50px;
width: 100%;'),),'fields'=>array('image'=>array('sort'=>0,'show'=>1,'width'=>40,'height'=>40,'location'=>'newline','css'=>'float: left;
margin: 0 5px 0 0;'),'name'=>array('sort'=>1,'show'=>1,'location'=>'newline','css'=>'font-weight: bold;
text-decoration: none;
'),'description'=>array('sort'=>2,'cut'=>50,'location'=>'newline',),),),'manufacturer'=>array('status'=>1,'title'=>array('1'=>'Manufacturers'),'order'=>'name','order_dir'=>'asc','logic'=>'or','limit'=>3,'search_by'=>array('name'=>1,),'fields'=>array('image'=>array('sort'=>0,'show'=>1,'width'=>40,'height'=>40,'location'=>'newline','css'=>'float: left;
margin: 0 5px 0 0;'),'name'=>array('sort'=>1,'show'=>1,'location'=>'newline','css'=>'font-weight: bold;
text-decoration: none;
'),),),'information'=>array('status'=>1,'title'=>array('1'=>'Information'),'order'=>'title','order_dir'=>'asc','logic'=>'or','limit'=>3,'search_by'=>array('title'=>array('status'=>1,'weight'=>20,),'description'=>array('status'=>1,'weight'=>10,),),'fields'=>array('title'=>array('sort'=>1,'show'=>1,'location'=>'newline','css'=>'font-weight: bold;
text-decoration: none;
'),'description'=>array('sort'=>2,'cut'=>50,'location'=>'newline','css'=>''),),),);}}
//author sv2109 (sv2109@gmail.com) license for 1 product copy granted for ydimas (ydimas@gmail.com asiamotor.com.ua)
