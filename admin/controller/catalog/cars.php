<?php
class ControllerCatalogCars extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/cars');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('catalog/cars');

		$this->getList();
	}

	
	public function delete() {
		$this->load->language('catalog/cars');
		$this->load->model('catalog/cars');

		
		if((int)$this->request->post['model_id'] == 0){
			$this->model_catalog_cars->deleteMark((int)$this->request->post['mark_id']);
		}else{
			$this->model_catalog_cars->deleteModel((int)$this->request->post['model_id']);
		}
		
		$json = array();
		
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
	}

	protected function getList() {
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('catalog/cars', 'token=' . $this->session->data['token'] , true)
		);

		//$data['add'] = $this->url->link('catalog/attribute/add', 'token=' . $this->session->data['token'] . $url, true);
		//$data['delete'] = $this->url->link('catalog/attribute/delete', 'token=' . $this->session->data['token'] . $url, true);

		$data['cars'] = array();

		$marks = $this->model_catalog_cars->getMarks();

		foreach ($marks as $result) {
			
			$model_for_array = array();
			$models = $this->model_catalog_cars->getModels($result['mark_id']);
			foreach($models as $row){
				$model_for_array[] = array(
						'model_id' => $row['model_id'],
						'mark_id' => $row['mark_id'],
						'model_name' => $row['model_name'],
						'dvigun' => '',
										   ); 
			}
			$data['cars'][] = array(
				'mark_id'    => $result['mark_id'],
				'mark_name'       => $result['mark_name'],
				'models' => $model_for_array,
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');

		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');

		$data['column_name'] = $this->language->get('column_name');
		$data['column_attribute_group'] = $this->language->get('column_attribute_group');
		$data['column_sort_order'] = $this->language->get('column_sort_order');
		$data['column_action'] = $this->language->get('column_action');

		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_delete'] = $this->language->get('button_delete');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$data['pagination'] = '';

		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/cars_list', $data));
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'catalog/cars')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		if (!$this->request->post['attribute_group_id']) {
			$this->error['attribute_group'] = $this->language->get('error_attribute_group');
		}

		foreach ($this->request->post['attribute_description'] as $language_id => $value) {
			if ((utf8_strlen($value['name']) < 3) || (utf8_strlen($value['name']) > 64)) {
				$this->error['name'][$language_id] = $this->language->get('error_name');
			}
		}

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'catalog/cars')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		$this->load->model('catalog/cars');

		foreach ($this->request->post['selected'] as $attribute_id) {
			//$product_total = $this->model_catalog_product->getTotalProductsByAttributeId($attribute_id);

			if ($product_total) {
				$this->error['warning'] = sprintf($this->language->get('error_product'), $product_total);
			}
		}

		return !$this->error;
	}

	public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('catalog/attribute');

			$filter_data = array(
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 5
			);

			$results = $this->model_catalog_attribute->getAttributes($filter_data);

			foreach ($results as $result) {
				$json[] = array(
					'attribute_id'    => $result['attribute_id'],
					'name'            => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
					'attribute_group' => $result['attribute_group']
				);
			}
		}

		$sort_order = array();

		foreach ($json as $key => $value) {
			$sort_order[$key] = $value['name'];
		}

		array_multisort($sort_order, SORT_ASC, $json);

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
}
