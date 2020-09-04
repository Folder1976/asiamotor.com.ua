<?php
class ControllerCommonHeader extends Controller {
	public function index() {

        // subscribe start
        $data['oct_popup_subscribe_form_data'] = $this->config->get('oct_popup_subscribe_form_data');
        // subscribe end
        

        // oct_popup_purchase start
        $data['oct_popup_purchase_data'] = $this->config->get('oct_popup_purchase_data');
        // oct_popup_purchase end
      

        // oct_popup_found_cheaper start
        $data['oct_popup_found_cheaper_data'] = $this->config->get('oct_popup_found_cheaper_data');
        // oct_popup_found_cheaper end
      

        // oct_popup_call_phone start
        $data['oct_popup_call_phone_data'] = $this->config->get('oct_popup_call_phone_data');
        $data['popup_call_phone_text'] = $this->language->load('extension/module/oct_popup_call_phone');
        // oct_popup_call_phone end
      

        // oct_product_preorder start
        $data['oct_product_preorder_data'] = $this->config->get('oct_product_preorder_data');
        // oct_product_preorder end
      
		// Analytics
		$this->load->model('extension/extension');

		$data['analytics'] = array();

		$analytics = $this->model_extension_extension->getExtensions('analytics');

		foreach ($analytics as $analytic) {

			if (!$this->config->get($analytic['code'] . '_position')) {
			
			if ($this->config->get($analytic['code'] . '_status')) {
				$data['analytics'][] = $this->load->controller('extension/analytics/' . $analytic['code'], $this->config->get($analytic['code'] . '_status'));

            }
			
			}
		}

		if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
			$server = $this->config->get('config_ssl');
		} else {
			$server = $this->config->get('config_url');
		}

		if (is_file(DIR_IMAGE . $this->config->get('config_icon'))) {
			$this->document->addLink($server . 'image/' . $this->config->get('config_icon'), 'icon');
		}


		  	if ($this->config->get('oct_analytics_google_status') && $this->config->get('oct_analytics_google_webmaster_code')) {
            	$data['oct_analytics_google_webmaster_code'] = html_entity_decode($this->config->get('oct_analytics_google_webmaster_code'), ENT_QUOTES, 'UTF-8');
            }

            if ($this->config->get('oct_analytics_yandex_status') && $this->config->get('oct_analytics_yandex_webmaster_code')) {
                $data['oct_analytics_yandex_webmaster_code'] = html_entity_decode($this->config->get('oct_analytics_yandex_webmaster_code'), ENT_QUOTES, 'UTF-8');
            }
			

			$this->document->addScript('catalog/view/javascript/jquery/jquery-2.1.1.min.js', 'header', 'octemplates');
			$this->document->addScript('catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js', 'header', 'octemplates');
			$this->document->addScript('catalog/view/javascript/octemplates/common.js', 'header', 'octemplates');
			$this->document->addScript('catalog/view/theme/oct_luxury/js/main.js', 'header', 'octemplates');
			$this->document->addScript('catalog/view/theme/oct_luxury/js/input-mask.js', 'header', 'octemplates');
			$this->document->addScript('catalog/view/javascript/bootstrap/js/bootstrap.min.js', 'header', 'octemplates');
			$this->document->addScript('catalog/view/theme/oct_luxury/js/barrating.js', 'header', 'octemplates');
			$this->document->addScript('catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js', 'header', 'octemplates');
			$this->document->addScript('catalog/view/javascript/octemplates/tippy/tippy.min.js', 'header', 'octemplates');
			
		$data['title'] = $this->document->getTitle();

		$data['base'] = $server;
		$data['description'] = $this->document->getDescription();
		$data['keywords'] = $this->document->getKeywords();
		$data['links'] = $this->document->getLinks();
$data['robots'] = $this->document->getRobots();
		
			
		
			$data['scripts'] = array();
			$data['scriptes'] = array();
			
			$folder = $_SERVER['DOCUMENT_ROOT'].str_replace('index.php','',$_SERVER['SCRIPT_NAME']);
			
