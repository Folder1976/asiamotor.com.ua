<?php

require_once(DIR_SYSTEM . "/engine/neoseo_controller.php");

class ControllerExtensionModuleNeoSeoSeogen extends NeoSeoController
{

	private $error = array();

	public function __construct($registry)
	{
		parent::__construct($registry);
		$this->_moduleSysName = "neoseo_seogen";
		$this->_logFile = $this->_moduleSysName . ".log";
		$this->debug = $this->config->get($this->_moduleSysName . "_debug") == 1;
	}

	public function index()
	{
		$this->checkLicense();

		$data = $this->language->load('extension/module/' . $this->_moduleSysName);

		$this->document->setTitle($this->language->get('heading_title_raw'));

		/* emojipicker - begin */
		$this->document->addScript('view/javascript/jquery-emoji-picker-master/js/jquery.emojipicker.js');
		$this->document->addScript('view/javascript/jquery-emoji-picker-master/js/jquery.emojis.js');
		$this->document->addStyle('view/javascript/jquery-emoji-picker-master/css/jquery.emojipicker.css');
		$this->document->addStyle('view/javascript/jquery-emoji-picker-master/css/jquery.emojipicker.tw.css');
		/* emojipicker - end */

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

			$this->model_setting_setting->editSetting($this->_moduleSysName, $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			if (isset($this->request->get['close'])) {
				$this->response->redirect($this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL'));
			} else {
				$this->response->redirect($this->url->link('extension/module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL'));
			}
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}

		$data = $this->initBreadcrumbs(array(
			array("extension/extension", "text_module"),
			array("module/" . $this->_moduleSysName, "heading_title_raw")
		    ), $data);

		$data['action'] = $this->url->link('extension/module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
		$data['cancel'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL');
		$data['clear'] = $this->url->link('extension/module/' . $this->_moduleSysName . '/clear', 'token=' . $this->session->data['token'], 'SSL');
		$data['generate'] = $this->url->link('extension/module/' . $this->_moduleSysName . '/generate', 'token=' . $this->session->data['token'], 'SSL');
		$data['save'] = $this->url->link('extension/module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'], 'SSL');
		$data['save_and_close'] = $this->url->link('extension/module/' . $this->_moduleSysName, 'token=' . $this->session->data['token'] . "&close=1", 'SSL');
		$data['close'] = $this->url->link('extension/extension', 'token=' . $this->session->data['token'], 'SSL');
		$data['urlify_product_url'] = $this->url->link('extension/module/' . $this->_moduleSysName . "/urlify_product", 'token=' . $this->session->data['token'], 'SSL');
		$data['urlify_category_url'] = $this->url->link('extension/module/' . $this->_moduleSysName . "/urlify_category", 'token=' . $this->session->data['token'], 'SSL');
		$data['urlify_information_url'] = $this->url->link('extension/module/' . $this->_moduleSysName . "/urlify_information", 'token=' . $this->session->data['token'], 'SSL');
		$data['urlify_manufacturer_url'] = $this->url->link('extension/module/' . $this->_moduleSysName . "/urlify_manufacturer", 'token=' . $this->session->data['token'], 'SSL');
        $data['urlify_blog_url'] = $this->url->link('extension/module/' . $this->_moduleSysName . "/urlify_blog", 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		$languages = array();
		foreach ($this->model_localisation_language->getLanguages() as $language) {
			$languages[$language['language_id']] = $language['name'];
		}
		$data['select_languages'] = $languages;

		$languages = $this->model_localisation_language->getLanguages();

		$savedProducts = $this->config->get($this->_moduleSysName . '_products');
		if (!$savedProducts) {
			$savedProducts = array();
			$savedProducts["seo_url"] = $this->language->get("params_products_seo_url");
			$savedProducts["seo_url_rewrite"] = 0;
			foreach ($languages as $language) {
				$savedProducts[$language['language_id']] = array(
					"h1" => $this->language->get("params_products_h1"),
					"h1_rewrite" => 0,
					"title" => $this->language->get("params_products_title"),
					"title_rewrite" => 0,
					"keywords" => $this->language->get("params_products_keywords"),
					"keywords_rewrite" => 0,
					"description" => $this->language->get("params_products_description"),
					"description_rewrite" => 0,
				);
			}
		}

		$data[$this->_moduleSysName . '_products'] = array();
		$data[$this->_moduleSysName . '_products']["seo_url"] = $savedProducts["seo_url"];
		unset($savedProducts["seo_url"]);
		$data[$this->_moduleSysName . '_products']["seo_url_rewrite"] = $savedProducts["seo_url_rewrite"];
		unset($savedProducts["seo_url_rewrite"]);
		foreach ($savedProducts as $language_id => $products) {

			$data[$this->_moduleSysName . '_products'][$language_id]["h1"] = $products["h1"];
			$data[$this->_moduleSysName . '_products'][$language_id]["h1_rewrite"] = $products["h1_rewrite"];
			$data[$this->_moduleSysName . '_products'][$language_id]["title"] = $products["title"];
			$data[$this->_moduleSysName . '_products'][$language_id]["title_rewrite"] = $products["title_rewrite"];
			$data[$this->_moduleSysName . '_products'][$language_id]["keywords"] = $products["keywords"];
			$data[$this->_moduleSysName . '_products'][$language_id]["keywords_rewrite"] = $products["keywords_rewrite"];
			$data[$this->_moduleSysName . '_products'][$language_id]["description"] = $products["description"];
			$data[$this->_moduleSysName . '_products'][$language_id]["description_rewrite"] = $products["description_rewrite"];
		}

		$savedCategories = $this->config->get($this->_moduleSysName . '_categories');
		if (!$savedCategories) {
			$savedCategories["seo_url"] = $this->language->get("params_categories_seo_url");
			$savedCategories["seo_url_rewrite"] = 0;
			foreach ($languages as $language) {
				$savedCategories[$language['language_id']] = array(
					"h1" => $this->language->get("params_categories_h1"),
					"h1_rewrite" => 0,
					"title" => $this->language->get("params_categories_title"),
					"title_rewrite" => 0,
					"keywords" => $this->language->get("params_categories_keywords"),
					"keywords_rewrite" => 0,
					"description" => $this->language->get("params_categories_description"),
					"description_rewrite" => 0,
				);
			}
		}

		$data[$this->_moduleSysName . '_categories'] = array();
		$data[$this->_moduleSysName . '_categories']["seo_url"] = $savedCategories["seo_url"];
		unset($savedCategories["seo_url"]);
		$data[$this->_moduleSysName . '_categories']["seo_url_rewrite"] = $savedCategories["seo_url_rewrite"];
		unset($savedCategories["seo_url_rewrite"]);
		foreach ($savedCategories as $id => $categories) {
			$data[$this->_moduleSysName . '_categories'][$id]["h1"] = $categories["h1"];
			$data[$this->_moduleSysName . '_categories'][$id]["h1_rewrite"] = $categories["h1_rewrite"];
			$data[$this->_moduleSysName . '_categories'][$id]["title"] = $categories["title"];
			$data[$this->_moduleSysName . '_categories'][$id]["title_rewrite"] = $categories["title_rewrite"];
			$data[$this->_moduleSysName . '_categories'][$id]["keywords"] = $categories["keywords"];
			$data[$this->_moduleSysName . '_categories'][$id]["keywords_rewrite"] = $categories["keywords_rewrite"];
			$data[$this->_moduleSysName . '_categories'][$id]["description"] = $categories["description"];
			$data[$this->_moduleSysName . '_categories'][$id]["description_rewrite"] = $categories["description_rewrite"];
		}

		$savedManufacturers = $this->config->get($this->_moduleSysName . '_manufacturers');
		if (!$savedManufacturers) {
			$savedManufacturers["seo_url"] = $this->language->get("params_manufacturers_seo_url");
			$savedManufacturers["seo_url_rewrite"] = 0;
			foreach ($languages as $language) {
				$savedManufacturers[$language['language_id']] = array(
					"h1" => $this->language->get("params_manufacturers_h1"),
					"h1_rewrite" => 0,
					"title" => $this->language->get("params_manufacturers_title"),
					"title_rewrite" => 0,
					"keywords" => $this->language->get("params_manufacturers_keywords"),
					"keywords_rewrite" => 0,
					"description" => $this->language->get("params_manufacturers_description"),
					"description_rewrite" => 0,
				);
			}
		}
		$data[$this->_moduleSysName . '_manufacturers'] = array();
		$data[$this->_moduleSysName . '_manufacturers']["seo_url"] = $savedManufacturers["seo_url"];
		unset($savedManufacturers["seo_url"]);
		$data[$this->_moduleSysName . '_manufacturers']["seo_url_rewrite"] = $savedManufacturers["seo_url_rewrite"];
		unset($savedManufacturers["seo_url_rewrite"]);
		foreach ($savedManufacturers as $id => $manufacturers) {
			$data[$this->_moduleSysName . '_manufacturers'][$id]["h1"] = $manufacturers["h1"];
			$data[$this->_moduleSysName . '_manufacturers'][$id]["h1_rewrite"] = $manufacturers["h1_rewrite"];
			$data[$this->_moduleSysName . '_manufacturers'][$id]["title"] = $manufacturers["title"];
			$data[$this->_moduleSysName . '_manufacturers'][$id]["title_rewrite"] = $manufacturers["title_rewrite"];
			$data[$this->_moduleSysName . '_manufacturers'][$id]["keywords"] = $manufacturers["keywords"];
			$data[$this->_moduleSysName . '_manufacturers'][$id]["keywords_rewrite"] = $manufacturers["keywords_rewrite"];
			$data[$this->_moduleSysName . '_manufacturers'][$id]["description"] = $manufacturers["description"];
			$data[$this->_moduleSysName . '_manufacturers'][$id]["description_rewrite"] = $manufacturers["description_rewrite"];
		}


		$savedArticles = $this->config->get($this->_moduleSysName . '_articles');
		if (!$savedArticles) {
			$savedArticles["seo_url"] = $this->language->get("params_articles_seo_url");
			$savedArticles["seo_url_rewrite"] = 0;
			foreach ($languages as $language) {
				$savedArticles[$language['language_id']] = array(
					"h1" => $this->language->get("params_articles_h1"),
					"h1_rewrite" => 0,
					"title" => $this->language->get("params_articles_title"),
					"title_rewrite" => 0,
					"keywords" => $this->language->get("params_articles_keywords"),
					"keywords_rewrite" => 0,
					"description" => $this->language->get("params_articles_description"),
					"description_rewrite" => 0,
				);
			}
		}
		$data[$this->_moduleSysName . '_articles'] = array();
		$data[$this->_moduleSysName . '_articles']["seo_url"] = $savedArticles["seo_url"];
		unset($savedArticles["seo_url"]);
		$data[$this->_moduleSysName . '_articles']["seo_url_rewrite"] = $savedArticles["seo_url_rewrite"];
		unset($savedArticles["seo_url_rewrite"]);
		foreach ($savedArticles as $id => $articles) {
			$data[$this->_moduleSysName . '_articles'][$id]["h1"] = $articles["h1"];
			$data[$this->_moduleSysName . '_articles'][$id]["h1_rewrite"] = $articles["h1_rewrite"];
			$data[$this->_moduleSysName . '_articles'][$id]["title"] = $articles["title"];
			$data[$this->_moduleSysName . '_articles'][$id]["title_rewrite"] = $articles["title_rewrite"];
			$data[$this->_moduleSysName . '_articles'][$id]["keywords"] = $articles["keywords"];
			$data[$this->_moduleSysName . '_articles'][$id]["keywords_rewrite"] = $articles["keywords_rewrite"];
			$data[$this->_moduleSysName . '_articles'][$id]["description"] = $articles["description"];
			$data[$this->_moduleSysName . '_articles'][$id]["description_rewrite"] = $articles["description_rewrite"];
		}

		$savedBlogs = $this->config->get($this->_moduleSysName . '_blogs');
		if (!$savedBlogs) {
			$savedBlogs["seo_url"] = $this->language->get("params_blogs_seo_url");
			$savedBlogs["seo_url_rewrite"] = 0;
			foreach ($languages as $language) {
				$savedBlogs[$language['language_id']] = array(
					"h1" => $this->language->get("params_blogs_h1"),
					"h1_rewrite" => 0,
					"title" => $this->language->get("params_blogs_title"),
					"title_rewrite" => 0,
					"keywords" => $this->language->get("params_blogs_keywords"),
					"keywords_rewrite" => 0,
					"description" => $this->language->get("params_blogs_description"),
					"description_rewrite" => 0,
				);
			}
		}
		$data[$this->_moduleSysName . '_blogs'] = array();
		$data[$this->_moduleSysName . '_blogs']["seo_url"] = $savedBlogs["seo_url"];
		unset($savedBlogs["seo_url"]);
		$data[$this->_moduleSysName . '_blogs']["seo_url_rewrite"] = $savedBlogs["seo_url_rewrite"];
		unset($savedBlogs["seo_url_rewrite"]);
		foreach ($savedBlogs as $id => $blog) {
			$data[$this->_moduleSysName . '_blogs'][$id]["h1"] = $blog["h1"];
			$data[$this->_moduleSysName . '_blogs'][$id]["h1_rewrite"] = $blog["h1_rewrite"];
			$data[$this->_moduleSysName . '_blogs'][$id]["title"] = $blog["title"];
			$data[$this->_moduleSysName . '_blogs'][$id]["title_rewrite"] = $blog["title_rewrite"];
			$data[$this->_moduleSysName . '_blogs'][$id]["keywords"] = $blog["keywords"];
			$data[$this->_moduleSysName . '_blogs'][$id]["keywords_rewrite"] = $blog["keywords_rewrite"];
			$data[$this->_moduleSysName . '_blogs'][$id]["description"] = $blog["description"];
			$data[$this->_moduleSysName . '_blogs'][$id]["description_rewrite"] = $blog["description_rewrite"];
		}

		$data[$this->_moduleSysName . "_cron"] = "php " . realpath(DIR_SYSTEM . "../cron/" . $this->_moduleSysName . ".php");

		$this->load->model('extension/' . $this->_route . "/" . $this->_moduleSysName);
		$data = $this->initParamsListEx($this->{"model_extension_" . $this->_route . "_" . $this->_moduleSysName}->getParams(), $data);

		$data['params'] = $data;


		$data['token'] = $this->session->data['token'];

		$data["logs"] = $this->getLogs();

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');
		$this->response->setOutput($this->load->view('extension/module/' . $this->_moduleSysName . '.tpl', $data));
	}

	public function urlify_product()
	{
		if (!isset($this->request->get['id'])) {
			$ids = array();
			$sql = "SELECT product_id FROM `" . DB_PREFIX . "product`";
			$query = $this->db->query($sql);
			foreach ($query->rows as $row) {
				$ids[] = $row['product_id'];
			}
			echo json_encode($ids);
			return;
		}

		$product_id = (int) $this->request->get['id'];
		$this->load->model('tool/' . $this->_moduleSysName);
		$this->model_tool_neoseo_seogen->urlifyProduct($product_id);
		echo json_encode(array('status' => 'OK', 'product_id' => $product_id));
	}

	public function urlify_category()
	{
		if (!isset($this->request->get['id'])) {
			$ids = array();
			$sql = "SELECT category_id FROM `" . DB_PREFIX . "category`";
			$query = $this->db->query($sql);
			foreach ($query->rows as $row) {
				$ids[] = $row['category_id'];
			}
			echo json_encode($ids);
			return;
		}

		$category_id = (int) $this->request->get['id'];
		$this->load->model('tool/' . $this->_moduleSysName);
		$this->model_tool_neoseo_seogen->urlifyCategory($category_id);
		echo json_encode(array('status' => 'OK', 'category_id' => $category_id));
	}

	public function urlify_information()
	{
		if (!isset($this->request->get['id'])) {
			$ids = array();
			$sql = "SELECT information_id FROM `" . DB_PREFIX . "information`";
			$query = $this->db->query($sql);
			foreach ($query->rows as $row) {
				$ids[] = $row['information_id'];
			}
			echo json_encode($ids);
			return;
		}

		$information_id = (int) $this->request->get['id'];
		$this->load->model('tool/' . $this->_moduleSysName);
		$this->model_tool_neoseo_seogen->urlifyInformation($information_id);
		echo json_encode(array('status' => 'OK', 'information_id' => $information_id));
	}

	public function urlify_manufacturer()
	{
		if (!isset($this->request->get['id'])) {
			$ids = array();
			$sql = "SELECT manufacturer_id FROM `" . DB_PREFIX . "manufacturer`";
			$query = $this->db->query($sql);
			foreach ($query->rows as $row) {
				$ids[] = $row['manufacturer_id'];
			}
			echo json_encode($ids);
			return;
		}

		$manufacturer_id = (int) $this->request->get['id'];
		$this->load->model('tool/' . $this->_moduleSysName);
		$this->model_tool_neoseo_seogen->urlifyManufacturer($manufacturer_id);
		echo json_encode(array('status' => 'OK', 'manufacturer_id' => $manufacturer_id));
	}

	public function urlify_blog()
	{
		$this->load->model('tool/' . $this->_moduleSysName);

		if (!$this->model_tool_neoseo_seogen->checkBlogTableExits()) {
			echo json_encode(array('no_records' => 1));
			return;
		}

		if (!isset($this->request->get['id'])) {
			$ids = array();
			$sql = "SELECT article_id FROM `" . DB_PREFIX . "blog_article`";
			$query = $this->db->query($sql);
			foreach ($query->rows as $row) {
				$ids[] = $row['article_id'];
			}
			echo json_encode($ids);
			return;
		}

		$article_id = (int) $this->request->get['id'];
		$this->model_tool_neoseo_seogen->urlifyBlogArticle($article_id);

		echo json_encode(array('status' => 'OK', 'article_id' => $article_id));
	}

	private function validate()
	{
		if (!$this->user->hasPermission('modify', 'extension/module/' . $this->_moduleSysName)) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if (isset($this->request->post[$this->_moduleSysName . '_module'])) {
			foreach ($this->request->post[$this->_moduleSysName . '_module'] as $key => $value) {
				if (!$value['width'] || !$value['height']) {
					$this->error['image'][$key] = $this->language->get('error_image');
				}
			}
		}

		if (!$this->error) {
			return true;
		} else {
			return false;
		}
	}

}
