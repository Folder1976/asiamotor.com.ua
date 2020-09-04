function octShowProducts(octButtonID, octModuleID, itemsLimit, countProducts) {
	const currentWidth = viewport().width;
	if (currentWidth > 1200) {
		itemsLimit = 8;
	} else if ((currentWidth <= 1200) && (currentWidth > 992)) {
		itemsLimit = 6;
	} else if (currentWidth <= 992) {
		itemsLimit = 4;
	}
	const buttonID = octButtonID;
	const moduleID = octModuleID + ' > .item-box:hidden';
	if (countProducts <= itemsLimit) {
		$('#' + buttonID).parent().parent().parent().hide();
	}
	$('#' + moduleID).slice(0, itemsLimit).show();
	$('#' + buttonID).on('click', function () {
		$('#' + moduleID).slice(0, itemsLimit).slideToggle(50);
		if ($('#' + moduleID).length == 0) {
			$('#' + buttonID).fadeOut('fast');
		}
	});
}