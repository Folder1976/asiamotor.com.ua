<?php
class Document {
	private $title;
	private $description;
	private $keywords;
	private $links = array();
	private $styles = array();
	private $scripts = array();
private $robots;
	private $og_image;

	public function setTitle($title) {
		$this->title = $title;
	}

	public function getTitle() {
		return $this->title;
	}

	public function setDescription($description) {
		$this->description = $description;
	}

	public function getDescription() {
		return $this->description;
	}

	public function setKeywords($keywords) {
		$this->keywords = $keywords;
	}

	public function getKeywords() {
		return $this->keywords;
	}

	public function addLink($href, $rel) {
		$this->links[$href] = array(
			'href' => $href,
			'rel'  => $rel
		);
	}

	public function getLinks() {
		return $this->links;
	}

	public function addStyle($href, $rel = 'stylesheet', $media = 'screen') {
		$this->styles[$href] = array(
			'href'  => $href,
			'rel'   => $rel,
			'media' => $media
		);
	}


			public function setRobots($robots) {
				$this->robots = $robots;
			}
			
			public function getRobots() {
				return $this->robots;
			}
			
	public function getStyles() {
		return $this->styles;
	}

	
			public function addScript($href, $postion = 'header', $temp = '') {
			
		
			if (!empty($temp)) {
				$this->scripts[$temp][$postion][$href] = $href;
			} else {
				$this->scripts[$postion][$href] = $href;
			}
			
	}

	
			public function getScripts($postion = 'header', $temp = '') {
				if (isset($this->scripts[$temp][$postion])) {
					if (!empty($temp)) {
						if (isset($this->scripts[$postion]) && !empty($this->scripts[$postion])) {
							return array_merge($this->scripts[$temp][$postion],$this->scripts[$postion]);
						} else {
							return $this->scripts[$temp][$postion];
						}
					} else {
						return $this->scripts[$postion];
					}
				} else {
					if (isset($this->scripts[$postion])) {
						return $this->scripts[$postion];
					} else {
						return array();
					}
				}
			}
			
			public function getOldScripts($postion = 'header') {
			
		if (isset($this->scripts[$postion])) {
			return $this->scripts[$postion];
		} else {
			return array();
		}
	}

	public function setOgImage($image) {
		$this->og_image = $image;
	}

	public function getOgImage() {
		return $this->og_image;
	}
}
