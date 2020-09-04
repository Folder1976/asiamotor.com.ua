$(document).ready(function () {

  // use default autocomplete script if not defined ss_autocomplete
  if ($.fn.ss_autocomplete === undefined) {
    $.fn.ss_autocomplete = $.fn.autocomplete;
  }

  if (window.search_element === undefined) {
    search_element = '#search input[name="search"]';
  } else {
    search_element = window.search_element;
  }
  
  $(search_element).ss_autocomplete({
    delay: 500,
    source: function (request, response) {
      if (request === '') {
        this.hide();
        return false;
      }
      $.ajax({
        url: 'index.php?route=extension/module/search_suggestion/ajax&keyword=' + encodeURIComponent(request),
        dataType: 'json',
        success: function (json) {
          response($.map(json, function (item) {
            var elements = [];
            $.each(item['fields'], function (field_name, field) {
              if (field != undefined && field[field_name] !== undefined && field[field_name]) {

                var field_html = '';
                if (field_name == 'image') {
                  field_html = '<img src="' + field[field_name] + '" />';
                } else if (field_name == 'price') {
                  if (field.special) {
                    field_html = '<span class="price-old">' + field.price + '</span><span class="price-new">' + field.special + '</span>';
                  } else {
                    field_html = field.price;
                  }
                } else {
                  field_html = field[field_name];
                }

                if (field.label != undefined && field.label.show != undefined && field.label.show) {
                  field_html = '<span class="label">' + field.label.label + '</span>' + field_html;
                }
                if (field.location != undefined && field.location == 'inline') {
                  field_html = '<span class="' + field_name + '">' + field_html + '</span>';
                } else {
                  field_html = '<div class="' + field_name + '">' + field_html + '</div>';
                }

                elements.push({sort: field.sort, html: field_html});
              }
            });

            // sort
            elements.sort(function (a, b) {
              return a.sort - b.sort
            });

            // implode
            var elements_html = '';
            $.each(elements, function (index, element) {
              if (element != undefined) {
                elements_html = elements_html + element.html;
              }
            });
            
            if (item['type'] != undefined) {
              item_type = item['type'];
            } else {
              item_type = '';
            }
            
            elements_html = '<div class="search-suggestion ' + item_type + '">' + elements_html + '</div>';

            return {
              label: elements_html,
              value: item['href']
            };
          }));
        }
      });
    },
    select: function (item) {
      if (item['value'] !== '') {
        location.href = item['value'];
      }
      return false;
    },
    focus: function (event, ui) {
      return false;
    }
  });
});