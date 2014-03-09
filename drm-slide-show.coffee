###############################################################################
# Displays a slideshow with a slide
###############################################################################

( ($) ->

	slideHolder = $('div.slide-holder').css('overflow', 'hidden').children 'div.slides'
	imgs = slideHolder.find '.slide-content'
	imgWidth = imgs.first().width()
	imgsLen = imgs.length
	current = 1
	totalImgsWidth = imgsLen * imgWidth
	sliderNav = $ '.slider-nav'
	imgList = $ 'ul.img-list'
	imgButtons = imgList.find 'button'
	buttonBack = imgButtons.css 'background-color'
	buttonHoverBack = '#333'
	buttonCurrentBack = '#00c0c9'
	animate = 'yes'

	if imgsLen > 1
		sliderNav.show()
		imgList.show()
		imgButtons.first().css('background-color', buttonCurrentBack)

	moveSlide = ->
		direction = $(@).data 'dir'
		loc = imgWidth
		currentButton = $('button#button' + current)

		if direction == 'next'	
			++current
			imgButtons.css('background-color', buttonBack)
			currentButton = $('button#button' + current)
			currentButton.css('background-color', buttonCurrentBack)
			clearInterval start
		else
			--current
			imgButtons.css('background-color', buttonBack)	
			currentButton = $('button#button' + current)
			currentButton.css('background-color', buttonCurrentBack)
			clearInterval start

		if current == 0
			current = imgsLen
			loc = totalImgsWidth - imgWidth
			direction = 'next'	
			currentButton = $('button#button' + current)
			currentButton.css('background-color', buttonCurrentBack)
			clearInterval start
		else if (current - 1) == imgsLen
			current = 1
			loc = 0
			currentButton = $('button#button' + current)	
			currentButton.css('background-color', buttonCurrentBack)
			clearInterval start

		transition(slideHolder, loc, direction)

	sliderNav.find('button').on('click', moveSlide)

	startShow = ->
		direction = 'next'
		loc = imgWidth
		currentButton = $('button#button' + current)

		if current != imgsLen
			++current
			imgButtons.css('background-color', buttonBack)
			currentButton = $('button#button' + current)
			currentButton.css('background-color', buttonCurrentBack)
		else if current == imgsLen		
			current = 1
			loc = 0
			imgButtons.css('background-color', buttonBack)
			currentButton = $('button#button' + current)
			currentButton.css('background-color', buttonCurrentBack)

		transition(slideHolder, loc, direction)	

		return current

	if animate == 'yes'
		start = setInterval( startShow, 5000 )

	imgButtons.on 'click', (loc) ->
		direction = 'next'
		imgNum = $(@).data 'num'

		if imgNum != current
			loc = Math.abs(imgNum - current) * imgWidth
			direction = if imgNum < current then 'prev' else 'next'
			transition(slideHolder, loc, direction)
			current = imgNum
			imgButtons.css('background-color', buttonBack)
			$(@).css('background-color', buttonCurrentBack)
			clearInterval(start, 60000)
			
		return current

	imgButtons.on 'mouseenter', ->
		currentButton = $('button#button' + current)
		imgButtons.css('background-color', buttonBack)
		currentButton.css('background-color', buttonCurrentBack)
		$(@).css('background-color', buttonHoverBack)

	imgButtons.on 'mouseleave', ->
		currentButton = $('button#button' + current)
		imgButtons.css('background-color', buttonBack)
		currentButton.css('background-color', buttonCurrentBack)

	transition = (container, loc, direction) ->

		if direction && loc != 0
			unit = if direction == 'next' then '-=' else '+='

		container.animate
			'margin-left': if unit then unit + loc else loc

	return	

) jQuery