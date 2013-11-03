class Redcarpet::Render::BacuHTML < Redcarpet::Render::HTML
  include BacuMarkdownHelper
  include ActionView::Helpers::TagHelper

  def header(text, level)
    level += 1
    "<h#{level}>#{text}</h#{level}>"
  end

  def postprocess(full_document)
    # autolink (original implementation because recarpet's one is broken)
    full_document.gsub!(/([^'"])(https?:\/\/[0-9a-zA-Z.\/?=&_]+)/, '\1<a href="\2">\2</a>')

    # font
    full_document.gsub!(/&amp;color\((.+?)\){(.+?)};/, '<font color="\1">\2</font>')
    full_document.gsub!(/&amp;size\((.+?)\){(.+?)};/, '<font size="\1">\2</font>')

    # comment out
    full_document.gsub!(/^\/\/.*$/, '')
    full_document.gsub!(/([^:])\/\/.*$/, '\1')

    full_document
  end
end
