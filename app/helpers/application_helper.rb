module ApplicationHelper
	def reload_style(style_array=[])
		links = ''
		style_array.each do |style|
			links += (stylesheet_link_tag style, media: 'all', 'data-turbolinks-track': 'reload')
		end

		links.html_safe
	end

	def format_date(time)
    time.strftime("%Y-%m-%d") if time.present?
  end

  def format_date_time(time)
    time.strftime("%Y-%m-%d %H:%M:%S") if time.present?
  end

  def month_day(time)
  	time.strftime("%m-%d") if time.present?
  end

  def paging(url_path, count, page_no, page_size=15, *params)
  	return ''.html_safe if count.to_i < page_size.to_i

  	prv_page   = page_no.to_i - 1
  	next_page  = page_no.to_i + 1
  	page_count = (count.to_f/page_size.to_f).ceil

    base_url = "#{url_path}?" 

    if params.present?
      params.each do |param|
        base_url += "#{param.keys.first.to_s}=#{param.values.first}&"
      end
    end

  	base_url += "page_no="

  	if page_no.to_i > 1
  		prv_herf = base_url + prv_page.to_s
  		prv_link = "<a href=#{prv_herf}> <i class='am-icon-angle-left'></i>上一页</a>"
  	else
  		prv_link = ''
  	end

  	if page_count.to_i >= 2 && page_no.to_i < page_count.to_i
  		next_herf = base_url + next_page.to_s
  		next_link = "<a href=#{next_herf}>下一页<i class='am-icon-angle-right'></i></a>"
  	else
  		next_link =''
  	end

  	pag_str = "<ul class='mui-flex justify'>"+
        		  	'<li>'+prv_link+'</li>'+
        		  	'<li><span>'+ "#{page_no}/#{page_count}" +'</span></li>'+
        		  	'<li>'+next_link+'</li>'+
        		  '</ul>'
		 
		pag_str.html_safe  
  end


  def render_markdown(text)
    MyMarkdown.render_markdown(text)
  end
end
