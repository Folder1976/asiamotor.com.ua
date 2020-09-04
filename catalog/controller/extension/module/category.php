<?php
class ControllerExtensionModuleCategory extends Controller {
	
	public function resetcar(){
		
		unset($this->session->data['mark_id']);
		unset($this->session->data['model_id']);
		unset($this->session->data['year_id']);
		unset($this->session->data['dvigun_id']);
		unset($this->session->data['filtercar']);
		
	}
	
	public function filtercar(){
		
		$this->session->data['filtercar'] = true;		
	}
	
	public function getmodels(){
		
		$data['mark_id'] = $this->session->data['mark_id'] = (int)$this->request->post['mark_id'];
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "car_model WHERE mark_id=".$data['mark_id']." ORDER BY model_name");
		$data['models'] = $query->rows;

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($data['models']));	
			
	}
	
	public function getyears(){
		$data['mark_id'] = $this->session->data['mark_id'] = (int)$this->request->post['mark_id'];
		$data['model_id'] = $this->session->data['model_id'] = (int)$this->request->post['model_id'];
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "car WHERE mark_id=".$data['mark_id']." AND model_id=".$data['model_id']." LIMIT 1");
		
		$json = explode(';', trim($query->row['goda'],';'));
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
	
	public function getdviguns(){
		$data['mark_id'] = $this->session->data['mark_id'] = (int)$this->request->post['mark_id'];
		$data['model_id'] = $this->session->data['model_id'] = (int)$this->request->post['model_id'];
		$data['year_id'] = $this->session->data['year_id'] = (int)$this->request->post['year_id'];
		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "car_dvigun WHERE dvigunkey IN
								  (SELECT dvigunkey FROM " . DB_PREFIX . "car WHERE mark_id=".$data['mark_id']." AND model_id=".$data['model_id']." AND goda LIKE '%".$data['year_id'].";%')
								  ");
		
		$data['dviguns'] = $query->rows;
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($data['dviguns']));
	}
	
	public function setdvigun(){
	
		$data['dvigun_id'] = $this->session->data['dvigun_id'] = $this->db->escape($this->request->post['dvigun_id']);
	
	}
	
	public function index() {
		$this->load->language('extension/module/category');

		$data['marks'] = array();

		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "car_mark ORDER BY mark_name");
		$data['marks'] = $query->rows;

		if(isset($this->session->data['mark_id']) AND (int)$this->session->data['mark_id'] > 0){
			$data['mark_id']= (int)$this->session->data['mark_id'];
			
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "car_model WHERE mark_id=".$data['mark_id']." ORDER BY model_name");
			$data['models'] = $query->rows;
		}
		if(isset($this->session->data['model_id']) AND (int)$this->session->data['model_id'] > 0 AND isset($data['mark_id'])){
			$data['model_id'] = (int)$this->session->data['model_id'];
			
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "car WHERE mark_id=".$data['mark_id']." AND model_id=".$data['model_id']." LIMIT 1");
			$data['years'] = explode(';', trim($query->row['goda'],';'));
		}
		
		if(isset($this->session->data['year_id']) AND (int)$this->session->data['year_id'] > 0  AND isset($data['mark_id'])){
			$data['year_id'] = (int)$this->session->data['year_id'];
			
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "car_dvigun WHERE dvigunkey IN
								  (SELECT dvigunkey FROM " . DB_PREFIX . "car WHERE mark_id=".$data['mark_id']." AND model_id=".$data['model_id']." AND goda LIKE '%".$data['year_id'].";%')
								  ");

			$data['dviguns'] = $query->rows;
		}
		
		if(isset($this->session->data['dvigun_id'])){
			$data['dvigun_id'] = $this->db->escape($this->session->data['dvigun_id']);
		}
		
		
		$data['heading_title'] = $this->language->get('heading_title');

		if (isset($this->request->get['path'])) {
			$parts = explode('_', (string)$this->request->get['path']);
		} else {
			$parts = array();
		}

		if (isset($parts[0])) {
			$data['category_id'] = $parts[0];
		} else {
			$data['category_id'] = 0;
		}

		if (isset($parts[1])) {
			$data['child_id'] = $parts[1];
		} else {
			$data['child_id'] = 0;
		}

		$this->load->model('catalog/category');

		$this->load->model('catalog/product');

		$data['categories'] = array();

		$categories = $this->model_catalog_category->getCategories(0);

		foreach ($categories as $category) {
			$children_data = array();

			if ($category['category_id'] == $data['category_id']) {
				$children = $this->model_catalog_category->getCategories($category['category_id']);

				foreach($children as $child) {
					$filter_data = array('filter_category_id' => $child['category_id'], 'filter_sub_category' => true);

					$children_data[] = array(
						'category_id' => $child['category_id'],
						'name' => $child['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
						'href' => $this->url->link('product/category', 'path=' . $category['category_id'] . '_' . $child['category_id'])
					);
				}
			}

			$filter_data = array(
				'filter_category_id'  => $category['category_id'],
				'filter_sub_category' => true
			);

			$data['categories'][] = array(
				'category_id' => $category['category_id'],
				'name'        => $category['name'] . ($this->config->get('config_product_count') ? ' (' . $this->model_catalog_product->getTotalProducts($filter_data) . ')' : ''),
				'children'    => $children_data,
				'href'        => $this->url->link('product/category', 'path=' . $category['category_id'])
			);
		}

		return $this->load->view('extension/module/category', $data);
	}
}