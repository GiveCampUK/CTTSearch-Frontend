// Yo, JS.

!function() {
	
	this.CTT = {

		views: [
			['.', {
				
				init: function() {

					var domSearchInputArea = $('#search_input_area'),
						domQuery = $('#query');
					
					domSearchInputArea.closest('form').submit(function(){
						if (/^\s*$/.test(domQuery.val())) {
							alert('Please enter something');
							return false;
						}
					});
				}

			}],
			['/$', {

				init: function() {
					this.setupSliders();
				},

				setupSliders: function() {

					// Setup sliders

					this.domOrgSize = $('#org_size');
					this.domTechLevel = $('#user_prof');

					this.domOrgSizeOptions = this.domOrgSize.find('option');
					this.domTechLevelOptions = this.domTechLevel.find('option');

					this.domOrgSizeValueLabel = $('<span/>').appendTo('label[for=org_size]');
					this.domTechLevelValueLabel = $('<span/>').appendTo('label[for=user_prof]');

					this.domOrgSizeSlider = $('<div class="slider"/>');
					this.domTechLevelSlider = $('<div class="slider"/>');

					this.orgSizeSlider = this.domOrgSizeSlider
						.insertAfter(this.domOrgSize).slider({
							value: 0,
							min: 1,
							max: 3,
							step: 1,
							slide:  function(e, ui){
								var val = this.convertOrgSizeSliderVal(ui.value);
								this.domOrgSize.val(val);
							}.bind(this)
						})
						.data('slider');

					this.techLevelSlider = this.domTechLevelSlider
						.insertAfter(this.domTechLevel).slider({
							value: 0,
							min: 1,
							max: 3,
							step: 1,
							slide: function(e, ui) {
								var val = this.convertTechLevelSliderVal(ui.value);
								this.domTechLevel.val(val);
							}.bind(this)
						})
						.data('slider');

					this.setupSliderMarkers();

					this.domOrgSize.hide();
					this.domTechLevel.hide();

					this.orgSizeSlider.options.slide(null, {value:1});
					this.techLevelSlider.options.slide(null, {value:1});

				},

				convertOrgSizeSliderVal: function(v) {
					return this.domOrgSizeOptions.eq(v-1).val();
				},
				
				convertTechLevelSliderVal: function(v) {
					return this.domTechLevelOptions.eq(v-1).val();
				},

				setupSliderMarkers: function() {

					this.domOrgSizeSlider.append(
						'<div class="marker" style="left:0;text-align:left;">1-5</div>',
						'<div class="marker" style="left:50%;margin-left:-50px;text-align:center;">6-25</div>',
						'<div class="marker" style="right:0;text-align:right;">26+</div>'
					);

					this.domTechLevelSlider.append(
						'<div class="marker" style="left:0;text-align:left;">Novice</div>',
						'<div class="marker" style="left:50%;margin-left:-50px;text-align:center;">Intermediate</div>',
						'<div class="marker" style="right:0;text-align:right;">Advanced</div>'
					);
						
				}

			}]
		],

		init: function() {

			var loc = window.location.pathname,
				viewHandlers = this.views;

			for (var i = -1, l = viewHandlers.length; ++i < l;) {
				if ( RegExp(viewHandlers[i][0]).test(loc) ) {
					viewHandlers[i][1].CTT = this;
					viewHandlers[i][1].init();
				}
			}

		}

	};

	Function.prototype.bind = Function.prototype.bind || function(b) {
		var f = this; return function() {return f.apply(b, arguments);};
	};

}();