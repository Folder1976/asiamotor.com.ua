<?php
class ControllerInformationInformation extends Controller {
	
	private $delivery_id = 6;
	private $city_delivery_id = 11;
	
	public function index() {
		
		$is_delivery = false;
		
		$this->load->language('information/information');

		$this->load->model('catalog/information');

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);
		

		if (isset($this->request->get['information_id'])) {
			$breadcrumb_information_id = $information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}

		
		if($information_id == $this->delivery_id AND isset($this->request->get['city_alias'])){
			$is_delivery = true;
			
			$city_info = $this->model_catalog_information->getCityId($this->request->get['city_alias']);
			
			$information_id = $this->request->get['information_id'] = $this->city_delivery_id;
			
		}
		
		
		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {

		
			if(isset($city_info) AND $city_info){
				foreach($city_info as $index => $text){
					foreach($information_info as $index2 => $text2){
						$information_info[$index2] = str_replace('@'.$index.'@',$text, $text2);
					}
				}
			}
		
			if ($information_info['meta_title']) {
				$this->document->setTitle($information_info['meta_title']);
			} else {
				$this->document->setTitle($information_info['title']);
			}

			$this->document->setDescription($information_info['meta_description']);
			$this->document->setKeywords($information_info['meta_keyword']);

			$data['breadcrumbs'][] = array(
				'text' => $information_info['title'],
				'href' => $this->url->link('information/information', 'information_id=' .  $breadcrumb_information_id)
			);

			if ($information_info['meta_h1']) {
				$data['heading_title'] = $information_info['meta_h1'];
			} else {
				$data['heading_title'] = $information_info['title'];
			}

			$data['button_continue'] = $this->language->get('button_continue');

			
			$data['description'] = str_replace("<img", "<img class=\"img-responsive\"",  html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8'));
			
			if($information_id == $this->delivery_id OR $is_delivery){
				$filter = array();
				$data['citys'] = $this->model_catalog_information->getCitys($filter);
				$data['main_href'] = HTTP_SERVER.'delivery';
			}


			$data['continue'] = $this->url->link('common/home');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('information/information', $data));
		} else {
			$data['breadcrumbs'][] = array(
				'text' => $this->language->get('text_error'),
				'href' => $this->url->link('information/information', 'information_id=' . $information_id)
			);

			$this->document->setTitle($this->language->get('text_error'));

			
        // start: oct_404_page
        $oct_404_page_data = $this->config->get('oct_404_page_data');

        if (isset($oct_404_page_data) && $oct_404_page_data['status']) {
            if (!empty($oct_404_page_data['module_text'][(int)$this->config->get('config_language_id')]['title'])) {
                $data['heading_title'] = $oct_404_page_data['module_text'][(int)$this->config->get('config_language_id')]['title'];
            } else {
                $data['heading_title'] = $this->language->get('text_error');
            }

            if (isset($oct_404_page_data['image']) && !empty($oct_404_page_data['image'])) {
                if (isset($this->request->server['HTTPS']) && (($this->request->server['HTTPS'] == 'on') || ($this->request->server['HTTPS'] == '1'))) {
        			$data['oct_404_image'] = $this->config->get('config_ssl') . 'image/' . $oct_404_page_data['image'];
        		} else {
        			$data['oct_404_image'] = $this->config->get('config_url') . 'image/' . $oct_404_page_data['image'];
        		}
            } else {
                $data['oct_404_image'] = '';
            }
      

			
          if (!empty($oct_404_page_data['module_text'][(int)$this->config->get('config_language_id')]['text'])) {
              $data['text_error'] = html_entity_decode($oct_404_page_data['module_text'][(int)$this->config->get('config_language_id')]['text'], ENT_QUOTES, 'UTF-8');
          } else {
              $data['text_error'] = $this->language->get('text_error');
          }
        } else {
            $data['heading_title'] = $this->language->get('heading_title');
            $data['text_error'] = $this->language->get('text_error');
        }
      

			$data['button_continue'] = $this->language->get('button_continue');

			$data['continue'] = $this->url->link('common/home');

			$this->response->addHeader($this->request->server['SERVER_PROTOCOL'] . ' 404 Not Found');

			$data['column_left'] = $this->load->controller('common/column_left');
			$data['column_right'] = $this->load->controller('common/column_right');
			$data['content_top'] = $this->load->controller('common/content_top');
			$data['content_bottom'] = $this->load->controller('common/content_bottom');
			$data['footer'] = $this->load->controller('common/footer');
			$data['header'] = $this->load->controller('common/header');

			$this->response->setOutput($this->load->view('error/not_found', $data));
		}
	}

	public function agree() {
		$this->load->model('catalog/information');

		if (isset($this->request->get['information_id'])) {
			$information_id = (int)$this->request->get['information_id'];
		} else {
			$information_id = 0;
		}

		$output = '';

		$information_info = $this->model_catalog_information->getInformation($information_id);

		if ($information_info) {
			$output .= html_entity_decode($information_info['description'], ENT_QUOTES, 'UTF-8') . "\n";
		}

		$this->response->setOutput($output);
	}
}