			foreach ($this->document->getScripts('header', 'octemplates') as $script) {
				$del_version = explode("?", $script);

				if (file_exists($folder.$del_version[0])) {
					$data['scripts'][$script] = ltrim($del_version[0], "/");
				} else {
					$data['scriptes'][$script] = $script;
				}
			}
			
			$data['styles'] = array();
			$data['styless'] = array();
			
			foreach ($this->document->getStyles() as $style) {
				$del_version = explode("?", $style['href']);
				
				if (file_exists($folder.$del_version[0])) {
					$data['styles'][$style['href']] = array(
						'href'  => ltrim($del_version[0], "/"),
						'rel'   => $style['rel'],
						'media' => $style['media']
					);
				} else {
					$data['styless'][$style['href']] = array(
						'href'  => $style['href'],
						'rel'   => $style['rel'],
						'media' => $style['media']
					);
				}
			}
			
		$data['lang'] = $this->language->get('code');
		$data['direction'] = $this->language->get('direction');
		

		
		
		$data['name'] = $this->config->get('config_name');

		if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
			$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
		} else {
			$data['logo'] = '';
		}

		$this->load->language('common/header');
		$data['og_url'] = (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1')) ? HTTPS_SERVER : HTTP_SERVER) . substr($this->request->server['REQUEST_URI'], 1, (strlen($this->request->server['REQUEST_URI'])-1));
		$data['og_image'] = $this->document->getOgImage();


        // oct_blog start
        if (isset($this->request->get['oct_blog_article_id'])) {
          $oct_blog_article_id = (int)$this->request->get['oct_blog_article_id'];
        } else {
          $oct_blog_article_id = 0;
        }

        $this->load->model('octemplates/blog_article');
        $article_info = $this->model_octemplates_blog_article->getArticle($oct_blog_article_id);

        $data['og_meta_description'] = "";

        if ($article_info) {
          $this->load->model('tool/image');
          $data['og_image'] = $this->model_tool_image->resize($article_info['image'], 500, 500);
          $data['og_meta_description'] = utf8_substr(strip_tags(html_entity_decode($article_info['meta_description'], ENT_QUOTES, 'UTF-8')), 0, 250);
        }
        // oct_blog end
        
		$data['text_home'] = $this->language->get('text_home');

		// Wishlist
		if ($this->customer->isLogged()) {
			$this->load->model('account/wishlist');

			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), $this->model_account_wishlist->getTotalWishlist());
			$data['w_name'] = $this->customer->getFirstName()." ".$this->customer->getLastName();
		} else {
			$data['text_wishlist'] = sprintf($this->language->get('text_wishlist'), (isset($this->session->data['wishlist']) ? count($this->session->data['wishlist']) : 0));
		}

		$data['text_shopping_cart'] = $this->language->get('text_shopping_cart');
		$data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', true), $this->customer->getFirstName(), $this->url->link('account/logout', '', true));

		$data['text_account'] = $this->language->get('text_account');
		$data['text_register'] = $this->language->get('text_register');
		$data['text_login'] = $this->language->get('text_login');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_transaction'] = $this->language->get('text_transaction');
		$data['text_download'] = $this->language->get('text_download');
		$data['text_logout'] = $this->language->get('text_logout');
		$data['text_checkout'] = $this->language->get('text_checkout');

			$data['text_page'] = $this->language->get('text_page');
			
		$data['text_page'] = $this->language->get('text_page');
		$data['text_category'] = $this->language->get('text_category');
		$data['text_all'] = $this->language->get('text_all');

		$data['home'] = $this->url->link('common/home');
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['logged'] = $this->customer->isLogged();
		$data['account'] = $this->url->link('account/account', '', true);
		$data['register'] = $this->url->link('account/register', '', true);
		$data['login'] = $this->url->link('account/login', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['transaction'] = $this->url->link('account/transaction', '', true);
		$data['download'] = $this->url->link('account/download', '', true);
		$data['logout'] = $this->url->link('account/logout', '', true);
		$data['shopping_cart'] = $this->url->link('checkout/cart');
		$data['checkout'] = $this->url->link('checkout/checkout', '', true);
		$data['contact'] = $this->url->link('information/contact');
		$data['telephone'] = $this->config->get('config_telephone');

                $data['address'] = $this->config->get('config_address');
                $data['email'] = $this->config->get('config_email');
                

			$this->load->language('octemplates/oct_luxury');
		  	$data['text_compare'] = $this->language->get('text_compare');
	  		$data['oct_search'] = $this->language->get('oct_search');
		    $data['oct_head_info'] = $this->language->get('oct_head_info');
		    $data['oct_head_settings'] = $this->language->get('oct_head_settings');
		    $data['oct_head_feedback'] = $this->language->get('oct_head_feedback');
		    $data['oct_head_news'] = $this->language->get('oct_head_news');
		    $data['oct_head_contact'] = $this->language->get('oct_head_contact');
		    $data['text_oct_menu'] = $this->language->get('text_oct_menu');
		    $data['text_oct_back'] = $this->language->get('text_oct_back');
		    
		    $data['compare'] = $this->url->link('product/compare');
		    $data['newslink'] = $this->url->link('octemplates/blog_articles');
		    $data['contactlink'] = $this->url->link('information/contact');
	
	      	$oct_data = $this->config->get('oct_luxury_data');
	        $data['oct_luxury_status'] = $this->config->get('oct_luxury_status');
	        $data['shownews'] = $oct_data['shownews'];
			$data['showcontacts'] = $oct_data['showcontacts'];
			$data['minifyjscss'] = isset($oct_data['minifyjscss']) ? $oct_data['minifyjscss'] : 'on';
			
	        // Настройки основных цветов
	        $data['oct_luxury_maincolor1']                  = $oct_data['maincolor1'];
	        $data['oct_luxury_maincolor2']                  = $oct_data['maincolor2'];
	        $data['oct_luxury_maincolor3']                  = $oct_data['maincolor3'];

	        // Шапка сайта - настройки цветов
	        $data['oct_luxury_head_1bge']                   = $oct_data['head_1bge'];
	        $data['oct_luxury_head_1linkcolore']              = $oct_data['head_1linkcolore'];
	        $data['oct_luxury_head_2bg']                  = $oct_data['head_2bg'];
	        $data['oct_luxury_head_infocolor']              = $oct_data['head_infocolor'];
	        $data['oct_luxury_head_linecolor']                = $oct_data['head_linecolor'];
	        $data['oct_luxury_head_linecolor_hover']          = $oct_data['head_linecolor_hover'];
	        $data['oct_luxury_head_tooltiplinkcolor']           = $oct_data['head_tooltiplinkcolor'];
	        $data['oct_luxury_text_head_tooltiplinkcolor_h']    = $oct_data['text_head_tooltiplinkcolor_h'];
	        $data['oct_luxury_head_bgsrchcat']              = $oct_data['head_bgsrchcat'];
	        $data['oct_luxury_head_bgsrchcattext']          = $oct_data['head_bgsrchcattext'];
	        $data['oct_luxury_head_srch']                   = $oct_data['head_srch'];
	        $data['oct_luxury_head_srchcolors']               = $oct_data['head_srchcolors'];
	        $data['oct_luxury_head_bgcart']                 = $oct_data['head_bgcart'];
	        $data['oct_luxury_head_bgcart2']                = $oct_data['head_bgcart2'];
	        $data['oct_luxury_head_textcart2']              = $oct_data['head_textcart2'];
	        $data['oct_luxury_head_menu_text']              = $oct_data['head_menu_text'];
	        $data['oct_luxury_head_bgmenu']                 = $oct_data['head_bgmenu'];
	        $data['oct_luxury_head_maincolormenu']          = $oct_data['head_maincolormenu'];
	        $data['oct_luxury_head_maincolormenu_h']        = $oct_data['head_maincolormenu_h'];
	        $data['oct_luxury_head_bgchildmenu']            = $oct_data['head_bgchildmenu'];
	        $data['oct_luxury_head_parentcolor']            = $oct_data['head_parentcolor'];
	        $data['oct_luxury_head_parentcolor_hover']        = $oct_data['head_parentcolor_hover'];
	        $data['oct_luxury_head_childcolor']               = $oct_data['head_childcolor'];
			$data['oct_luxury_head_childcolor_hover']         = $oct_data['head_childcolor_hover'];

	        // Подвал сайта - настройки цветов
	        $data['oct_luxury_foot_1stlinebg']                = $oct_data['foot_1stlinebg'];
	        $data['oct_luxury_foot_linelogo']                 = $oct_data['foot_linelogo'];
	        $data['oct_luxury_foot_titlecolor']                 = $oct_data['foot_titlecolor'];
	        $data['oct_luxury_foot_linkcolor']                = $oct_data['foot_linkcolor'];
	        $data['oct_luxury_foot_linelinks']                = $oct_data['foot_linelinks'];
	        $data['oct_luxury_foot_garantedcolors']           = $oct_data['foot_garantedcolors'];
	        $data['oct_luxury_foot_garantedtext']             = $oct_data['foot_garantedtext'];
	        $data['oct_luxury_foot_2ndlinebg']              = $oct_data['foot_2ndlinebg'];
	        $data['oct_luxury_foot_iconscolor']               = $oct_data['foot_iconscolor'];
	        $data['oct_luxury_foot_2ndlinetcolor']            = $oct_data['foot_2ndlinetcolor'];
	        $data['oct_luxury_foot_2linelink']                = $oct_data['foot_2linelink'];
	        $data['oct_luxury_foot_3dlinebg']                 = $oct_data['foot_3dlinebg'];
	        $data['oct_luxury_foot_icocolor']                 = $oct_data['foot_icocolor'];
	
	        // Категории - настройки
	        $data['oct_luxury_cat_sorttype']                = $oct_data['cat_sorttype'];
	        $data['oct_luxury_cat_sortcolor']                 = $oct_data['cat_sortcolor'];
	        $data['oct_luxury_cat_hovercolor']              = $oct_data['cat_hovercolor'];
	        $data['oct_luxury_cat_discountbg']              = $oct_data['cat_discountbg'];
	        $data['oct_luxury_cat_discountcolor']             = $oct_data['cat_discountcolor'];
	        $data['oct_luxury_cat_boxtext']                   = $oct_data['cat_boxtext'];
	        $data['oct_luxury_cat_boxbg']                   = $oct_data['cat_boxbg'];
	        $data['oct_luxury_cat_moduleborder']            = $oct_data['cat_moduleborder'];
	        $data['oct_luxury_cat_modulebg']                = $oct_data['cat_modulebg'];
	        $data['oct_luxury_cat_itembg']                  = $oct_data['cat_itembg'];
	        $data['oct_luxury_cat_plusminus']                 = $oct_data['cat_plusminus'];
	        $data['oct_luxury_cat_checkbox']                = $oct_data['cat_checkbox'];
	        $data['oct_luxury_cat_checkboxactive']          = $oct_data['cat_checkboxactive'];
	        $data['oct_luxury_cat_1levelbg']                = $oct_data['cat_1levelbg'];
	        $data['oct_luxury_cat_1levelcolor']               = $oct_data['cat_1levelcolor'];
	        $data['oct_luxury_cat_2levelbg']                = $oct_data['cat_2levelbg'];
	        $data['oct_luxury_cat_2levelcolor']               = $oct_data['cat_2levelcolor'];
	        $data['oct_luxury_cat_3levelbg']                = $oct_data['cat_3levelbg'];
	        $data['oct_luxury_cat_3levelcolor']               = $oct_data['cat_3levelcolor'];
	        $data['oct_luxury_cat_3levelbgactive']            = $oct_data['cat_3levelbgactive'];
	        $data['oct_luxury_cat_3leveltextactive']          = $oct_data['cat_3leveltextactive'];

	        // Карточка товаров - настройки цветов
	        $data['oct_luxury_pr_garantedcolor']              = $oct_data['pr_garantedcolor'];
	        $data['oct_luxury_pr_garantedicon']               = $oct_data['pr_garantedicon'];
	        $data['oct_luxury_pr_photoborder']              = $oct_data['pr_photoborder'];
	        $data['oct_luxury_pr_photoborderhover']           = $oct_data['pr_photoborderhover'];
	        $data['oct_luxury_pr_bgright']                  = $oct_data['pr_bgright'];
	        $data['oct_luxury_pr_activetabtext']              = $oct_data['pr_activetabtext'];
	        $data['oct_luxury_pr_activetabbg']              = $oct_data['pr_activetabbg'];
	        $data['oct_luxury_pr_activetabbgcont']            = $oct_data['pr_activetabbgcont'];
	        $data['oct_luxury_pr_activetabbgtext']            = $oct_data['pr_activetabbgtext'];
	        $data['oct_luxury_pr_tabtext']                  = $oct_data['pr_tabtext'];
	        $data['oct_luxury_pr_manufact_and_code']        = $oct_data['pr_manufact_and_code'];
	        $data['oct_luxury_pr_foundcheaper']               = $oct_data['pr_foundcheaper'];
	        $data['oct_luxury_pr_buyoneclick']              = $oct_data['pr_buyoneclick'];
	        $data['oct_luxury_pr_pricecolor']                 = $oct_data['pr_pricecolor'];
	        $data['oct_luxury_pr_oldpricecolor']              = $oct_data['pr_oldpricecolor'];
	
	         // Мобильная версия - настройки
	        $data['oct_luxury_mob_mainlinebg']              = $oct_data['mob_mainlinebg'];
	        $data['oct_luxury_mob_cartbg']                  = $oct_data['mob_cartbg'];
	        $data['oct_luxury_mob_carttexticocolor']          = $oct_data['mob_carttexticocolor'];
	        $data['oct_luxury_mob_menubg']                = $oct_data['mob_menubg'];
	        $data['oct_luxury_mob_menucolor']               = $oct_data['mob_menucolor'];
	        $data['oct_luxury_mob_sbbg']                  = $oct_data['mob_sbbg'];
	        $data['oct_luxury_mob_sbh3']                  = $oct_data['mob_sbh3'];
	        $data['oct_luxury_mob_sblinkcolor']               = $oct_data['mob_sblinkcolor'];
	        $data['oct_luxury_mob_sbbuttoncolor']             = $oct_data['mob_sbbuttoncolor'];
	        $data['oct_luxury_mob_sbbuttonicon']            = $oct_data['mob_sbbuttonicon'];
	        $data['oct_luxury_mob_sbbuttoncoloropened']     = $oct_data['mob_sbbuttoncoloropened'];
	        $data['oct_luxury_mob_sbbuttoniconopened']      = $oct_data['mob_sbbuttoniconopened'];
	
	        // Контактная информация
	        $data['oct_luxury_cont_phones'] = array_values(array_filter(explode(PHP_EOL, $oct_data['cont_phones'])));
	        $data['oct_luxury_cont_contactmap'] = $oct_data['cont_contactmap'];

			$data['text_price_download'] = $this->language->get('text_price_download');
			
			
	        if(isset($oct_data['cont_clock'])) {
				$oct_luxury_cont_clock = $oct_data['cont_clock'];
				if(empty($oct_luxury_cont_clock[$this->session->data['language']])) {
					$data['oct_luxury_cont_clock'] = false;
				} else if (isset($oct_luxury_cont_clock[$this->session->data['language']])) {
					$data['oct_luxury_cont_clock'] = array_values(array_filter(explode(PHP_EOL, $oct_luxury_cont_clock[$this->session->data['language']])));
				}
		    } else {
				$data['oct_luxury_cont_clock'] = false;
		    }
	
		    if(isset($oct_data['cont_adress'])) {
		    $oct_luxury_cont_adress = $oct_data['cont_adress'];
		        if(empty($oct_luxury_cont_adress[$this->session->data['language']])) {
		        	$data['oct_luxury_cont_adress'] = false;
				} else if (isset($oct_luxury_cont_adress[$this->session->data['language']])) {
		        	$data['oct_luxury_cont_adress'] = html_entity_decode($oct_luxury_cont_adress[$this->session->data['language']], ENT_QUOTES, 'UTF-8');
				}
		    } else {
				$data['cont_adress'] = false;
		    }
	
			// Вывод ссылок на статьи
			$data['header_informations'] = array();
			
			if(isset($oct_data['header_information_links']) && $this->config->get('config_maintenance') != 1) {
				foreach ($this->model_catalog_information->getOCTInformations($oct_data['header_information_links']) as $result) {
					$data['header_informations'][] = array(
						'information_id'  => $result['information_id'],
						'title'       => $result['title'],
						'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
					);
		        }
			}
	
			// Свой CSS и Javascript код
			$data['oct_luxury_customcss'] = html_entity_decode($oct_data['customcss'], ENT_QUOTES, 'UTF-8');
		    $data['oct_luxury_customjavascrip'] = $oct_data['customjavascrip'];
		    $data['oct_luxury_stick'] = $oct_data['stick'];
			

		// Menu

		    /*
	    	
		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			if (true or $category['top']) {
				// Level 2
				$children_data = array();

				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach ($children as $child) {
					$filter_data = array(
						'filter_category_id'  => $child['category_id'],
						'filter_sub_category' => true
					);

					$children_data[] = array(
						'name'  => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
						'href'  => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);
				}

				// Level 1
				$data['categories'][] = array(
					'name'     => $category['name'],
					'children' => $children_data,
					'column'   => $category['column'] ? $category['column'] : 1,
					'href'     => $this->url->link('product/category', 'path=' . $category['category_id'])
				);
			}
		}


			*/
			
			// start: oct_megamenu
			$data['oct_megamenu_data'] = $this->config->get('oct_megamenu_data');
			$oct_megamenu_data = $this->config->get('oct_megamenu_data');
			if (isset($oct_megamenu_data['status']) && $oct_megamenu_data['status']) {
				$data['oct_megamenu'] = $this->load->controller('extension/module/oct_megamenu');
			}
			// end: oct_megamenu
			

      	$this->load->model('newsblog/category');
        $this->load->model('newsblog/article');

		$data['newsblog_categories'] = array();

		$categories = $this->model_newsblog_category->getCategories(0);

		foreach ($categories as $category) {
			if ($category['settings']) {
				$settings=unserialize($category['settings']);
				if ($settings['show_in_top']==0) continue;
			}

			$articles = array();

			if ($category['settings'] && $settings['show_in_top_articles']) {
				$filter=array('filter_category_id'=>$category['category_id'],'filter_sub_category'=>true);
				$results = $this->model_newsblog_article->getArticles($filter);

				foreach ($results as $result) {
					$articles[] = array(
						'name'        => $result['name'],
						'href'        => $this->url->link('newsblog/article', 'newsblog_path=' . $category['category_id'] . '&newsblog_article_id=' . $result['article_id'])
					);
				}
            }
			$data['categories'][] = array(
				'name'     => $category['name'],
				'children' => $articles,
				'column'   => 1,
				'href'     => $this->url->link('newsblog/category', 'newsblog_path=' . $category['category_id'])
			);
		}
		
		$data['language'] = $this->load->controller('common/language');
		$data['currency'] = $this->load->controller('common/currency');
		$data['search'] = $this->load->controller('common/search');
		$data['cart'] = $this->load->controller('common/cart');

		// For page specific css
		if (isset($this->request->get['route'])) {
			if (isset($this->request->get['product_id'])) {
				$class = '-' . $this->request->get['product_id'];
			} elseif (isset($this->request->get['path'])) {
				$class = '-' . $this->request->get['path'];
			} elseif (isset($this->request->get['manufacturer_id'])) {
				$class = '-' . $this->request->get['manufacturer_id'];
			} elseif (isset($this->request->get['information_id'])) {
				$class = '-' . $this->request->get['information_id'];
			} else {
				$class = '';
			}

			$data['class'] = str_replace('/', '-', $this->request->get['route']) . $class;
		} else {
			$data['class'] = 'common-home';
		}

		require_once('catalog/controller/common/header_include.php');
		return $this->load->view('common/header', $data);
	}
}
