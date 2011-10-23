// Yo, JS.

!function() {
	
	var CTT = this.CTT = {

		views: [
			['.', {
				
				init: function() {

					var domSearchInputArea = $('#search_input_area'),
						domQuery = $('#query'),
						domError = $('<div class="error"><div/></div>').css('opacity', 0)
										.height(0).insertBefore(domSearchInputArea),
						domErrorText = domError.find('div');
					
					domSearchInputArea.closest('form').submit(function(){
						if (/^\s*$/.test(domQuery.val())) {

							domErrorText.text('Please enter something below');
							domError.show().animate({
								height: 50
							}, 200).animate({opacity:1});

							return false;
						}
					});
				}

			}],
			['/admin/(?:new|edit)', {
				
				init: function() {
					this.tagList = new this.TagList(this, $('input#Tags'));
				},

				/**
				 * TagList impl.
				 * Facebook-like input tags
				 */

				TagList: Klass({
					init: function(view, el) {

						this.view = view;
						this.domRealInput = $(el);
						this.domRealInput.hide();

						this.domInput = $('<input class="taglist_input" />');
						this.domAdd = $('<button>Add</button>');
						this.domTags = $('<span class="tags"></span>');
						this.dom = $('<div class="taglist" />').insertBefore(this.domRealInput);

						this.dom
							.append(this.domTags)
							.append(this.domInput)
							.append(this.domAdd);

						this.initValues();
						this.listen();

					},
					initValues: function() {
						this.tags = [];
						var value = this.domRealInput.val().split(',');
						for (var i = -1, l = value.length; ++i < l;) {
							this.tags.push(
								new this.view.TagListTag(value[i], this)
							);
						}
					},
					listen: function() {
						var me = this;
						this.domInput.keypress(function(e){
							if (e.keyCode == 13 || e.keyCode == 188) {
								me.tags.push(
									new me.view.TagListTag(this.value, me)
								);
								this.value = '';
								me.resetRealInput();
								return false;
							}
						});
						this.domAdd.click(function(){
							me.tags.push(
								new me.view.TagListTag(me.domInput.val(), me)
							);
							me.domInput.val('');
							me.resetRealInput();
							return false;
						})
					},
					resetRealInput: function() {
						this.domRealInput.val( String(this) );
					},
					toString: function() {
						return this.tags.join(', ').replace(/,,|^,|,$/g, '');
					}
				}),

				TagListTag: Klass({
					init: function(v, tagListInstance) {

						this.value = v || '';

						if (/^\s*$/.test(this.value)) return;

						this.tagList = tagListInstance;
						this.dom = $('<span class="tag"><span class="tval"></span><span class="trm"> x</span></span>');
						this.domRm = this.dom.find('.trm');
						this.domVal = this.dom.find('.tval');
						this.domVal.text(this.value);
						this.tagList.domTags.append(this.dom);
						this.listen();
					},
					listen: function() {
						var me = this;
						this.domRm.click(function(){
							me.remove();
						});
					},
					remove: function() {
						this.value = '';
						this.dom.remove();
						this.tagList.resetRealInput();
					},
					toString: function(){
						return this.value.replace(/^\s+|\s+$/g);
					}
				})

			}],
			['/search', {
				init: function() {
					$('.result.promoted').each(function(){
						$(this).prependTo(this.parentNode);
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

	function Klass(o) {
		var constructor = o.init;
		constructor.prototype = o;
		return constructor;
	}

	Function.prototype.bind = Function.prototype.bind || function(b) {
		var f = this; return function() {return f.apply(b, arguments);};
	};

}();