<?php
class ControllerCatalogCity extends Controller {
	private $error = array();

	public function index() {
		$this->load->language('catalog/city');

		$this->document->setTitle($this->language->get('Список городов'));

		$this->load->model('catalog/city');

		$this->getList();
	}

	public function add() {
		$this->load->language('catalog/city');

		$this->document->setTitle($this->language->get('Добавление города'));

		$this->load->model('catalog/city');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_city->addCity($this->request->post);

			$this->session->data['success'] = $this->language->get('Удачно');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/city', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function edit() {
		$this->load->language('catalog/city');

		$this->document->setTitle($this->language->get('Редактирование города'));

		$this->load->model('catalog/city');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_catalog_city->editCity($this->request->get['city_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('Удачно');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/city', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('catalog/city');

		$this->document->setTitle($this->language->get('Удаление города'));

		$this->load->model('catalog/city');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $city_id) {
				$this->model_catalog_city->deleteCity($city_id);
			}

			$this->session->data['success'] = $this->language->get('Удачно');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('catalog/city', 'token=' . $this->session->data['token'] . $url, true));
		}

		$this->getList();
	}

	protected function getList() {
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'ad.name';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'ASC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		if (isset($this->request->get['filter_name'])) {
			$data['filter_name'] = $filter_name = $this->request->get['filter_name'];
		} else {
			$data['filter_name'] = $filter_name = null;
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['token'] = $this->request->get['token'];
		
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('Список городов'),
			'href' => $this->url->link('catalog/city', 'token=' . $this->session->data['token'] . $url, true)
		);

		$data['add'] = $this->url->link('catalog/city/add', 'token=' . $this->session->data['token'] . $url, true);
		$data['delete'] = $this->url->link('catalog/city/delete', 'token=' . $this->session->data['token'] . $url, true);

		$data['citys'] = array();

		$filter_data = array(
			'sort'  => $sort,
			'filter_name'  => $filter_name,
			'order' => $order,
			'start' => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit' => $this->config->get('config_limit_admin')
		);

		$city_total = $this->model_catalog_city->getTotalCitys($filter_data);

		$results = $this->model_catalog_city->getCitys($filter_data);

		foreach ($results as $result) {
			$data['citys'][] = array(
				'city_id'    => $result['city_id'],
				'name'            => $result['name'],
				'alias' => $result['alias'],
				'sort_order'      => $result['sort_order'],
				'edit'            => $this->url->link('catalog/city/edit', 'token=' . $this->session->data['token'] . '&city_id=' . $result['city_id'] . $url, true)
			);
		}

		$data['heading_title'] = $this->language->get('Список городов');

		$data['text_list'] = $this->language->get('Справочник городов');
		$data['text_no_results'] = $this->language->get('Нет результата');
		$data['text_confirm'] = $this->language->get('Подтвердите');

		$data['column_name'] = $this->language->get('Название');
		$data['column_alias'] = $this->language->get('Алиас');
		$data['column_sort_order'] = $this->language->get('Сорт');
		$data['column_action'] = $this->language->get('Акция');

		$data['button_add'] = $this->language->get('Добавить');
		$data['button_edit'] = $this->language->get('Редактировать');
		$data['button_delete'] = $this->language->get('Удалить');

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

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_name'] = $this->url->link('catalog/city', 'token=' . $this->session->data['token'] . '&sort=ad.name' . $url, true);
		$data['sort_alias'] = $this->url->link('catalog/city', 'token=' . $this->session->data['token'] . '&sort=alias' . $url, true);
		$data['sort_sort_order'] = $this->url->link('catalog/city', 'token=' . $this->session->data['token'] . '&sort=a.sort_order' . $url, true);

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $city_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('catalog/city', 'token=' . $this->session->data['token'] . $url . '&page={page}', true);

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($city_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($city_total - $this->config->get('config_limit_admin'))) ? $city_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $city_total, ceil($city_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/city_list', $data));
	}

	public function translitArtkl($str) {
		$rus = array('и','і','є','Є','ї','\"','\'','.',' ','А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ё', 'Ж', 'З', 'И', 'Й', 'К', 'Л', 'М', 'Н', 'О', 'П', 'Р', 'С', 'Т', 'У', 'Ф', 'Х', 'Ц', 'Ч', 'Ш', 'Щ', 'Ъ', 'Ы', 'Ь', 'Э', 'Ю', 'Я', 'а', 'б', 'в', 'г', 'д', 'е', 'ё', 'ж', 'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф', 'х', 'ц', 'ч', 'ш', 'щ', 'ъ', 'ы', 'ь', 'э', 'ю', 'я');
		$lat = array('u','i','e','E','i','','','','-','A', 'B', 'V', 'G', 'D', 'E', 'E', 'Gh', 'Z', 'I', 'Y', 'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'F', 'H', 'C', 'Ch', 'Sh', 'Sch', 'Y', 'Y', 'Y', 'E', 'Yu', 'Ya', 'a', 'b', 'v', 'g', 'd', 'e', 'e', 'gh', 'z', 'i', 'y', 'k', 'l', 'm', 'n', 'o', 'p', 'r', 's', 't', 'u', 'f', 'h', 'c', 'ch', 'sh', 'sch', 'y', 'y', 'y', 'e', 'yu', 'ya');
	   return str_replace($rus, $lat, $str);
	}

	protected function getForm() {

		/*		
		$test = '<div class="box clear"> <div class="box-content"> <ul class="col5"> <li> <a href="/delivery-to-city/avdeevka/">Авдеевка</a><br> </li> <li> <a href="/delivery-to-city/amvrosievka/">Амвросиевка</a><br> </li> <li> <a href="/delivery-to-city/artemovsk/">Артемовск</a><br> </li> <li> <a href="/delivery-to-city/belitskoe/">Белицкое</a><br> </li> <li> <a href="/delivery-to-city/velikaya-novoselka/">Великая Новоселка</a><br> </li> <li> <a href="/delivery-to-city/volnovaha/">Волноваха</a><br> </li> <li> <a href="/delivery-to-city/volodarskoe/">Володарское</a><br> </li> <li> <a href="/delivery-to-city/gorlovka/">Горловка</a><br> </li> <li> <a href="/delivery-to-city/debalytsevo/">Дебальцево</a><br> </li> <li> <a href="/delivery-to-city/dzerzhinsk/">Дзержинск</a><br> </li> <li> <a href="/delivery-to-city/dimitrov/">Димитров</a><br> </li> <li> <a href="/delivery-to-city/dobropolye/">Доброполье</a><br> </li> <li> <a href="/delivery-to-city/dokuchaevsk/">Докучаевск</a><br> </li> <li> <a href="/delivery-to-city/donetsk/">Донецк</a><br> </li> <li> <a href="/delivery-to-city/druzhkovka/">Дружковка</a><br> </li> <li> <a href="/delivery-to-city/enakievo/">Енакиево</a><br> </li> <li> <a href="/delivery-to-city/zugres/">Зугрес</a><br> </li> <li> <a href="/delivery-to-city/ilovajsk/">Иловайск</a><br> </li> <li> <a href="/delivery-to-city/konstantinovka/">Константиновка</a><br> </li> <li> <a href="/delivery-to-city/kramatorsk/">Краматорск</a><br> </li> <li> <a href="/delivery-to-city/krasnoarmejsk/">Красноармейск</a><br> </li> <li> <a href="/delivery-to-city/krasnyj-liman/">Красный Лиман</a><br> </li> <li> <a href="/delivery-to-city/kurahove/">Курахове</a><br> </li> <li> <a href="/delivery-to-city/makeevka/">Макеевка</a><br> </li> <li> <a href="/delivery-to-city/mangush/">Мангуш</a><br> </li> <li> <a href="/delivery-to-city/mariupoly/">Мариуполь</a><br> </li> <li> <a href="/delivery-to-city/maryinka/">Марьинка</a><br> </li> <li> <a href="/delivery-to-city/mospino/">Моспино</a><br> </li> <li> <a href="/delivery-to-city/novoazovsk/">Новоазовск</a><br> </li> <li> <a href="/delivery-to-city/novyj-svet/">Новый Свет</a><br> </li> <li> <a href="/delivery-to-city/svetlodarsk/">Светлодарск</a><br> </li> <li> <a href="/delivery-to-city/svyatogorsk/">Святогорск</a><br> </li> <li> <a href="/delivery-to-city/selidovoe/">Селидовое</a><br> </li> <li> <a href="/delivery-to-city/slavyansk/">Славянск</a><br> </li> <li> <a href="/delivery-to-city/snezhnoe/">Снежное</a><br> </li> <li> <a href="/delivery-to-city/soledar/">Соледар</a><br> </li> <li> <a href="/delivery-to-city/starobeshevo/">Старобешево</a><br> </li> <li> <a href="/delivery-to-city/telymanovo/">Тельманово</a><br> </li> <li> <a href="/delivery-to-city/torez/">Торез</a><br> </li> <li> <a href="/delivery-to-city/ugledar/">Угледар</a><br> </li> <li> <a href="/delivery-to-city/hartsyzsk/">Харцызск</a><br> </li> <li> <a href="/delivery-to-city/shahtersk/">Шахтерск</a><br> </li> <li> <a href="/delivery-to-city/yasinovataya/">Ясиноватая</a><br> </li> <li> <a href="/delivery-to-city/akimovka/">Акимовка</a><br> </li> <li> <a href="/delivery-to-city/berdyansk/">Бердянск</a><br> </li> <li> <a href="/delivery-to-city/vasilyevka/">Васильевка</a><br> </li> <li> <a href="/delivery-to-city/veseloe/">Веселое</a><br> </li> <li> <a href="/delivery-to-city/volynyansk/">Вольнянск</a><br> </li> <li> <a href="/delivery-to-city/gulyajpole/">Гуляйполе</a><br> </li> <li> <a href="/delivery-to-city/dneprorudnoe/">Днепрорудное</a><br> </li> <li> <a href="/delivery-to-city/zaporozhye/">Запорожье</a><br> </li> <li> <a href="/delivery-to-city/kamenka-dneprovskaya/">Каменка-Днепровская</a><br> </li> <li> <a href="/delivery-to-city/kujbyshevo/">Куйбышево</a><br> </li> <li> <a href="/delivery-to-city/melitopoly/">Мелитополь</a><br> </li> <li> <a href="/delivery-to-city/mihajlovka/">Михайловка</a><br> </li> <li> <a href="/delivery-to-city/orehov/">Орехов</a><br> </li> <li> <a href="/delivery-to-city/pologi/">Пологи</a><br> </li> <li> <a href="/delivery-to-city/priazovskoe/">Приазовское</a><br> </li> <li> <a href="/delivery-to-city/primorsk/">Приморск</a><br> </li> <li> <a href="/delivery-to-city/tokmak/">Токмак</a><br> </li> <li> <a href="/delivery-to-city/energodar/">Энергодар</a><br> </li> <li> <a href="/delivery-to-city/aleksandriya/">Александрия</a><br> </li> <li> <a href="/delivery-to-city/aleksandrovka/">Александровка</a><br> </li> <li> <a href="/delivery-to-city/bobrinets/">Бобринец</a><br> </li> <li> <a href="/delivery-to-city/gajvoron/">Гайворон</a><br> </li> <li> <a href="/delivery-to-city/golovanevsk/">Голованевск</a><br> </li> <li> <a href="/delivery-to-city/dobrovelichkovka/">Добровеличковка</a><br> </li> <li> <a href="/delivery-to-city/dolinskaya/">Долинская</a><br> </li> <li> <a href="/delivery-to-city/znamenka/">Знаменка</a><br> </li> <li> <a href="/delivery-to-city/kirovograd/">Кировоград</a><br> </li> <li> <a href="/delivery-to-city/kompaneevka/">Компанеевка</a><br> </li> <li> <a href="/delivery-to-city/malaya-viska/">Малая Виска</a><br> </li> <li> <a href="/delivery-to-city/novgorodka/">Новгородка</a><br> </li> <li> <a href="/delivery-to-city/novoarhangelysk/">Новоархангельск</a><br> </li> <li> <a href="/delivery-to-city/novomirgorod/">Новомиргород</a><br> </li> <li> <a href="/delivery-to-city/novoukrainka/">Новоукраинка</a><br> </li> <li> <a href="/delivery-to-city/olyshanka/">Ольшанка</a><br> </li> <li> <a href="/delivery-to-city/onufrievka/">Онуфриевка</a><br> </li> <li> <a href="/delivery-to-city/petrovo/">Петрово</a><br> </li> <li> <a href="/delivery-to-city/pobugskoe/">Побугское</a><br> </li> <li> <a href="/delivery-to-city/pomichna/">Помична</a><br> </li> <li> <a href="/delivery-to-city/svetlovodsk/">Светловодск</a><br> </li> <li> <a href="/delivery-to-city/smolino/">Смолино</a><br> </li> <li> <a href="/delivery-to-city/ulyyanovka/">Ульяновка</a><br> </li> <li> <a href="/delivery-to-city/alupka/">Алупка</a><br> </li> <li> <a href="/delivery-to-city/alushta/">Алушта</a><br> </li> <li> <a href="/delivery-to-city/armyansk/">Армянск</a><br> </li> <li> <a href="/delivery-to-city/bahchisaraj/">Бахчисарай</a><br> </li> <li> <a href="/delivery-to-city/belogorsk/">Белогорск</a><br> </li> <li> <a href="/delivery-to-city/gurzuf/">Гурзуф</a><br> </li> <li> <a href="/delivery-to-city/dzhankoj/">Джанкой</a><br> </li> <li> <a href="/delivery-to-city/evpatoriya/">Евпатория</a><br> </li> <li> <a href="/delivery-to-city/zolotoe-pole/">Золотое поле</a><br> </li> <li> <a href="/delivery-to-city/kerchy/">Керчь</a><br> </li> <li> <a href="/delivery-to-city/kirovskoe/">Кировское</a><br> </li> <li> <a href="/delivery-to-city/krasnogvardejskoe/">Красногвардейское</a><br> </li> <li> <a href="/delivery-to-city/krasnoperekopsk/">Красноперекопск</a><br> </li> <li> <a href="/delivery-to-city/lenino/">Ленино</a><br> </li> <li> <a href="/delivery-to-city/nizhnegorskij/">Нижнегорский</a><br> </li> <li> <a href="/delivery-to-city/oktyabrsykoe/">Октябрськое</a><br> </li> <li> <a href="/delivery-to-city/pervomajskoe/">Первомайское</a><br> </li> <li> <a href="/delivery-to-city/razdolynoe/">Раздольное</a><br> </li> <li> <a href="/delivery-to-city/saki/">Саки</a><br> </li> <li> <a href="/delivery-to-city/sevastopoly/">Севастополь</a><br> </li> <li> <a href="/delivery-to-city/simferopoly/">Симферополь</a><br> </li> <li> <a href="/delivery-to-city/sovetskij/">Советский</a><br> </li> <li> <a href="/delivery-to-city/staryj-krym/">Старый Крым</a><br> </li> <li> <a href="/delivery-to-city/sudak/">Судак</a><br> </li> <li> <a href="/delivery-to-city/feodosiya/">Феодосия</a><br> </li> <li> <a href="/delivery-to-city/chernomorskoe/">Черноморское</a><br> </li> <li> <a href="/delivery-to-city/schelkino/">Щёлкино</a><br> </li> <li> <a href="/delivery-to-city/yalta/">Ялта</a><br> </li> <li> <a href="/delivery-to-city/alchevsk/">Алчевск</a><br> </li> <li> <a href="/delivery-to-city/antratsit/">Антрацит</a><br> </li> <li> <a href="/delivery-to-city/belovodsk/">Беловодск</a><br> </li> <li> <a href="/delivery-to-city/bryanka/">Брянка</a><br> </li> <li> <a href="/delivery-to-city/gorskoe/">Горское</a><br> </li> <li> <a href="/delivery-to-city/kirovsk/">Кировск</a><br> </li> <li> <a href="/delivery-to-city/krasnodon/">Краснодон</a><br> </li> <li> <a href="/delivery-to-city/krasnyj-luch/">Красный Луч</a><br> </li> <li> <a href="/delivery-to-city/kremennaya/">Кременная</a><br> </li> <li> <a href="/delivery-to-city/lisichansk/">Лисичанск</a><br> </li> <li> <a href="/delivery-to-city/lugansk/">Луганск</a><br> </li> <li> <a href="/delivery-to-city/lutugino/">Лутугино</a><br> </li> <li> <a href="/delivery-to-city/markovka/">Марковка</a><br> </li> <li> <a href="/delivery-to-city/melovoe/">Меловое</a><br> </li> <li> <a href="/delivery-to-city/novoajdar/">Новоайдар</a><br> </li> <li> <a href="/delivery-to-city/novopskov/">Новопсков</a><br> </li> <li> <a href="/delivery-to-city/perevalysk/">Перевальск</a><br> </li> <li> <a href="/delivery-to-city/popasnaya/">Попасная</a><br> </li> <li> <a href="/delivery-to-city/rovenyki/">Ровеньки</a><br> </li> <li> <a href="/delivery-to-city/rubezhnoe/">Рубежное</a><br> </li> <li> <a href="/delivery-to-city/svatovo/">Сватово</a><br> </li> <li> <a href="/delivery-to-city/sverdlovsk/">Свердловск</a><br> </li> <li> <a href="/delivery-to-city/severodonetsk/">Северодонецк</a><br> </li> <li> <a href="/delivery-to-city/slavyanoserbsk/">Славяносербск</a><br> </li> <li> <a href="/delivery-to-city/stanitsa-luganskaya/">Станица Луганская</a><br> </li> <li> <a href="/delivery-to-city/starobelysk/">Старобельск</a><br> </li> <li> <a href="/delivery-to-city/stahanov/">Стаханов</a><br> </li> <li> <a href="/delivery-to-city/suhodolysk/">Суходольск</a><br> </li> <li> <a href="/delivery-to-city/schastye/">Счастье</a><br> </li> <li> <a href="/delivery-to-city/chervonopartizansk/">Червонопартизанск</a><br> </li> <li> <a href="/delivery-to-city/ananyev/">Ананьев</a><br> </li> <li> <a href="/delivery-to-city/artsiz/">Арциз</a><br> </li> <li> <a href="/delivery-to-city/balta/">Балта</a><br> </li> <li> <a href="/delivery-to-city/belgorod-dnestrovskij/">Белгород-Днестровский</a><br> </li> <li> <a href="/delivery-to-city/belyaevka/">Беляевка</a><br> </li> <li> <a href="/delivery-to-city/bolgrad/">Болград</a><br> </li> <li> <a href="/delivery-to-city/velikaya-mihajlovka/">Великая Михайловка</a><br> </li> <li> <a href="/delivery-to-city/izmail/">Измаил</a><br> </li> <li> <a href="/delivery-to-city/ilyichevsk/">Ильичевск</a><br> </li> <li> <a href="/delivery-to-city/kiliya/">Килия</a><br> </li> <li> <a href="/delivery-to-city/kodyma/">Кодыма</a><br> </li> <li> <a href="/delivery-to-city/kominternovskoe/">Коминтерновское</a><br> </li> <li> <a href="/delivery-to-city/kotovsk/">Котовск</a><br> </li> <li> <a href="/delivery-to-city/lyubashevka/">Любашевка</a><br> </li> <li> <a href="/delivery-to-city/ovidiopoly/">Овидиополь</a><br> </li> <li> <a href="/delivery-to-city/odessa/">Одесса</a><br> </li> <li> <a href="/delivery-to-city/razdelynaya/">Раздельная</a><br> </li> <li> <a href="/delivery-to-city/reni/">Рени</a><br> </li> <li> <a href="/delivery-to-city/savrany/">Саврань</a><br> </li> <li> <a href="/delivery-to-city/sarata/">Сарата</a><br> </li> <li> <a href="/delivery-to-city/tatarbunary/">Татарбунары</a><br> </li> <li> <a href="/delivery-to-city/teplodar/">Теплодар</a><br> </li> <li> <a href="/delivery-to-city/frunzovka/">Фрунзовка</a><br> </li> <li> <a href="/delivery-to-city/shiryaevo/">Ширяево</a><br> </li> <li> <a href="/delivery-to-city/yuzhnoe/">Южное</a><br> </li> <li> <a href="/delivery-to-city/andrushevka/">Андрушевка</a><br> </li> <li> <a href="/delivery-to-city/baranovka/">Барановка</a><br> </li> <li> <a href="/delivery-to-city/berdichev/">Бердичев</a><br> </li> <li> <a href="/delivery-to-city/brusilov/">Брусилов</a><br> </li> <li> <a href="/delivery-to-city/volodarsk-volynskij/">Володарск-Волынский</a><br> </li> <li> <a href="/delivery-to-city/emilychino/">Емильчино</a><br> </li> <li> <a href="/delivery-to-city/zhitomir/">Житомир</a><br> </li> <li> <a href="/delivery-to-city/irshansk/">Иршанск</a><br> </li> <li> <a href="/delivery-to-city/korosteny/">Коростень</a><br> </li> <li> <a href="/delivery-to-city/korostyshev/">Коростышев</a><br> </li> <li> <a href="/delivery-to-city/luginy/">Лугины</a><br> </li> <li> <a href="/delivery-to-city/lyubar/">Любар</a><br> </li> <li> <a href="/delivery-to-city/malin/">Малин</a><br> </li> <li> <a href="/delivery-to-city/narodichi/">Народичи</a><br> </li> <li> <a href="/delivery-to-city/novograd-volynskij/">Новоград-Волынский</a><br> </li> <li> <a href="/delivery-to-city/ovruch/">Овруч</a><br> </li> <li> <a href="/delivery-to-city/olevsk/">Олевск</a><br> </li> <li> <a href="/delivery-to-city/popelynya/">Попельня</a><br> </li> <li> <a href="/delivery-to-city/radomyshly/">Радомышль</a><br> </li> <li> <a href="/delivery-to-city/romanov/">Романов</a><br> </li> <li> <a href="/delivery-to-city/ruzhin/">Ружин</a><br> </li> <li> <a href="/delivery-to-city/chernyahov/">Черняхов</a><br> </li> <li> <a href="/delivery-to-city/chudnov/">Чуднов</a><br> </li> <li> <a href="/delivery-to-city/apostolovo/">Апостолово</a><br> </li> <li> <a href="/delivery-to-city/vasilykovka/">Васильковка</a><br> </li> <li> <a href="/delivery-to-city/verhnedneprovsk/">Верхнеднепровск</a><br> </li> <li> <a href="/delivery-to-city/verhovtsevo/">Верховцево</a><br> </li> <li> <a href="/delivery-to-city/volynogorsk/">Вольногорск</a><br> </li> <li> <a href="/delivery-to-city/dneprovskoe/">Днепровское</a><br> </li> <li> <a href="/delivery-to-city/dneprodzerzhinsk/">Днепродзержинск</a><br> </li> <li> <a href="/delivery-to-city/dnepropetrovsk/">Днепропетровск</a><br> </li> <li> <a href="/delivery-to-city/zheltye-vody/">Желтые Воды</a><br> </li> <li> <a href="/delivery-to-city/zelenodolysyk/">Зеленодольськ</a><br> </li> <li> <a href="/delivery-to-city/krivoj-rog/">Кривой Рог</a><br> </li> <li> <a href="/delivery-to-city/krinichki/">Кринички</a><br> </li> <li> <a href="/delivery-to-city/magdalinovka/">Магдалиновка</a><br> </li> <li> <a href="/delivery-to-city/marganets/">Марганец</a><br> </li> <li> <a href="/delivery-to-city/nikopoly/">Никополь</a><br> </li> <li> <a href="/delivery-to-city/novomoskovsk/">Новомосковск</a><br> </li> <li> <a href="/delivery-to-city/ordzhonikidze/">Орджоникидзе</a><br> </li> <li> <a href="/delivery-to-city/pavlograd/">Павлоград</a><br> </li> <li> <a href="/delivery-to-city/pereschepine/">Перещепине</a><br> </li> <li> <a href="/delivery-to-city/petrikovka/">Петриковка</a><br> </li> <li> <a href="/delivery-to-city/petropavlovka/">Петропавловка</a><br> </li> <li> <a href="/delivery-to-city/pokrovskoe/">Покровское</a><br> </li> <li> <a href="/delivery-to-city/pyatihatki/">Пятихатки</a><br> </li> <li> <a href="/delivery-to-city/sinelynikovo/">Синельниково</a><br> </li> <li> <a href="/delivery-to-city/solenoe/">Соленое</a><br> </li> <li> <a href="/delivery-to-city/sofievka/">Софиевка</a><br> </li> <li> <a href="/delivery-to-city/ternovka/">Терновка</a><br> </li> <li> <a href="/delivery-to-city/tomakovka/">Томаковка</a><br> </li> <li> <a href="/delivery-to-city/tsarichanka/">Царичанка</a><br> </li> <li> <a href="/delivery-to-city/shirokoe/">Широкое</a><br> </li> <li> <a href="/delivery-to-city/schorsk/">Щорск</a><br> </li> <li> <a href="/delivery-to-city/ahtyrka/">Ахтырка</a><br> </li> <li> <a href="/delivery-to-city/belopolye/">Белополье</a><br> </li> <li> <a href="/delivery-to-city/buryny/">Бурынь</a><br> </li> <li> <a href="/delivery-to-city/velikaya-pisarevka/">Великая Писаревка</a><br> </li> <li> <a href="/delivery-to-city/gluhov/">Глухов</a><br> </li> <li> <a href="/delivery-to-city/druzhba/">Дружба</a><br> </li> <li> <a href="/delivery-to-city/konotop/">Конотоп</a><br> </li> <li> <a href="/delivery-to-city/krasnopolye/">Краснополье</a><br> </li> <li> <a href="/delivery-to-city/krolevets/">Кролевец</a><br> </li> <li> <a href="/delivery-to-city/lebedin/">Лебедин</a><br> </li> <li> <a href="/delivery-to-city/lipovaya-dolina/">Липовая Долина</a><br> </li> <li> <a href="/delivery-to-city/nedrigajlov/">Недригайлов</a><br> </li> <li> <a href="/delivery-to-city/putivly/">Путивль</a><br> </li> <li> <a href="/delivery-to-city/romny/">Ромны</a><br> </li> <li> <a href="/delivery-to-city/svesa/">Свеса</a><br> </li> <li> <a href="/delivery-to-city/seredina-buda/">Середина-Буда</a><br> </li> <li> <a href="/delivery-to-city/sumy/">Сумы</a><br> </li> <li> <a href="/delivery-to-city/trostyanets/">Тростянец</a><br> </li> <li> <a href="/delivery-to-city/shostka/">Шостка</a><br> </li> <li> <a href="/delivery-to-city/balakleya/">Балаклея</a><br> </li> <li> <a href="/delivery-to-city/barvenkovo/">Барвенково</a><br> </li> <li> <a href="/delivery-to-city/bezlyudovka/">Безлюдовка</a><br> </li> <li> <a href="/delivery-to-city/bliznetsy/">Близнецы</a><br> </li> <li> <a href="/delivery-to-city/bogoduhov/">Богодухов</a><br> </li> <li> <a href="/delivery-to-city/valki/">Валки</a><br> </li> <li> <a href="/delivery-to-city/velikij-burluk/">Великий Бурлук</a><br> </li> <li> <a href="/delivery-to-city/volchansk/">Волчанск</a><br> </li> <li> <a href="/delivery-to-city/dvurechnaya/">Двуречная</a><br> </li> <li> <a href="/delivery-to-city/zachepilovka/">Зачепиловка</a><br> </li> <li> <a href="/delivery-to-city/zmiev/">Змиев</a><br> </li> <li> <a href="/delivery-to-city/izyum/">Изюм</a><br> </li> <li> <a href="/delivery-to-city/kovsharovka/">Ковшаровка</a><br> </li> <li> <a href="/delivery-to-city/krasnokutsk/">Краснокутск</a><br> </li> <li> <a href="/delivery-to-city/kupyansk/">Купянск</a><br> </li> <li> <a href="/delivery-to-city/lozovaya/">Лозовая</a><br> </li> <li> <a href="/delivery-to-city/lyubotin/">Люботин</a><br> </li> <li> <a href="/delivery-to-city/merefa/">Мерефа</a><br> </li> <li> <a href="/delivery-to-city/novaya-vodolaga/">Новая Водолага</a><br> </li> <li> <a href="/delivery-to-city/pervomajskij/">Первомайский</a><br> </li> <li> <a href="/delivery-to-city/harykov/">Харьков</a><br> </li> <li> <a href="/delivery-to-city/chuguev/">Чугуев</a><br> </li> <li> <a href="/delivery-to-city/shevchenkovo/">Шевченково</a><br> </li> <li> <a href="/delivery-to-city/bar/">Бар</a><br> </li> <li> <a href="/delivery-to-city/bershady/">Бершадь</a><br> </li> <li> <a href="/delivery-to-city/vinnitsa/">Винница</a><br> </li> <li> <a href="/delivery-to-city/gajsin/">Гайсин</a><br> </li> <li> <a href="/delivery-to-city/gnivany/">Гнивань</a><br> </li> <li> <a href="/delivery-to-city/zhmerinka/">Жмеринка</a><br> </li> <li> <a href="/delivery-to-city/ilyintsy/">Ильинцы</a><br> </li> <li> <a href="/delivery-to-city/kazatin/">Казатин</a><br> </li> <li> <a href="/delivery-to-city/kryzhopoly/">Крыжополь</a><br> </li> <li> <a href="/delivery-to-city/ladyzhin/">Ладыжин</a><br> </li> <li> <a href="/delivery-to-city/lipovets/">Липовец</a><br> </li> <li> <a href="/delivery-to-city/litin/">Литин</a><br> </li> <li> <a href="/delivery-to-city/mogilev---podolyskij/">Могилев - Подольский</a><br> </li> <li> <a href="/delivery-to-city/murovanye-kurilovtsy/">Мурованые Куриловцы</a><br> </li> <li> <a href="/delivery-to-city/nemirov/">Немиров</a><br> </li> <li> <a href="/delivery-to-city/oratov/">Оратов</a><br> </li> <li> <a href="/delivery-to-city/peschanka/">Песчанка</a><br> </li> <li> <a href="/delivery-to-city/pogrebische/">Погребище</a><br> </li> <li> <a href="/delivery-to-city/teplik/">Теплик</a><br> </li> <li> <a href="/delivery-to-city/tomashpoly/">Томашполь</a><br> </li> <li> <a href="/delivery-to-city/tulychin/">Тульчин</a><br> </li> <li> <a href="/delivery-to-city/chechelynik/">Чечельник</a><br> </li> <li> <a href="/delivery-to-city/shargorod/">Шаргород</a><br> </li> <li> <a href="/delivery-to-city/shpikov/">Шпиков</a><br> </li> <li> <a href="/delivery-to-city/baryshevka/">Барышевка</a><br> </li> <li> <a href="/delivery-to-city/belaya-tserkovy/">Белая Церковь</a><br> </li> <li> <a href="/delivery-to-city/belogorodka/">Белогородка</a><br> </li> <li> <a href="/delivery-to-city/berezany/">Березань</a><br> </li> <li> <a href="/delivery-to-city/boguslav/">Богуслав</a><br> </li> <li> <a href="/delivery-to-city/borispoly/">Борисполь</a><br> </li> <li> <a href="/delivery-to-city/borovaya/">Боровая</a><br> </li> <li> <a href="/delivery-to-city/borodyanka/">Бородянка</a><br> </li> <li> <a href="/delivery-to-city/boyarka/">Боярка</a><br> </li> <li> <a href="/delivery-to-city/brovary/">Бровары</a><br> </li> <li> <a href="/delivery-to-city/bucha/">Буча</a><br> </li> <li> <a href="/delivery-to-city/vasilykov/">Васильков</a><br> </li> <li> <a href="/delivery-to-city/vishnevoe/">Вишневое</a><br> </li> <li> <a href="/delivery-to-city/volodarka/">Володарка</a><br> </li> <li> <a href="/delivery-to-city/vyshgorod/">Вышгород</a><br> </li> <li> <a href="/delivery-to-city/grebinki/">Гребінки</a><br> </li> <li> <a href="/delivery-to-city/dymer/">Дымер</a><br> </li> <li> <a href="/delivery-to-city/zgurovka/">Згуровка</a><br> </li> <li> <a href="/delivery-to-city/ivankov/">Иванков</a><br> </li> <li> <a href="/delivery-to-city/irpeny/">Ирпень</a><br> </li> <li> <a href="/delivery-to-city/kagarlyk/">Кагарлык</a><br> </li> <li> <a href="/delivery-to-city/kiev/">Киев</a><br> </li> <li> <a href="/delivery-to-city/klavdievo-tarasovo/">Клавдиево-Тарасово</a><br> </li> <li> <a href="/delivery-to-city/kotsyubinskoe/">Коцюбинское</a><br> </li> <li> <a href="/delivery-to-city/makarov/">Макаров</a><br> </li> <li> <a href="/delivery-to-city/mironovka/">Мироновка</a><br> </li> <li> <a href="/delivery-to-city/nemeshaevo/">Немешаево</a><br> </li> <li> <a href="/delivery-to-city/novye-petrovtsy/">Новые Петровцы</a><br> </li> <li> <a href="/delivery-to-city/obuhov/">Обухов</a><br> </li> <li> <a href="/delivery-to-city/pereyaslav-hmelynitskij/">Переяслав-Хмельницкий</a><br> </li> <li> <a href="/delivery-to-city/rzhischev/">Ржищев</a><br> </li> <li> <a href="/delivery-to-city/skvira/">Сквира</a><br> </li> <li> <a href="/delivery-to-city/stavische/">Ставище</a><br> </li> <li> <a href="/delivery-to-city/stoyanka/">Стоянка</a><br> </li> <li> <a href="/delivery-to-city/tarascha/">Тараща</a><br> </li> <li> <a href="/delivery-to-city/tetiev/">Тетиев</a><br> </li> <li> <a href="/delivery-to-city/uzin/">Узин</a><br> </li> <li> <a href="/delivery-to-city/ukrajinka/">Українка</a><br> </li> <li> <a href="/delivery-to-city/fastov/">Фастов</a><br> </li> <li> <a href="/delivery-to-city/yagotin/">Яготин</a><br> </li> <li> <a href="/delivery-to-city/bahmach/">Бахмач</a><br> </li> <li> <a href="/delivery-to-city/bobrovitsa/">Бобровица</a><br> </li> <li> <a href="/delivery-to-city/borzna/">Борзна</a><br> </li> <li> <a href="/delivery-to-city/varva/">Варва</a><br> </li> <li> <a href="/delivery-to-city/gorodnya/">Городня</a><br> </li> <li> <a href="/delivery-to-city/ichnya/">Ичня</a><br> </li> <li> <a href="/delivery-to-city/kozelets/">Козелец</a><br> </li> <li> <a href="/delivery-to-city/korop/">Короп</a><br> </li> <li> <a href="/delivery-to-city/koryukovka/">Корюковка</a><br> </li> <li> <a href="/delivery-to-city/kulikovka/">Куликовка</a><br> </li> <li> <a href="/delivery-to-city/mena/">Мена</a><br> </li> <li> <a href="/delivery-to-city/nezhin/">Нежин</a><br> </li> <li> <a href="/delivery-to-city/novgorod-severskij/">Новгород-Северский</a><br> </li> <li> <a href="/delivery-to-city/nosovka/">Носовка</a><br> </li> <li> <a href="/delivery-to-city/priluki/">Прилуки</a><br> </li> <li> <a href="/delivery-to-city/repki/">Репки</a><br> </li> <li> <a href="/delivery-to-city/serebryanoe/">Серебряное</a><br> </li> <li> <a href="/delivery-to-city/slavutich/">Славутич</a><br> </li> <li> <a href="/delivery-to-city/sosnitsa/">Сосница</a><br> </li> <li> <a href="/delivery-to-city/talalaevka/">Талалаевка</a><br> </li> <li> <a href="/delivery-to-city/chernigov/">Чернигов</a><br> </li> <li> <a href="/delivery-to-city/schors/">Щорс</a><br> </li> <li> <a href="/delivery-to-city/bashtanka/">Баштанка</a><br> </li> <li> <a href="/delivery-to-city/berezanka/">Березанка</a><br> </li> <li> <a href="/delivery-to-city/bereznegovatoe/">Березнеговатое</a><br> </li> <li> <a href="/delivery-to-city/bratskoe/">Братское</a><br> </li> <li> <a href="/delivery-to-city/veselinovo/">Веселиново</a><br> </li> <li> <a href="/delivery-to-city/voznesensk/">Вознесенск</a><br> </li> <li> <a href="/delivery-to-city/vradievka/">Врадиевка</a><br> </li> <li> <a href="/delivery-to-city/domanevka/">Доманевка</a><br> </li> <li> <a href="/delivery-to-city/elanets/">Еланец</a><br> </li> <li> <a href="/delivery-to-city/kazanka/">Казанка</a><br> </li> <li> <a href="/delivery-to-city/krivoe-ozero/">Кривое Озеро</a><br> </li> <li> <a href="/delivery-to-city/nikolaev/">Николаев</a><br> </li> <li> <a href="/delivery-to-city/novaya-odessa/">Новая Одесса</a><br> </li> <li> <a href="/delivery-to-city/novyj-bug/">Новый Буг</a><br> </li> <li> <a href="/delivery-to-city/ochakov/">Очаков</a><br> </li> <li> <a href="/delivery-to-city/snigirevka/">Снигиревка</a><br> </li> <li> <a href="/delivery-to-city/yuzhnoukrainsk/">Южноукраинск</a><br> </li> <li> <a href="/delivery-to-city/beliki/">Белики</a><br> </li> <li> <a href="/delivery-to-city/velikaya-bagachka/">Великая Багачка</a><br> </li> <li> <a href="/delivery-to-city/gadyach/">Гадяч</a><br> </li> <li> <a href="/delivery-to-city/globino/">Глобино</a><br> </li> <li> <a href="/delivery-to-city/gradizhsk/">Градижск</a><br> </li> <li> <a href="/delivery-to-city/grebenka/">Гребенка</a><br> </li> <li> <a href="/delivery-to-city/dikanyka/">Диканька</a><br> </li> <li> <a href="/delivery-to-city/zenykov/">Зеньков</a><br> </li> <li> <a href="/delivery-to-city/karlovka/">Карловка</a><br> </li> <li> <a href="/delivery-to-city/kobelyaki/">Кобеляки</a><br> </li> <li> <a href="/delivery-to-city/kozelyschina/">Козельщина</a><br> </li> <li> <a href="/delivery-to-city/komsomolysk/">Комсомольск</a><br> </li> <li> <a href="/delivery-to-city/kotelyva/">Котельва</a><br> </li> <li> <a href="/delivery-to-city/kremenchug/">Кременчуг</a><br> </li> <li> <a href="/delivery-to-city/lohvitsa/">Лохвица</a><br> </li> <li> <a href="/delivery-to-city/lubny/">Лубны</a><br> </li> <li> <a href="/delivery-to-city/mashevka/">Машевка</a><br> </li> <li> <a href="/delivery-to-city/mirgorod/">Миргород</a><br> </li> <li> <a href="/delivery-to-city/novye-sanzhary/">Новые Санжары</a><br> </li> <li> <a href="/delivery-to-city/oposhnya/">Опошня</a><br> </li> <li> <a href="/delivery-to-city/orzhitsa/">Оржица</a><br> </li> <li> <a href="/delivery-to-city/piryatin/">Пирятин</a><br> </li> <li> <a href="/delivery-to-city/poltava/">Полтава</a><br> </li> <li> <a href="/delivery-to-city/reshetilovka/">Решетиловка</a><br> </li> <li> <a href="/delivery-to-city/horol/">Хорол</a><br> </li> <li> <a href="/delivery-to-city/chervonozavodskoe/">Червонозаводское</a><br> </li> <li> <a href="/delivery-to-city/chernuhi/">Чернухи</a><br> </li> <li> <a href="/delivery-to-city/chutovo/">Чутово</a><br> </li> <li> <a href="/delivery-to-city/shishaki/">Шишаки</a><br> </li> <li> <a href="/delivery-to-city/belogorye/">Белогорье</a><br> </li> <li> <a href="/delivery-to-city/vinykovtsy/">Виньковцы</a><br> </li> <li> <a href="/delivery-to-city/volochisk/">Волочиск</a><br> </li> <li> <a href="/delivery-to-city/derazhnya/">Деражня</a><br> </li> <li> <a href="/delivery-to-city/dunaevtsy/">Дунаевцы</a><br> </li> <li> <a href="/delivery-to-city/izyaslav/">Изяслав</a><br> </li> <li> <a href="/delivery-to-city/kamenets-podolyskij/">Каменец-Подольский</a><br> </li> <li> <a href="/delivery-to-city/krasilov/">Красилов</a><br> </li> <li> <a href="/delivery-to-city/letichev/">Летичев</a><br> </li> <li> <a href="/delivery-to-city/neteshin/">Нетешин</a><br> </li> <li> <a href="/delivery-to-city/novaya-ushitsa/">Новая Ушица</a><br> </li> <li> <a href="/delivery-to-city/polonnoe/">Полонное</a><br> </li> <li> <a href="/delivery-to-city/slavuta/">Славута</a><br> </li> <li> <a href="/delivery-to-city/staraya-sinyava/">Старая Синява</a><br> </li> <li> <a href="/delivery-to-city/starokonstantinov/">Староконстантинов</a><br> </li> <li> <a href="/delivery-to-city/teofipoly/">Теофиполь</a><br> </li> <li> <a href="/delivery-to-city/hmelynitskij/">Хмельницкий</a><br> </li> <li> <a href="/delivery-to-city/chemerovtsy/">Чемеровцы</a><br> </li> <li> <a href="/delivery-to-city/shepetovka/">Шепетовка</a><br> </li> <li> <a href="/delivery-to-city/yarmolintsy/">Ярмолинцы</a><br> </li> <li> <a href="/delivery-to-city/belozerka/">Белозерка</a><br> </li> <li> <a href="/delivery-to-city/berislav/">Берислав</a><br> </li> <li> <a href="/delivery-to-city/velikaya-aleksandrovka/">Великая Александровка</a><br> </li> <li> <a href="/delivery-to-city/velikaya-lepetiha/">Великая Лепетиха</a><br> </li> <li> <a href="/delivery-to-city/velikie-kopani/">Великие Копани</a><br> </li> <li> <a href="/delivery-to-city/verhnij-rogachik/">Верхний Рогачик</a><br> </li> <li> <a href="/delivery-to-city/vysokopolye/">Высокополье</a><br> </li> <li> <a href="/delivery-to-city/genichesk/">Геническ</a><br> </li> <li> <a href="/delivery-to-city/golaya-pristany/">Голая Пристань</a><br> </li> <li> <a href="/delivery-to-city/gornostaevka/">Горностаевка</a><br> </li> <li> <a href="/delivery-to-city/kalanchak/">Каланчак</a><br> </li> <li> <a href="/delivery-to-city/kahovka/">Каховка</a><br> </li> <li> <a href="/delivery-to-city/novaya-kahovka/">Новая Каховка</a><br> </li> <li> <a href="/delivery-to-city/novovorontsovka/">Нововоронцовка</a><br> </li> <li> <a href="/delivery-to-city/novotroitskoe/">Новотроицкое</a><br> </li> <li> <a href="/delivery-to-city/skadovsk/">Скадовск</a><br> </li> <li> <a href="/delivery-to-city/herson/">Херсон</a><br> </li> <li> <a href="/delivery-to-city/tsyurupinsk/">Цюрупинск</a><br> </li> <li> <a href="/delivery-to-city/chaplinka/">Чаплинка</a><br> </li> <li> <a href="/delivery-to-city/beregovo/">Берегово</a><br> </li> <li> <a href="/delivery-to-city/velikij-bereznyj/">Великий Березный</a><br> </li> <li> <a href="/delivery-to-city/velikij-bychkov/">Великий Бычков</a><br> </li> <li> <a href="/delivery-to-city/vinogradov/">Виноградов</a><br> </li> <li> <a href="/delivery-to-city/irshava/">Иршава</a><br> </li> <li> <a href="/delivery-to-city/mezhgorye/">Межгорье</a><br> </li> <li> <a href="/delivery-to-city/mukachevo/">Мукачево</a><br> </li> <li> <a href="/delivery-to-city/nizhnie-vorota/">Нижние Ворота</a><br> </li> <li> <a href="/delivery-to-city/perechin/">Перечин</a><br> </li> <li> <a href="/delivery-to-city/rahov/">Рахов</a><br> </li> <li> <a href="/delivery-to-city/svalyava/">Свалява</a><br> </li> <li> <a href="/delivery-to-city/tyachev/">Тячев</a><br> </li> <li> <a href="/delivery-to-city/uzhgorod/">Ужгород</a><br> </li> <li> <a href="/delivery-to-city/hust/">Хуст</a><br> </li> <li> <a href="/delivery-to-city/yasinya/">Ясиня</a><br> </li> <li> <a href="/delivery-to-city/berezhany/">Бережаны</a><br> </li> <li> <a href="/delivery-to-city/borschev/">Борщев</a><br> </li> <li> <a href="/delivery-to-city/buchach/">Бучач</a><br> </li> <li> <a href="/delivery-to-city/gusyatin/">Гусятин</a><br> </li> <li> <a href="/delivery-to-city/zaleschiki/">Залещики</a><br> </li> <li> <a href="/delivery-to-city/zbarazh/">Збараж</a><br> </li> <li> <a href="/delivery-to-city/zborov/">Зборов</a><br> </li> <li> <a href="/delivery-to-city/kozova/">Козова</a><br> </li> <li> <a href="/delivery-to-city/kopychintsy/">Копычинцы</a><br> </li> <li> <a href="/delivery-to-city/kremenets/">Кременец</a><br> </li> <li> <a href="/delivery-to-city/lanovtsy/">Лановцы</a><br> </li> <li> <a href="/delivery-to-city/monastyriska/">Монастыриска</a><br> </li> <li> <a href="/delivery-to-city/podvolochisk/">Подволочиск</a><br> </li> <li> <a href="/delivery-to-city/podgajtsy/">Подгайцы</a><br> </li> <li> <a href="/delivery-to-city/pochaev/">Почаев</a><br> </li> <li> <a href="/delivery-to-city/terebovlya/">Теребовля</a><br> </li> <li> <a href="/delivery-to-city/ternopoly/">Тернополь</a><br> </li> <li> <a href="/delivery-to-city/chortkov/">Чортков</a><br> </li> <li> <a href="/delivery-to-city/shumsk/">Шумск</a><br> </li> <li> <a href="/delivery-to-city/berezno/">Березно</a><br> </li> <li> <a href="/delivery-to-city/vladimirets/">Владимирец</a><br> </li> <li> <a href="/delivery-to-city/goscha/">Гоща</a><br> </li> <li> <a href="/delivery-to-city/dubno/">Дубно</a><br> </li> <li> <a href="/delivery-to-city/dubrovitsa/">Дубровица</a><br> </li> <li> <a href="/delivery-to-city/zarechnoe/">Заречное</a><br> </li> <li> <a href="/delivery-to-city/zdolbunov/">Здолбунов</a><br> </li> <li> <a href="/delivery-to-city/klevany/">Клевань</a><br> </li> <li> <a href="/delivery-to-city/korets/">Корец</a><br> </li> <li> <a href="/delivery-to-city/kostopoly/">Костополь</a><br> </li> <li> <a href="/delivery-to-city/kuznetsovsk/">Кузнецовск</a><br> </li> <li> <a href="/delivery-to-city/mlinov/">Млинов</a><br> </li> <li> <a href="/delivery-to-city/ozhenin/">Оженин</a><br> </li> <li> <a href="/delivery-to-city/ostrog/">Острог</a><br> </li> <li> <a href="/delivery-to-city/radivilov/">Радивилов</a><br> </li> <li> <a href="/delivery-to-city/rovno/">Ровно</a><br> </li> <li> <a href="/delivery-to-city/sarny/">Сарны</a><br> </li> <li> <a href="/delivery-to-city/smyga/">Смыга</a><br> </li> <li> <a href="/delivery-to-city/bolehov/">Болехов</a><br> </li> <li> <a href="/delivery-to-city/burshtyn/">Бурштын</a><br> </li> <li> <a href="/delivery-to-city/verhovina/">Верховина</a><br> </li> <li> <a href="/delivery-to-city/galich/">Галич</a><br> </li> <li> <a href="/delivery-to-city/gorodenka/">Городенка</a><br> </li> <li> <a href="/delivery-to-city/dolina/">Долина</a><br> </li> <li> <a href="/delivery-to-city/zabolotov/">Заболотов</a><br> </li> <li> <a href="/delivery-to-city/ivano-frankovsk/">Ивано-Франковск</a><br> </li> <li> <a href="/delivery-to-city/kalush/">Калуш</a><br> </li> <li> <a href="/delivery-to-city/kolomyya/">Коломыя</a><br> </li> <li> <a href="/delivery-to-city/kosov/">Косов</a><br> </li> <li> <a href="/delivery-to-city/nadvornaya/">Надворная</a><br> </li> <li> <a href="/delivery-to-city/rogatin/">Рогатин</a><br> </li> <li> <a href="/delivery-to-city/rozhnyatov/">Рожнятов</a><br> </li> <li> <a href="/delivery-to-city/snyatin/">Снятин</a><br> </li> <li> <a href="/delivery-to-city/tolkovately/">Толкователь</a><br> </li> <li> <a href="/delivery-to-city/brody/">Броды</a><br> </li> <li> <a href="/delivery-to-city/busk/">Буск</a><br> </li> <li> <a href="/delivery-to-city/drogobych/">Дрогобыч</a><br> </li> <li> <a href="/delivery-to-city/zhidachov/">Жидачов</a><br> </li> <li> <a href="/delivery-to-city/zhovkva/">Жовква</a><br> </li> <li> <a href="/delivery-to-city/zolochev/">Золочев</a><br> </li> <li> <a href="/delivery-to-city/kamenka-bugskaya/">Каменка-Бугская</a><br> </li> <li> <a href="/delivery-to-city/lyvov/">Львов</a><br> </li> <li> <a href="/delivery-to-city/mostiska/">Мостиска</a><br> </li> <li> <a href="/delivery-to-city/novoyavorovsk/">Новояворовск</a><br> </li> <li> <a href="/delivery-to-city/novyj-razdel/">Новый Раздел</a><br> </li> <li> <a href="/delivery-to-city/peremyshlyany/">Перемышляны</a><br> </li> <li> <a href="/delivery-to-city/radehov/">Радехов</a><br> </li> <li> <a href="/delivery-to-city/sambor/">Самбор</a><br> </li> <li> <a href="/delivery-to-city/skole/">Сколе</a><br> </li> <li> <a href="/delivery-to-city/sokaly/">Сокаль</a><br> </li> <li> <a href="/delivery-to-city/staryj-sambor/">Старый Самбор</a><br> </li> <li> <a href="/delivery-to-city/stryj/">Стрый</a><br> </li> <li> <a href="/delivery-to-city/truskavets/">Трускавец</a><br> </li> <li> <a href="/delivery-to-city/turka/">Турка</a><br> </li> <li> <a href="/delivery-to-city/hodorov/">Ходоров</a><br> </li> <li> <a href="/delivery-to-city/chervonograd/">Червоноград</a><br> </li> <li> <a href="/delivery-to-city/vatutino/">Ватутино</a><br> </li> <li> <a href="/delivery-to-city/gorodische/">Городище</a><br> </li> <li> <a href="/delivery-to-city/drabov/">Драбов</a><br> </li> <li> <a href="/delivery-to-city/zhashkov/">Жашков</a><br> </li> <li> <a href="/delivery-to-city/zvenigorodka/">Звенигородка</a><br> </li> <li> <a href="/delivery-to-city/zolotonosha/">Золотоноша</a><br> </li> <li> <a href="/delivery-to-city/kamenka/">Каменка</a><br> </li> <li> <a href="/delivery-to-city/kanev/">Канев</a><br> </li> <li> <a href="/delivery-to-city/katerinopoly/">Катеринополь</a><br> </li> <li> <a href="/delivery-to-city/korsuny-shevchenkovskij/">Корсунь-Шевченковский</a><br> </li> <li> <a href="/delivery-to-city/lysyanka/">Лысянка</a><br> </li> <li> <a href="/delivery-to-city/manykovka/">Маньковка</a><br> </li> <li> <a href="/delivery-to-city/monastyrische/">Монастырище</a><br> </li> <li> <a href="/delivery-to-city/smela/">Смела</a><br> </li> <li> <a href="/delivery-to-city/talynoe/">Тальное</a><br> </li> <li> <a href="/delivery-to-city/umany/">Умань</a><br> </li> <li> <a href="/delivery-to-city/hristinovka/">Христиновка</a><br> </li> <li> <a href="/delivery-to-city/cherkassy/">Черкассы</a><br> </li> <li> <a href="/delivery-to-city/chernobaj/">Чернобай</a><br> </li> <li> <a href="/delivery-to-city/chigirin/">Чигирин</a><br> </li> <li> <a href="/delivery-to-city/shpola/">Шпола</a><br> </li> <li> <a href="/delivery-to-city/vizhnitsa/">Вижница</a><br> </li> <li> <a href="/delivery-to-city/glybokaya/">Глыбокая</a><br> </li> <li> <a href="/delivery-to-city/zastavna/">Заставна</a><br> </li> <li> <a href="/delivery-to-city/kelymentsy/">Кельменцы</a><br> </li> <li> <a href="/delivery-to-city/kitsmany/">Кицмань</a><br> </li> <li> <a href="/delivery-to-city/mamaevtsy/">Мамаевцы</a><br> </li> <li> <a href="/delivery-to-city/novodnestrovsk/">Новоднестровск</a><br> </li> <li> <a href="/delivery-to-city/novoselitsa/">Новоселица</a><br> </li> <li> <a href="/delivery-to-city/sokiryany/">Сокиряны</a><br> </li> <li> <a href="/delivery-to-city/storozhinets/">Сторожинец</a><br> </li> <li> <a href="/delivery-to-city/hotin/">Хотин</a><br> </li> <li> <a href="/delivery-to-city/chernovtsy/">Черновцы</a><br> </li> <li> <a href="/delivery-to-city/vladimir-volynskij/">Владимир-Волынский</a><br> </li> <li> <a href="/delivery-to-city/gorohov/">Горохов</a><br> </li> <li> <a href="/delivery-to-city/ivanichi/">Иваничи</a><br> </li> <li> <a href="/delivery-to-city/kameny-kashirskij/">Камень-Каширский</a><br> </li> <li> <a href="/delivery-to-city/kivertsy/">Киверцы</a><br> </li> <li> <a href="/delivery-to-city/kovely/">Ковель</a><br> </li> <li> <a href="/delivery-to-city/kolki/">Колки</a><br> </li> <li> <a href="/delivery-to-city/lokachi/">Локачи</a><br> </li> <li> <a href="/delivery-to-city/lutsk/">Луцк</a><br> </li> <li> <a href="/delivery-to-city/lyubeshov/">Любешов</a><br> </li> <li> <a href="/delivery-to-city/lyubomly/">Любомль</a><br> </li> <li> <a href="/delivery-to-city/manevichi/">Маневичи</a><br> </li> <li> <a href="/delivery-to-city/novovolynsk/">Нововолынск</a><br> </li> <li> <a href="/delivery-to-city/ratno/">Ратно</a><br> </li> <li> <a href="/delivery-to-city/rozhische/">Рожище</a><br> </li> <li> <a href="/delivery-to-city/staraya-vyzhevka/">Старая Выжевка</a><br> </li> <li> <a href="/delivery-to-city/starovojtovo/">Старовойтово</a><br> </li> <li> <a href="/delivery-to-city/turijsk/">Турийск</a><br> </li> <li> <a href="/delivery-to-city/shatsk/">Шацк</a><br> </li> </ul> </div> </div>';
		$test = str_replace('<li>', ',', $test);
		$test = strip_tags($test);
		
		$test = explode(',', $test);
		foreach($test as $index => $row){
			$test[$index ] = trim($row);
			
			$value = array();
			$value['name'] = trim($row);
			$value['name_rod'] = trim($row);
			$value['name_dat'] = trim($row);
			$value['telephone'] = '0506410410';
			$value['text1'] = '';
			$value['text2'] = '';
			$value['text3'] = '';
			$value['text4'] = '';
			
			$this->db->query("INSERT INTO " . DB_PREFIX . "city SET
						 alias = '" . strtolower($this->translitArtkl($value['name'])) . "',
						 sort_order = '0'");

			$city_id = $this->db->getLastId();
			
			
			$language_id = 1;
			$this->db->query("INSERT INTO " . DB_PREFIX . "city_description SET city_id = '" . (int)$city_id . "',
							 language_id = '" . (int)$language_id . "',
							 name = '" . $this->db->escape($value['name']) . "',
							 name_rod = '" . $this->db->escape($value['name_rod']) . "',
							 name_dat = '" . $this->db->escape($value['name_dat']) . "',
							 telephone = '" . $this->db->escape($value['telephone']) . "',
							 text1 = '" . $this->db->escape($value['text1']) . "',
							 text2 = '" . $this->db->escape($value['text2']) . "',
							 text3 = '" . $this->db->escape($value['text3']) . "',
							 text4 = '" . $this->db->escape($value['text4']) . "'
							 ");
			$language_id = 2;
			$this->db->query("INSERT INTO " . DB_PREFIX . "city_description SET  city_id = '" . (int)$city_id . "',
							 language_id = '" . (int)$language_id . "',
							 name = '" . $this->db->escape($value['name']) . "',
							 name_rod = '" . $this->db->escape($value['name_rod']) . "',
							 name_dat = '" . $this->db->escape($value['name_dat']) . "',
							 telephone = '" . $this->db->escape($value['telephone']) . "',
							 text1 = '" . $this->db->escape($value['text1']) . "',
							 text2 = '" . $this->db->escape($value['text2']) . "',
							 text3 = '" . $this->db->escape($value['text3']) . "',
							 text4 = '" . $this->db->escape($value['text4']) . "'
							 ");
			
	$language_id = 3;
			$this->db->query("INSERT INTO " . DB_PREFIX . "city_description SET  city_id = '" . (int)$city_id . "',
							 language_id = '" . (int)$language_id . "',
							 name = '" . $this->db->escape($value['name']) . "',
							 name_rod = '" . $this->db->escape($value['name_rod']) . "',
							 name_dat = '" . $this->db->escape($value['name_dat']) . "',
							 telephone = '" . $this->db->escape($value['telephone']) . "',
							 text1 = '" . $this->db->escape($value['text1']) . "',
							 text2 = '" . $this->db->escape($value['text2']) . "',
							 text3 = '" . $this->db->escape($value['text3']) . "',
							 text4 = '" . $this->db->escape($value['text4']) . "'
							 ");
			
			
			
			
			
		}
		die(implode(',',$test));
		*/
		
		$data['heading_title'] = $this->language->get('Редактировать город');

		$data['text_form'] = !isset($this->request->get['city_id']) ? $this->language->get('Добавить') : $this->language->get('Редактировать');

		$data['entry_name'] = $this->language->get('Имя города');
		$data['entry_alias'] = $this->language->get('Алиас/ЧПУ');
		$data['entry_sort_order'] = $this->language->get('Сортировка');

		$data['button_save'] = $this->language->get('Сохранить');
		$data['button_cancel'] = $this->language->get('Отменить');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->error['name'])) {
			$data['error_name'] = $this->error['name'];
		} else {
			$data['error_name'] = array();
		}

		if (isset($this->error['alias'])) {
			$data['error_alias'] = $this->error['alias'];
		} else {
			$data['error_alias'] = '';
		}

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		if (isset($this->request->get['filter_name'])) {
			$url .= '&filter_name=' . $this->request->get['filter_name'];
		}

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('Список городов'),
			'href' => $this->url->link('catalog/city', 'token=' . $this->session->data['token'] . $url, true)
		);

		if (!isset($this->request->get['city_id'])) {
			$data['action'] = $this->url->link('catalog/city/add', 'token=' . $this->session->data['token'] . $url, true);
		} else {
			$data['action'] = $this->url->link('catalog/city/edit', 'token=' . $this->session->data['token'] . '&city_id=' . $this->request->get['city_id'] . $url, true);
		}

		$data['cancel'] = $this->url->link('catalog/city', 'token=' . $this->session->data['token'] . $url, true);

		if (isset($this->request->get['city_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$city_info = $this->model_catalog_city->getCity($this->request->get['city_id']);
		}

		$this->load->model('localisation/language');

		$data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['city_description'])) {
			$data['city_description'] = $this->request->post['city_description'];
		} elseif (isset($this->request->get['city_id'])) {
			$data['city_description'] = $this->model_catalog_city->getCityDescriptions($this->request->get['city_id']);
		} else {
			$data['city_description'] = array();
		}

		if (isset($this->request->post['alias'])) {
			$data['alias'] = $this->request->post['alias'];
		} elseif (!empty($city_info)) {
			$data['alias'] = $city_info['alias'];
		} else {
			$data['alias'] = '';
		}

		if (isset($this->request->post['sort_order'])) {
			$data['sort_order'] = $this->request->post['sort_order'];
		} elseif (!empty($city_info)) {
			$data['sort_order'] = $city_info['sort_order'];
		} else {
			$data['sort_order'] = '';
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('catalog/city_form', $data));
	}

	protected function validateForm() {
		
		return true;
	}

	protected function validateDelete() {
		return true;
	}

	public function autocomplete() {
		$json = array();

		if (isset($this->request->get['filter_name'])) {
			$this->load->model('catalog/city');

			$filter_data = array(
				'filter_name' => $this->request->get['filter_name'],
				'start'       => 0,
				'limit'       => 5
			);

			$results = $this->model_catalog_city->getCitys($filter_data);

			foreach ($results as $result) {
				$json[] = array(
					'city_id'    => $result['city_id'],
					'name'            => strip_tags(html_entity_decode($result['name'], ENT_QUOTES, 'UTF-8')),
					'alias' => $result['alias']
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
