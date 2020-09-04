<?php
class ControllerCommonFooter extends Controller {

			public function getOctPolicy() {
				$data = array();
				
				if(isset($this->request->server['HTTP_X_REQUESTED_WITH']) && !empty($this->request->server['HTTP_X_REQUESTED_WITH']) && strtolower($this->request->server['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest' && $this->config->get('config_maintenance') == 0) {
					$this->load->language('octemplates/oct_luxury');
			        $data['oct_policy_accept'] = $this->language->get('oct_policy_accept');
			        $data['oct_policy_more'] = $this->language->get('oct_policy_more');
					
			        $data['text_oct_policy'] = false;
			        $data['oct_max_day'] = 365;
			        $data['oct_policy_value'] = 'oct_policy';
			        $data['oct_policy_day_now'] = date("Y-m-d H:i:s");
			        
			        $oct_policy_status = $this->config->get('oct_policy_status');
					$oct_policy_data = $this->config->get('oct_policy_data');
			        
			        if (isset($oct_policy_data['value']) && $oct_policy_data['value'] && !empty($oct_policy_data['value'])) {
		            	$data['oct_policy_value'] = $oct_policy_value = $oct_policy_data['value'];
		        	}
			        
			        if ($oct_policy_status && (!isset($this->request->cookie[$oct_policy_value]) || !$this->request->cookie[$oct_policy_value])) {
			            if (isset($oct_policy_data['module_text'][(int)$this->config->get('config_language_id')]) && !empty($oct_policy_data['module_text'][(int)$this->config->get('config_language_id')])) {
			            	$data['text_oct_policy'] = strip_tags(html_entity_decode($oct_policy_data['module_text'][(int)$this->config->get('config_language_id')], ENT_QUOTES, 'UTF-8'));
			            	
			            	if (isset($oct_policy_data['indormation_id']) && $oct_policy_data['indormation_id']) {
				            	$data['text_oct_policy'] .= ' <a target="_blank" href="'. $this->url->link('information/information', 'information_id=' . $oct_policy_data['indormation_id']) . '">' . $data['oct_policy_more'] . '</a>';
			            	}
							
			            	if (isset($oct_policy_data['max_day']) && $oct_policy_data['max_day'] && !empty($oct_policy_data['max_day'])) {
				            	$data['oct_max_day'] = (int)$oct_policy_data['max_day'];
			            	}
						}
			        }
				}
				
				$this->response->addHeader('Content-Type: application/json');
				$this->response->setOutput(json_encode($data));
			}
			
	public function index() {

        // oct_popup_call_phone start
        $data['oct_popup_call_phone_data'] = $this->config->get('oct_popup_call_phone_data');
        $data['popup_call_phone_text'] = $this->language->load('extension/module/oct_popup_call_phone');
        // oct_popup_call_phone end
      
		$this->load->language('common/footer');


            if ($this->config->get('oct_analytics_status') && $this->config->get('oct_analytics_position') == 1) {
				$data['analytics'] = $this->load->controller('extension/analytics/oct_analytics', $this->config->get('oct_analytics_status'));
			}
          
		$data['scripts'] = $this->document->getScripts('footer');

		$data['text_information'] = $this->language->get('text_information');
		$data['text_service'] = $this->language->get('text_service');
		$data['text_extra'] = $this->language->get('text_extra');
		$data['text_contact'] = $this->language->get('text_contact');
		$data['text_return'] = $this->language->get('text_return');
		$data['text_sitemap'] = $this->language->get('text_sitemap');
		$data['text_manufacturer'] = $this->language->get('text_manufacturer');
		$data['text_voucher'] = $this->language->get('text_voucher');
		$data['text_affiliate'] = $this->language->get('text_affiliate');
		$data['text_special'] = $this->language->get('text_special');
		$data['text_account'] = $this->language->get('text_account');
		$data['text_order'] = $this->language->get('text_order');
		$data['text_wishlist'] = $this->language->get('text_wishlist');
		$data['text_newsletter'] = $this->language->get('text_newsletter');

                $data['text_question'] = $this->language->get('text_question');
                

		$this->load->model('catalog/information');

	        // start: oct_policy
	        $data['oct_policy_value'] = false;
	        
	        $oct_policy_status = $this->config->get('oct_policy_status');
			$oct_policy_data = $this->config->get('oct_policy_data');
	        
	        if (isset($oct_policy_data['value']) && $oct_policy_data['value'] && !empty($oct_policy_data['value']) && ($oct_policy_status && (!isset($this->request->cookie[$oct_policy_data['value']]) || !$this->request->cookie[$oct_policy_data['value']])) && $this->config->get('config_maintenance') == 0) {
            	$data['oct_policy_value'] = $oct_policy_data['value'];
        	}
			// end: oct_policy
			

		$data['informations'] = array();

		foreach ($this->model_catalog_information->getInformations() as $result) {
			if ($result['bottom']) {
				$data['informations'][] = array(
					'title' => $result['title'],
					'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
				);
			}
		}


			$oct_data = $this->config->get('oct_luxury_data');

			// Настройки параметров отображения элементов в подвале сайта
	        $data['oct_luxury_status'] = $this->config->get('oct_luxury_status');
	        $data['oct_luxury_foot_logo'] = $oct_data['foot_logo'];
		    $data['oct_luxury_foot_1stline'] = $oct_data['foot_1stline'];
		    $data['oct_luxury_foot_2ndline'] = $oct_data['foot_2ndline'];
		    $data['oct_luxury_foot_3dline'] = $oct_data['foot_3dline'];
		    $data['oct_luxury_foot_infolinks'] = $oct_data['foot_infolinks'];
		    $data['oct_luxury_foot_garanted'] = $oct_data['foot_garanted'];

			// Контактная информация
			$data['oct_luxury_cont_phones'] = array_values(array_filter(explode(PHP_EOL, $oct_data['cont_phones'])));
		    $data['oct_luxury_cont_skype'] = $oct_data['cont_skype'];
		    $data['oct_luxury_cont_email'] = $oct_data['cont_email'];

			// Вывод ссылок на статьи
			$data['footer_informations'] = array();
			
			if(isset($oct_data['footer_information_links'])) {
				foreach ($this->model_catalog_information->getOCTInformations($oct_data['footer_information_links']) as $result) {
					$data['footer_informations'][] = array(
						'information_id'  => $result['information_id'],
						'title'       => $result['title'],
						'href'  => $this->url->link('information/information', 'information_id=' . $result['information_id'])
					);
				}
			}

			$data['name'] = $this->config->get('config_name');

			if ($this->request->server['HTTPS']) {
				$server = $this->config->get('config_ssl');
			} else {
				$server = $this->config->get('config_url');
			}

			if (is_file(DIR_IMAGE . $this->config->get('config_logo'))) {
				$data['logo'] = $server . 'image/' . $this->config->get('config_logo');
			} else {
				$data['logo'] = '';
			}

		    $oct_luxury_foot_garanted = $oct_data['foot_garanted'];
		    if(empty($oct_luxury_foot_garanted[$this->session->data['language']])) {
				$data['oct_luxury_garanted'] = false;
		    } else if (isset($oct_luxury_foot_garanted[$this->session->data['language']])) {
				$data['oct_luxury_garanted'] = html_entity_decode($oct_luxury_foot_garanted[$this->session->data['language']], ENT_QUOTES, 'UTF-8');
		    }
		
		    $oct_luxury_cont_adress = $oct_data['cont_adress'];
		    
		    if(empty($oct_luxury_cont_adress[$this->session->data['language']])) {
				$data['oct_luxury_cont_adress'] = false;
		    } else if (isset($oct_luxury_cont_adress[$this->session->data['language']])) {
				$data['oct_luxury_cont_adress'] = html_entity_decode($oct_luxury_cont_adress[$this->session->data['language']], ENT_QUOTES, 'UTF-8');
		    }
		
		    $oct_luxury_cont_clock = $oct_data['cont_clock'];
	        
	        if(empty($oct_luxury_cont_clock[$this->session->data['language']])) {
				$data['oct_luxury_cont_clock'] = false;
		    } else if (isset($oct_luxury_cont_clock[$this->session->data['language']])) {
		        $data['oct_luxury_cont_clock'] = array_values(array_filter(explode(PHP_EOL, $oct_luxury_cont_clock[$this->session->data['language']])));
		    }

			// Социальные сети
	        $data['oct_luxury_ps_facebook_id']      = $oct_data['ps_facebook_id'];
	        $data['oct_luxury_ps_vk_id']            = $oct_data['ps_vk_id'];
	        $data['oct_luxury_ps_gplus_id']           = $oct_data['ps_gplus_id'];
	        $data['oct_luxury_ps_odnoklass_id']       = $oct_data['ps_odnoklass_id'];
	        $data['oct_luxury_ps_twitter_username']   = $oct_data['ps_twitter_username'];
	        $data['oct_luxury_ps_vimeo_id']         = $oct_data['ps_vimeo_id'];
	        $data['oct_luxury_ps_pinterest_id']       = $oct_data['ps_pinterest_id'];
	        $data['oct_luxury_ps_flick_id']         = $oct_data['ps_flick_id'];
	        $data['oct_luxury_ps_instagram']        = $oct_data['ps_instagram'];
	        $data['oct_luxury_ps_youtube_id']         = $oct_data['ps_youtube_id'];
	        $data['oct_luxury_ps_whatsapp_id']         = (isset($oct_data['ps_whatsapp_id'])) ? $oct_data['ps_whatsapp_id'] : '';
	        $data['oct_luxury_ps_telegram_id']         = (isset($oct_data['ps_telegram_id'])) ? $oct_data['ps_telegram_id'] : '';
	        $data['oct_luxury_ps_viber_id']         = (isset($oct_data['ps_viber_id'])) ? $oct_data['ps_viber_id'] : '';
	
	        // Платежные системы
	        $data['oct_luxury_ps_sberbank']         = $oct_data['ps_sberbank'];
	        $data['oct_luxury_ps_privat']             = $oct_data['ps_privat'];
	        $data['oct_luxury_ps_yamoney']        = $oct_data['ps_yamoney'];
	        $data['oct_luxury_ps_webmoney']         = $oct_data['ps_webmoney'];
	        $data['oct_luxury_ps_visa']             = $oct_data['ps_visa'];
	        $data['oct_luxury_ps_qiwi']             = $oct_data['ps_qiwi'];
	        $data['oct_luxury_ps_skrill']             = $oct_data['ps_skrill'];
	        $data['oct_luxury_ps_interkassa']         = $oct_data['ps_interkassa'];
	        $data['oct_luxury_ps_liqpay']             = $oct_data['ps_liqpay'];
	        $data['oct_luxury_ps_paypal']           = $oct_data['ps_paypal'];
	        $data['oct_luxury_ps_robokassa']        = $oct_data['ps_robokassa'];
	
	        $data['ps_additional_icons'] = array();
	
	        $this->load->model('tool/image');
	
	        if (isset($oct_data['ps_additional_icons']) && $oct_data['ps_additional_icons']) {
				foreach ($oct_data['ps_additional_icons'] as $ps_additional_icon) {
	            	$data['ps_additional_icons'][] = array(
						'image'      => $this->model_tool_image->resize($ps_additional_icon['image'], 53, 33),
						'sort_order' => ($ps_additional_icon['sort_order']) ? $ps_additional_icon['sort_order'] : 0
					);
				}
	
				foreach ($data['ps_additional_icons'] as $key => $value) {
	            	$sort_order[$key] = $value['sort_order'];
				}
	
				array_multisort($sort_order, SORT_ASC, $data['ps_additional_icons']);
	        }
			
		$data['contact'] = $this->url->link('information/contact');
		$data['return'] = $this->url->link('account/return/add', '', true);
		$data['sitemap'] = $this->url->link('information/sitemap');
		$data['manufacturer'] = $this->url->link('product/manufacturer');
		$data['voucher'] = $this->url->link('account/voucher', '', true);
		$data['affiliate'] = $this->url->link('affiliate/account', '', true);
		$data['special'] = $this->url->link('product/special');
		$data['account'] = $this->url->link('account/account', '', true);
		$data['order'] = $this->url->link('account/order', '', true);
		$data['wishlist'] = $this->url->link('account/wishlist', '', true);
		$data['newsletter'] = $this->url->link('account/newsletter', '', true);

                $data['phone'] = $this->config->get('config_telephone');
                

		$data['powered'] = sprintf($this->language->get('text_powered'), $this->config->get('config_name'), date('Y', time()));

		// Whos Online
		if ($this->config->get('config_customer_online')) {
			$this->load->model('tool/online');

			if (isset($this->request->server['REMOTE_ADDR'])) {
				$ip = $this->request->server['REMOTE_ADDR'];
			} else {
				$ip = '';
			}

			if (isset($this->request->server['HTTP_HOST']) && isset($this->request->server['REQUEST_URI'])) {
				$url = 'http://' . $this->request->server['HTTP_HOST'] . $this->request->server['REQUEST_URI'];
			} else {
				$url = '';
			}

			if (isset($this->request->server['HTTP_REFERER'])) {
				$referer = $this->request->server['HTTP_REFERER'];
			} else {
				$referer = '';
			}

			$this->model_tool_online->addOnline($ip, $this->customer->getId(), $url, $referer);
		}

		return $this->load->view('common/footer', $data);
	}
}
