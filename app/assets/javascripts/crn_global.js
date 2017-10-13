var _functions = {};

jQuery(function($) {

    "use strict";

    /*===========*/
    /* variables */
    /*===========*/
    var swipers = [], winW, winH, winScr, _isresponsive,  _isFF = 'MozAppearance' in document.documentElement.style, _ismobile = navigator.userAgent.match(/Android/i) || navigator.userAgent.match(/webOS/i) || navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i) || navigator.userAgent.match(/iPod/i), scrollTo, ajaxList, docH;

    /*===================*/
    /* page calculations */
    /*===================*/
    _functions.pageCalculations = function(){
        winW = $(window).width();
        winH = $(window).height();
        docH = $(document).height();
        if ($('.ajaxList').length > 0) {
            ajaxList = $('.ajaxList').offset().top;
        } else {
            // console.log("else is working")
        }
        $('.page-height').css({'height':winH});
        if (winW < 767) {
            $('.new-mobile-banner').css({'height':winH/2});
        }
        $('.cellViewPageHeight .cell-view').css({'height':winH});
        $('.page-height-banner').css({'height':winH* 0.8});
    };

    _functions.initSelect = function(){
        if(!$('.SlectBox').length) return false;
        $('.SlectBox').SumoSelect({ csvDispCount: 3, search: false, searchText:'Search', noMatch:'No matches for "{0}"', floatWidth: 0, okCancelInMulti: true, placeholder: 'This is a placeholder' });
    };

    /*=========================*/
    /* function on page resize */
    /*=========================*/
    _functions.resizeCall = function(){
        _functions.pageCalculations();
    };
    if(!_ismobile){
        $(window).resize(function(){
            _functions.resizeCall();
        });
    } else{
        window.addEventListener("orientationchange", function() {
            _functions.resizeCall();
        }, false);
    }

    /*=========================*/
    /* function on page scroll */
    /*=========================*/
    $(window).scroll(function(){
        _functions.scrollCall();
    });

    _functions.scrollCall = function(){
        winScr = $(window).scrollTop();

        if(winScr>50) {
            $('header').addClass('scrolled');
        }	else {
            $('header').removeClass('scrolled');
        }
        if ( !_ismobile && $('body').hasClass('special')) {
            if ( winScr > (ajaxList+($(document).height() - docH)) - 85 ) {
                $('.ajaxList').addClass('sticky');
            } else {
                $('.ajaxList').removeClass('sticky');
            }
        }else {
            if ( !_ismobile && winScr > ajaxList - 85 ) {
                $('.ajaxList').addClass('sticky');
            } else {
                $('.ajaxList').removeClass('sticky');
            }
        }

        if (winScr + winH == docH ) {
            // console.log("Equel");
        }

    };

    /*================*/
    /* swiper sliders */
    /*================*/
    var initIterator = 0;
    function setParams(swiper, dataValue, returnValue){
        return (swiper.is('[data-'+dataValue+']'))?((typeof swiper.data(dataValue)!="string")?parseInt(swiper.data(dataValue), 10):swiper.data(dataValue)):returnValue;
    }
    _functions.initSwiper = function(){
        $('.swiper-container').not('.initialized').each(function(){
            var $t = $(this);

            var index = 'swiper-unique-id-'+initIterator;

            $t.addClass('swiper-'+index+' initialized').attr('id', index);
            $t.closest('.swiperMainWrapper').find('.swiper-pagination').addClass('swiper-pagination-'+index);
            $t.closest('.swiperMainWrapper').find('.swiper-button-prev').addClass('swiper-button-prev-'+index);
            $t.closest('.swiperMainWrapper').find('.swiper-button-next').addClass('swiper-button-next-'+index);

            swipers['swiper-'+index] = new Swiper('.swiper-'+index,{
                pagination: '.swiper-pagination-'+index,
                paginationClickable: true,
                nextButton: '.swiper-button-next-'+index,
                prevButton: '.swiper-button-prev-'+index,
                slidesPerView: setParams($t,'slides-per-view',1),
                autoHeight: setParams($t,'autoheight',0),
                loop: setParams($t,'loop',0),
                autoplay: setParams($t,'autoplay',0),
                centeredSlides: setParams($t,'center',0),
                breakpoints: ($t.is('[data-breakpoints]'))? {
                    767: { slidesPerView: ($t.attr('data-xs-slides')!='auto')?parseInt($t.attr('data-xs-slides'), 10):'auto', slidesPerGroup: ($t.attr('data-xs-slides')!='auto' && $t.data('center')!='1' && $t.data('group')=='1')?parseInt($t.attr('data-xs-slides'), 10):1},
                    991: { slidesPerView: ($t.attr('data-sm-slides')!='auto')?parseInt($t.attr('data-sm-slides'), 10):'auto', slidesPerGroup: ($t.attr('data-sm-slides')!='auto' && $t.data('center')!='1' && $t.data('group')=='1')?parseInt($t.attr('data-sm-slides'), 10):1 },
                    1199: { slidesPerView: ($t.attr('data-md-slides')!='auto')?parseInt($t.attr('data-md-slides'), 10):'auto', slidesPerGroup: ($t.attr('data-md-slides')!='auto' && $t.data('center')!='1' && $t.data('group')=='1')?parseInt($t.attr('data-md-slides'), 10):1 },
                    1370: { slidesPerView: ($t.attr('data-lt-slides')!='auto')?parseInt($t.attr('data-lt-slides'), 10):'auto', slidesPerGroup: ($t.attr('data-lt-slides')!='auto' && $t.data('center')!='1' && $t.data('group')=='1')?parseInt($t.attr('data-slides-per-view'), 10):1 }
                } : {},
                slidesPerGroup: ($t.is('[data-group]'))?parseInt($t.attr('data-slides-per-view'), 10):1,
                speed: setParams($t,'speed',500),
                parallax: !_ismobile ? setParams($t,'parallax',0) : 0,
                slideToClickedSlide: setParams($t,'clickedslide',0),
                mousewheelControl: setParams($t,'mousewheel',0),
                direction: ($t.is('[data-direction]'))?$t.data('direction'):'horizontal',
                effect: ($t.is('[data-effect]'))?$t.data('effect'):'slide',
                fade: {
                    crossFade: true
                },
                spaceBetween: setParams($t,'space',0),
                watchSlidesProgress: true,
                keyboardControl: true,
                mousewheelReleaseOnEdges: true,
                preloadImages: false,
                lazyLoading: true,
                lazyLoadingInPrevNext: true,
                lazyLoadingInPrevNextAmount: 1,
                lazyLoadingOnTransitionStart: true,
                loopedSlides: 3,
                roundLengths: true,
                onInit: function() {
                    if ($t.find('.swiper-slide').length == 1) {
                        $t.closest('.swiperMainWrapper').addClass('hideNavigation');
                    }
                }
                // paginationBulletRender: function(swiper, index, className) {
                // 	return '<span class="' + className + '">' + '<span class="text">' + $(swiper.slides[index]).data('text') + '</span>'  + '</span>';
                // }
            });
            swipers['swiper-'+index].update();
            initIterator++;
        });
    };

    /*=======================*/
    /* function on page load */
    /*=======================*/

    if(_ismobile) $('body').addClass('mobile');
    setTimeout ( function() {
        _functions.pageCalculations();
        _functions.initSwiper();
        _functions.scrollCall();
        $('body').addClass('loaded');
        // Loader
        $('#loader-wrapper').fadeOut();

        // Masonry
        if ( $('.grid').length ) {
            var $grid = $('.grid').isotope({
                itemSelector: '.grid-item',
                layoutMode: 'masonry',
                percentPosition: true,
                stamp: ".stamp",
                masonry: {
                    columnWidth: '.grid-sizer'
                }
            });
        }
        // filter functions
        var filterFns = {
            // show if number is greater than 50
            numberGreaterThan50: function() {
                var number = $(this).find('.number').text();
                return parseInt( number, 10 ) > 50;
            },
            // show if name ends with -ium
            ium: function() {
                var name = $(this).find('.name').text();
                return name.match( /ium$/ );
            }
        };
        // bind filter button click
        $('.filters-button-group').on( 'click', 'div', function() {
            var filterValue = $( this ).attr('data-filter');
            // use filterFn if matches value
            filterValue = filterFns[ filterValue ] || filterValue;
            $grid.isotope({ filter: filterValue });
        });
        // change is-checked class on buttons
        $('.button-group').each( function( i, buttonGroup ) {
            var $buttonGroup = $( buttonGroup );
            $buttonGroup.on( 'click', 'div', function() {
                $buttonGroup.find('.is-checked').removeClass('is-checked');
                $( this ).addClass('is-checked');
            });
        });
    }, 1500);



    /*================*/
    /* clicks, hovers */
    /*================*/



    // back top
    $('.back-to-top-wrapper .icon').on('click', function(){
        // $('body, html').animate({'scrollTop':0});
        if ($('.vacancy-wrap').length || $('.fullSizePopup').length || $('.popup-style').length) {
            $('.vacancy-wrap').animate({'scrollTop':0});
            $('.fullSizePopup').animate({'scrollTop':0});
            $('.popup-style').animate({'scrollTop':0});
        }
    });

    // filter news and other elements
    $( '.simpleList li' ).on( 'click', function() {
        $(this).siblings().removeClass('active')
        $(this).addClass('active')
        var $option = $(this).attr('data-option');
        if ( $option == 'all' ) {
            $( '.filterable' ).removeClass( 'is-hidden' );
        } else {
            $( '.filterable' ).addClass( 'is-hidden' );
            $( '.filterable[data-option=' + $option + ']' ).removeClass( 'is-hidden' );
        }
    });

    //file remove button in input file block
    $('.input-submit-wrapper .file-remove').on('click', function(){
        var filewrapper = $(this).closest('.input-submit-wrapper'),
            textwrapper = filewrapper.find('.input');
        filewrapper.removeClass('active');
        filewrapper.find('input').val('');
    });

    //responsive menu
    $('#hamburger').on('click', function(){
        $('header').toggleClass('active');
        $('html, body').toggleClass('overflow-hidden');
    });

    $('.headerListInner').on('click', function() {
        $('.headerList').toggleClass('activeSidebar');
    });

    // Scroll page banner
    $('.scrollTo').on('click', function() {
        var scrollToOffset = $(this).closest('.swiperMainWrapper').outerHeight();
        $('html, body').animate({'scrollTop': scrollToOffset -70}, 888);
    });

    // News drop down
    $('.responsiveDropDown').on('click', function() {
        $(this).siblings('.simpleList').slideToggle(350);
        $(this).find('.imgWrapper').toggleClass('rotateIcon');
    });

    //open and close popup
    $(document).on('click', '.open-popup', function(){
        var thisClickScr = $(this).attr('data-video-scr'),
            videoSrc = $(this).attr('data-video-scr'),
            thisVideoClick = $(this).hasClass('button-play'),
            thisPopupContent = $('.popup-content[data-rel="'+$(this).data('rel')+'"]');
        $('.popup-content').removeClass('active');
        $('.popup-wrapper, .popup-content[data-rel="'+$(this).data('rel')+'"]').addClass('active');
        $('html').addClass('overflow-hidden');

        // Add video to popup
        setTimeout(function() {
            if ( thisVideoClick ) {
                console.log(thisPopupContent);
                thisPopupContent.find('.videoIframe iframe').attr('src',videoSrc + '??modestbranding=1;iv_load_policy=0;modestbranding=1;showinfo=0&amp;autoplay=1' );
            }
        }, 550);
        return false;
    });

    $(document).on('click', '.popup-wrapper .button-close,  .popup-wrapper .layer-close, .headerListLayer', function(){
        if( $(this).hasClass('defaultLayer') ) {return false;}
        $('.popup-wrapper, .popup-content').removeClass('active');
        $('html').removeClass('overflow-hidden');

        $('.headerList').removeClass('activeSidebar');

        // Remove video from popup
        setTimeout(function() {
            $('.videoIframe iframe').attr('src', '#');
        }, 600);
        return false;
    });

    //Function OpenPopup
    function openPopup(foo){
        $('.popup-content').removeClass('active');
        $('.popup-wrapper, .popup-content[data-rel="'+foo+'"]').addClass('active');
        $('html').addClass('overflow-hidden');
        return false;
    }

    // Hide steps and opportunities popup
    $('.button-close').on('click', function() {
        // e.preventDefault();
        $('.stepsWrapper').removeClass('showSteps');
        $('.fullSizePopup').removeClass('showPopup');
        $('.vacancy-wrap').removeClass('visible');
        $('.mgmPopup').removeClass('showPopup');
        $('.popup-style').removeClass('showPopup');

        $('html').removeClass('overflow-hidden');
    });

    // Select Criterias
    $(document).on('click', '.criteriaWrapper', function() {
        // $(this).toggleClass('activeCriteria');
        var $this = $(this)
        if ($this.hasClass('activeCriteria')) {
            // $this.removeClass('activeCriteria')
        } else {
            var $container = $this.parent().parent()
            $container.find('.criteriaWrapper').removeClass('activeCriteria')
            $this.addClass('activeCriteria')
        }
    });

    // Show steps popup
    $('.showStepsButton').on('click', function(e) {
        e.preventDefault();
        $('.stepsWrapper').addClass('showSteps');
    });

    // Show all opportunities
    $('.showOpportunities').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.fullSizePopup').addClass('showPopup');
    });

    // Show showFullSizePopup
    $('.showFullSizePopup').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.fullSizePopup').addClass('showPopup');
    });

    // Show mgmPopup
    $('.mgmPopupBtn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.mgmPopup').addClass('showPopup');
    });



    //     A B O U T     U S     P A G E     P O P U P S
    // 01
    $('.people-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.people-popup').addClass('showPopup');
    });
    // 02
    $('.strategy-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.strategy-popup').addClass('showPopup');
    });
    // 03
    $('.specialists-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.specialists-popup').addClass('showPopup');
    });
    // 04
    $('.impact-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.impact-popup').addClass('showPopup');
    });
    // 05
    $('.global-reach-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.global-reach-popup').addClass('showPopup');
    });
    // 06
    $('.clients-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.clients-popup').addClass('showPopup');
    });

    //     S O L U T I O N     P A G E     P O P U P S

    // Show ucits popup (solution one MANAGEMENT)
    $('.ucits-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.ucits-popup').addClass('showPopup');
    });
    // Show aifmd popup (solution one)
    $('.aifmd-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.aifmd-popup').addClass('showPopup');
    });
    // Show risk popup (solution one)
    $('.risk-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.risk-popup').addClass('showPopup');
    });

    // Show ucits popup (solution one GOVERNANCE)
    $('.governance-fund-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.governance-fund-popup').addClass('showPopup');
    });
    // Show aifmd popup (solution one)
    $('.governance-risk-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.governance-risk-popup').addClass('showPopup');
    });
    // Show risk popup (solution one)
    $('.governance-fund-persons-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.governance-fund-persons').addClass('showPopup');
    });
    // Show risk popup (solution one)
    $('.governance-secretarial-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.governance-secretarial-popup').addClass('showPopup');
    });


    // Show ucits popup (solution one PLATFORM)
    $('.primo-ucits-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.primo-ucits-popup').addClass('showPopup');
    });
    // Show qiaif popup (solution one platform)
    $('.primo-qiaif-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.primo-qiaif-popup').addClass('showPopup');
    });

    // Show fund popups
    $('.irish-mlro-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.irish-mlro-popup').addClass('showPopup');
    });
    // Show qiaif popup (solution one platform)
    $('.fund-reg-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.fund-reg-popup').addClass('showPopup');
    });
    // Show qiaif popup (solution one platform)
    $('.distribution-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.distribution-popup').addClass('showPopup');
    });


    // Show ucits popup (solution one FUNDS)
    $('.primo-ucits-platform-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.primo-ucits-platform-popup').addClass('showPopup');
    });
    // Show qiaif popup (solution one funds)
    $('.primo-qiaif-platform-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.primo-qiaif-platform-popup').addClass('showPopup');
    });



    // Careers training popup
    $('.training-center-popup-btn').on('click', function(e) {
        e.preventDefault();
        $('html').addClass('overflow-hidden');
        $('.training-center-popup').addClass('showPopup');
    });



    // Open vacancy popup
    var vacancy_btn = $('.vacancy-btn')
    vacancy_btn.on('click', function(e) {
        e.preventDefault();
        // $('html').addClass('overflow-hidden');
        $('.vacancy-wrap').addClass('visible')
    });

    // Team popup
    $('.teamPopupButton').on('click', function() {
        var teamPopupSwiper = $('.teamPopup').find('.swiper-container').attr('id');
        $(this).closest('.teamHistorySwiper').addClass('hideTeam');
        setTimeout(function(){
            $('.teamHistorySwiper').addClass('teamNone');
            $('.teamPopup').removeClass('teamNone');
            swipers['swiper-' + teamPopupSwiper].update();
            setTimeout(function(){
                $('.teamPopup').removeClass('hideTeam');
            }, 400);
        },550);
    });

    // Close team popup
    $('.teamPopup .button-close').on('click', function() {
        $(this).closest('.teamPopup').addClass('hideTeam');
        setTimeout(function(){
            $('.teamPopup').addClass('teamNone');
            $('.teamHistorySwiper').removeClass('teamNone');
            setTimeout(function(){
                $('.teamHistorySwiper').removeClass('hideTeam');
            }, 400);
        },550);
    });





    //     T A B S

    $('.tab-container .tab').on('click', function(){
        $(this).siblings().removeClass('active')
        $(this).addClass('active')
        var $index = $(this).index()
        var $container = $(this).closest('.tabs-wrapper')
        $container.find('.tab-content').removeClass('visible')
        $container.find('.tab-content').eq($index).addClass('visible')
    })





    //     A J A X

    $(document).on('click', '.ajaxButton', function(e){
        e.preventDefault();

        // Ajax sidebar list
        if ( $('.ajaxList').length ) {
            $('.ajaxButton').parent().removeClass('activeNews');
            $(this).parent().addClass('activeNews');

            //Add current ajax name to sidebar list
            $('.responsiveDropDown b').html( $(this).html() );
        }

        // Take ajax path
        var url = $(this).attr('href'),
            // Get offset ajax wrapper for scroll after ajax end
            ajaxWrapperOffset = $('.ajaxWrapperContent').offset().top - 100;

        //Hide list after start ajax
        if ( $('.responsiveDropDown').is(":visible") ) {
            $('.simpleList').slideToggle(350);
            $('.responsiveDropDown .imgWrapper').removeClass('rotateIcon');
        }
        $('.ajaxLoader').fadeIn();

        // Stop page scroll when ajax start
        $('html, body').addClass('overflow-hidden');

        // Load more info ajax
        if ( $(this).hasClass('ajaxLoadMore') ) {
            $.ajax({
                type:"GET",
                async:true,
                url: url,
                success:function(response){
                    var responseObject = $($.parseHTML(response));
                    // Set time out for front end
                    setTimeout(function() {
                        $('.ajaxWrapperContent').append(responseObject);
                        // Ajax content animate
                        $('.ajaxContent').animate({opacity: 1, top: 0}, 1100);

                        $('.ajaxLoader').fadeOut();
                        // Start page scroll when ajax end
                        $('html, body').removeClass('overflow-hidden');
                    }, 1500);
                }
            });
        } else { //Load full page content ajax
            $.ajax({
                type:"GET",
                async:true,
                url: url,
                success:function(response){
                    var responseObject = $($.parseHTML(response));
                    // Set time out for front end
                    setTimeout(function() {
                        $('.ajaxWrapperContent *').remove();
                        $('.ajaxWrapperContent').append(responseObject);
                        // Ajax content animate
                        $('.ajaxContent').animate({opacity: 1, top: 0}, 1100);

                        // Animate scroll to ajax block if page not scrolled
                        if ( !$('.stepsWrapper').length && !_ismobile && winScr < ajaxWrapperOffset  ) {
                            $('html, body').animate({scrollTop: ajaxWrapperOffset}, 888);
                        }

                        $('.ajaxLoader').fadeOut();
                        // Start page scroll when ajax end
                        $('html, body').removeClass('overflow-hidden');
                    }, 1500);
                }
            });
        }
    });

});





//     S L I D E R

$(document).ready(function(){
    if ($('.bx-slider').length) {
        var gallery_slider = $('.bx-slider').bxSlider({
            controls: false,
            pager: false,
            auto: true,
            speed: 750,
            pause: 7500,
            onSlideBefore: function($slideElement, oldIndex, newIndex) {
                if (gallery_slider.getSlideCount) {
                    $('.pager .current-page').text(gallery_slider.getCurrentSlide()+1)
                }
            }
        });
        if (gallery_slider.getSlideCount) {
            $('.total-page').text(gallery_slider.getSlideCount())
            $('.slider-nav .btn-left').click (function(){
                gallery_slider.goToPrevSlide()
            })
            $('.slider-nav .btn-right').click (function(){
                gallery_slider.goToNextSlide()
            })
        }
    }

});