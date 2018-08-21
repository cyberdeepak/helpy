module EmailHelper
  def email_image_tag(image, **options)
    attachments[image] = File.read(Rails.root.join("app/assets/images/#{image}"))
    image_tag attachments[image].url, **options
  end

  # replace tokens with active content
  def footer_tokens(text)
    text.gsub('%ticket_link%', "#{t('view_online', default: 'View this online:')} #{ticket_url(@topic, host: AppSettings['settings.site_url'])}")
  end

  def body_tokens(text, user)
    text.gsub('%customer_name%', user.name)
  end
end
