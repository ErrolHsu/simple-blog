module ApplicationHelper


  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      language ||= :plaintext
      CodeRay.scan(code, language).div
    end
  end
  
  def markdown(text)
    coderayified = CodeRayify.new(:filter_html => true, 
                                  :hard_wrap => true)
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :autolink => true,
      :strikethrough => true,
      :lax_html_blocks => true,
      :superscript => true
    }
    markdown_to_html = Redcarpet::Markdown.new(coderayified, options)
    markdown_to_html.render(text).html_safe
  end


  def full_title(page_title= "")
    if @user && !@user.new_record?
      if page_title.blank?
        @user.title
      else  
        "#{@user.title} - #{page_title}"
      end  
    else
      "$&!$#%#$%"
    end   
  end


  def gravatar_for(user, size: 80, id: "")
    user = user.gravatar? ? user : User.first   
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, id: id)
  end

  def gravatar_now
    if current_user.gravatar?
      gravatar_for(current_user)
    else
      gravatar_for(User.first)
    end 
  end

  def show_link_if(condition, name = nil, options = nil, html_options = nil, &block)
  	if condition
  		link_to name, options, html_options, &block
  	end	 
  end

  def hidden_box(size, option)
    content_tag :div, "", class: " hidden-#{option} box-hidden-#{size}"
  end



end
