class ProductDecorator < Drape::Decorator
  include Drape::LazyHelpers
  include ApplicationHelper

  delegate_all

  def show_confection_price
    self.confection_price.to_s + " " + self.price_unit.title
  end

  def on_measure_rule
    if self.on_measure == false
      html = image_tag('icons/size-unic.png')
      html << content_tag(:h5, t('products.not_on_measure'))
      html.html_safe
    else
      html = image_tag('icons/size-custom.png')
      html << content_tag(:h5, t('products.on_measure'))
      html.html_safe
    end
  end

  def unic_fabric_rule
    if self.custom_fabric == false
      html = image_tag('icons/fabric-unic.png')
      html << content_tag(:h5, t('products.unic_fabric'))
      html.html_safe
    else
      html = image_tag('icons/fabric-custom.png')
      html << content_tag(:h5, t('products.custom_fabric'))
      html.html_safe
    end
  end

  def show_title
    html = content_tag(:h3, self.title)
    html << content_tag(:h3, self.serial)
    html.html_safe
  end

end