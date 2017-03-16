
class ProductDecorator < Drape::Decorator
  include Drape::LazyHelpers
  include ApplicationHelper
  #include Draper::LazyHelpers

  delegate_all

  def show_price
    self.price.to_s + " " + self.price_unit
  end

  def on_measure_rule
    if self.on_measure == false
      html = image_tag('icons/size-unic.png')
      html << content_tag(:h4, t('shop.show.not_on_measure'))
      html.html_safe
    else
      html = image_tag('icons/size-custom.png')
      html << content_tag(:h4, t('shop.show.on_measure'))
      html.html_safe
    end
  end

  def unic_fabric_rule
    if self.unic_fabric == true
      html = image_tag('icons/fabric-unic.png')
      html << content_tag(:h4, t('shop.show.unic_fabric'))
      html.html_safe
    else
      html = image_tag('icons/fabric-custom.png')
      html << content_tag(:h4, t('shop.show.custom_fabric'))
      html.html_safe
    end
  end

  def show_title
    html = content_tag(:h3, self.title)
    html << content_tag(:h3, self.serial)
    html.html_safe
  end

end