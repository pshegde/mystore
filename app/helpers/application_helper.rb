module ApplicationHelper
  def hidden_div_if (condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block) #wrap output of attr in div tag with id passed in and that contains the block
  end
end
